{ lib, config, ... }:
let
  cfg = config.flake;
  inherit (lib.attrsets) mapAttrs concatMapAttrs;
in
{
  flake.lib = {
    /**
      Remove the top level attributes from an attribute set and return the merged attributes.

      # Inputs

      `attrset`

      : An attribute set to flatten.

      # Type

      ```
      flattenAttrs :: AttrSet -> AttrSet
      ```

      # Examples
      :::{.example}
      ## `flattenAttrs` usage example

      ```nix
      flattenAttrs { x = { a = 1; b = 2; }; y = { c = 3; d = 4; }; }
      => { a = 1; b = 2; c = 3; d = 4; }
      ```
    */
    flattenAttrs = attrset: concatMapAttrs (_: v: v) attrset;

    /**
      Return an attribute set for use with a option that needs to be used for all users.

      # Inputs

      `attrset`

      : An attribute set to apply to all the users.

      # Type

      ```
      forAllUsers :: AttrSet -> AttrSet
      ```

      # Examples
      :::{.example}
      ## `forAllUsers` usage example

      ```nix
      flake.manifest.users.rafiq = { ... };
      flake.modules.nixos.default.users = forAllUsers {
        isNormalUser = true;
      };
      => flake.modules.nixos.default.users.rafiq.isNormalUser = true;
      ```

      :::
    */
    forAllUsers = attrset: mapAttrs (_: _: attrset) cfg.manifest.users;

    /**
      Like forAllUsers, but passes in the name and value from the manifest.

      # Inputs

      `f`

      : A function that takes an attribute name and its value, and returns the new value for the attribute.

      # Type

      ```
      forAllUsers' :: (String -> Any -> Any) -> AttrSet
      ```

      # Examples
      :::{.example}
      ## `forAllUsers'` usage example

      ```nix
      flake.manifest.users.rafiq = { ... };
      flake.modules.homeManager.users = forAllUsers' (name: value: {
        home.username = name;
      });
      => flake.modules.homeManager.default.users.rafiq.home.username = "rafiq";
      ```

      :::
    */
    forAllUsers' = f: mapAttrs f cfg.manifest.users;
  };
}
