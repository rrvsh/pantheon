This flake uses the [files flake-parts module](https://flake.parts/options/files.html) to generate documentation.
The list of generated files are:

The option `text.<name> supports either a string or a submodule with attributes order and parts. The parts attribute can either be a string, which will get concatenated in the order laid out in `text.<name>.order`, or can itself have the attributes order and parts, in which case it will be evaluated recursively.