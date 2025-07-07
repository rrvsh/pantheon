{ lib, ... }:
let
  inherit (builtins) attrNames head;
  inherit (lib.trivial) pipe;
  inherit (lib.attrsets) filterAttrs;
in
{
  flake.lib.attrsets = {
    /**
      `firstAttrNameMatching pred set` filters an attribute set `set` based on a predicate `pred`
      and returns the *first* attribute name that satisfies the predicate.

      # Example

      ```nix
      let
        mySet = {
          a = { value = 1; };
          b = { value = 2; };
          c = { value = 3; };
        };

        isGreaterThanOne = name: value: value.value > 1;

        result = firstAttrNameMatching isGreaterThanOne mySet;

      in
        result
      # Output: "b"
      ```

      # Type

      ```
      firstAttrNameMatching :: (String -> Any -> Bool) -> AttrSet -> String
      ```

      # Arguments

      pred
      : A function that takes an attribute name and its value and returns a boolean.

      set
      : The attribute set to filter.
    */
    firstAttrNameMatching =
      pred: set:
      pipe set [
        (filterAttrs pred)
        attrNames
        head
      ];
  };
}
