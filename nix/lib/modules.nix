{ lib, config, ... }:
let
  inherit (builtins) foldl' attrNames;
  inherit (lib.attrsets) mapAttrs;
in
{
  flake.lib.modules = {
    /**
      Fold over the users list and create an attribute set.

      # Inputs

      `f`

      : A function that takes the name of a user and returns an attribute set.

      # Type

      ```
      userListToAttrs :: (String -> AttrSet) -> AttrSet
      ```

      # Examples
      :::{.example}
      ## `userListToAttrs` usage example

      ```nix
      flake.manifest.users.rafiq = { ... };
      flake.modules.homeManager.users = userListToAttrs (name: {
        ${name}.home.username = name;
      });
      => flake.modules.homeManager.default.users.rafiq.home.username = "rafiq";
      ```

      :::
    */
    userListToAttrs = f: foldl' (acc: elem: acc // (f elem)) { } (attrNames config.manifest.users);
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
    forAllUsers = attrset: mapAttrs (_: _: attrset) config.manifest.users;

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
    forAllUsers' = f: mapAttrs f config.manifest.users;
  };
}
