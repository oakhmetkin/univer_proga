prompt = {"Width", "Height", "Depth"};
defaults = {"1.10", "2.20", "3.30"};
rowcols = [1.1 2.2 3.3];
dims = inputdlg(
  prompt,
  "Enter box dimensions",
  rowcols,
  defaults);

str2num(char(dims));
