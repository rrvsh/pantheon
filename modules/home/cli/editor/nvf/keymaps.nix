[
  {
    desc = "Open the file path under the cursor, making the file if it doesn't exist.";
    key = "gf";
    mode = "n";
    action = ":cd %:p:h<CR>:e <cfile><CR>";
    silent = true;
  }
]
