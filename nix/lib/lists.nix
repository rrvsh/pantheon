let
  inherit (builtins) length tail;
in
{
  flake.lib.lists = rec {
    shortenList =
      count: list:
      let
        len = length list;
      in
      if len <= count then list else (shortenList count (tail list));
  };
}
