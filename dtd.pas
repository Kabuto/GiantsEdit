unit dtd;

interface

uses
  SysUtils;

type
  tDTDCount=(dAny,dOnce,dOptional,dMultiple);
  tBasicType=(bInvalid,bByte,bInt32,bSingle,bString,bVoid);
  tDTDNode=class;
  tDTDSubNode=record
    node :tDTDNode;
    nodename :string;
    name :string;
    typ :tDTDCount
  end;
  tDTDSubLeaf=record
    leaf :tBasicType;
    leafname :string;
    name :string;
    typ :tDTDCount;
  end;
  tDTDNode=class
    Name :string;
    Subnode :array of tDTDSubNode;
    Subleaf :array of tDTDSubLeaf;
  end;
  tDTDNodeList = array of tDTDNode;

function LoadDTD(filename :string):tDTDNodeList;

implementation

function LoadDTD(filename :string):tDTDNodeList;
  var
    t :text;
    i,j,k,l :integer;
    s,s2 :string;
  begin
    Assign(t,filename);
    Reset(t);
    l := -1;
    repeat
      Readln(t,s);
      s := Trim(s);
      if s='' then continue;
      if (s[length(s)]='{') then begin
        if l<>-1 then
          ; // error: too many {
        if copy(s,1,5)<>'Node ' then begin
          // error: invalid node header
          continue;
        end;
        s := Trim(copy(s,6,length(s)-6));
        l := length(Result);
        SetLength(Result,l+1);
        Result[l] := tDTDNode.Create;
        Result[l].Name := s
      end
      else if (s='}') then begin
        if l=-1 then
          // error: } without {
        else
          l := -1;
      end
      else if copy(s,1,5)='Node ' then begin
        s := trim(copy(s,6,length(s)-5));
        i := 1;
        while (i<=length(s)) and (s[i]>' ') do
          inc(i);
        if i>length(s) then begin
          // error: not enough node parameters
          continue;
        end;
        s2 := trim(copy(s,1,i));
        s := trim(copy(s,i+1,length(s)-i));

        k := length(Result[l].subnode);
        SetLength(Result[l].subnode,k+1);
        Result[l].subnode[k].nodename := s2;
        if s[1]='"' then begin // spezieller Name
          i := 2;
          while (i<=length(s)) and (s[i]<>'"') do
            inc(i);
          if i>length(s) then begin
            // error: unterminated string
            continue;
          end;
          s2 := trim(copy(s,1,i));
          s := trim(copy(s,i+1,length(s)-i));
          Result[l].subnode[k].name := copy(s2,2,length(s2)-2);
        end
        else
          Result[l].subnode[k].name := Result[l].subnode[k].nodename;
        if s='any' then Result[l].subnode[k].typ := dAny
        else if s='once' then Result[l].subnode[k].typ := dOnce
        else if s='optional' then Result[l].subnode[k].typ := dOptional
        else if s='multiple' then Result[l].subnode[k].typ := dMultiple
        else ;// error: unknown count arg
      end
      else if copy(s,1,5)='Leaf ' then begin
        s := trim(copy(s,6,length(s)-5));
        i := 1;
        while (i<=length(s)) and (s[i]>' ') do
          inc(i);
        if i>length(s) then begin
          // error: not enough node parameters
          continue;
        end;
        s2 := trim(copy(s,1,i));
        s := trim(copy(s,i+1,length(s)-i));

        k := length(Result[l].subleaf);
        SetLength(Result[l].subleaf,k+1);
        Result[l].subleaf[k].leafname := s2;
        if s[1]='"' then begin // spezieller Name
          i := 2;
          while (i<=length(s)) and (s[i]<>'"') do
            inc(i);
          if i>length(s) then begin
            // error: unterminated string
            continue;
          end;
          s2 := trim(copy(s,1,i));
          s := trim(copy(s,i+1,length(s)-i));
          Result[l].subleaf[k].name := copy(s2,2,length(s2)-2);
        end
        else
          Result[l].subleaf[k].name := Result[l].subleaf[k].leafname;
        if s='any' then Result[l].subleaf[k].typ := dAny
        else if s='once' then Result[l].subleaf[k].typ := dOnce
        else if s='optional' then Result[l].subleaf[k].typ := dOptional
        else if s='multiple' then Result[l].subleaf[k].typ := dMultiple
        else ;// error: unknown count arg
      end;
    until eof(t);
    // second step: link the list
    // 1. check for double names

    for i := 0 to length(Result)-2 do
      for j := i+1 to length(Result)-1 do
        if Result[i].name = Result[j].name then
          ; // error: node declared twice

    // 2. fill in the links
    for i := 0 to length(Result)-1 do
      for j := 0 to length(Result[i].subnode)-1 do begin
        Result[i].subnode[j].node := nil;
        for k := 0 to length(Result)-1 do
          if Result[k].name = Result[i].subnode[j].nodename then
            Result[i].subnode[j].node := Result[k];
        if Result[i].subnode[j].node = nil then
          ; // error: unknown node
      end;

    // 3. fill in basic types
    for i := 0 to length(Result)-1 do
      for j := 0 to length(Result[i].subleaf)-1 do begin
        Result[i].subleaf[j].leaf := bInvalid;
        if Result[i].subleaf[j].leafname = 'byte' then Result[i].subleaf[j].leaf := bByte;
        if Result[i].subleaf[j].leafname = 'int32' then Result[i].subleaf[j].leaf := bInt32;
        if Result[i].subleaf[j].leafname = 'single' then Result[i].subleaf[j].leaf := bSingle;
        if Result[i].subleaf[j].leafname = 'string' then Result[i].subleaf[j].leaf := bString;
        if Result[i].subleaf[j].leafname = 'void' then Result[i].subleaf[j].leaf := bVoid;
{        if Result[i].subleaf[j].leafname = 'Lstring0' then Result[i].subleaf[j].leaf := bLstring0;
        if Result[i].subleaf[j].leafname = 'string32' then Result[i].subleaf[j].leaf := bstring32;
        if Result[i].subleaf[j].leafname = 'string16' then Result[i].subleaf[j].leaf := bstring16;}
        if Result[i].subleaf[j].leaf = bInvalid then
          ; // error: invalid leaf type

      end;

  end;

end.
