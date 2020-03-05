unit gck;


interface
  uses
    Zlib;

type    
  tgckindex = record
    blockpos :integer;
    blocklen :integer;
    originallen :integer;
    name :string;
    kind :integer;
  end;
  tbytearray = array of byte;

  (*

  possible kinds of data are:

  0: any data
  1: readme
  2: ini/gmm file
  3: gti file
  4: w_*.bin file
  5: tga file
  6: jpg file (to be converted to tga upon decompression)
  7: jpg file (with an additional alpha channel)
  8: jpg file (alpha channel of a type 7 jpeg file)
  9: texturescript file (to be converted to tga)

  file name:
  can consist of letters (upper/lower case does not matter), numbers, underscore, spaces
  as well as high characters (127 thru 255) and the following special characters:
    !#$%&'()+,-.;=@[]^{}~

  not allowed are: \ / : * ? " < > |

  \ is used to separate directories in the file's path

  *)




implementation

end.
