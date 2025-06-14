[
  {
    desc = "Open the file path under the cursor, making the file if it doesn't exist.";
    key = "gf";
    mode = "n";
    action = ":cd %:p:h<CR>:e <cfile><CR>";
    silent = true;
  }
  {
    desc = "";
    key = "<C-u>";
    mode = "n";
    action = "<C-u>zz";
    silent = true;
  }
  {
    desc = "";
    key = "<C-d>";
    mode = "n";
    action = "<C-d>zz";
    silent = true;
  }
]
