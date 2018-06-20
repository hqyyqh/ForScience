# ForScience
Mathematica paclet that includes many utility functions for general work & paclet development and helps with creating scientific plots.

## Motivation
This paclet started as a collection of useful functions and plot designs which we encountered in our daily life as students. We've polished them and made them accessible for everyone in this paclet. The paclet has since grown considerably in several areas.

## Content
For a full list of functions, see the paclet documentation in the documentation center. It features detailed descriptions and examples of every function.
> The documentation is an ongoing effort. Currently, only the PacletUtils subpaclet is fully documented, with more to come
The paclet is split into four sub-paclets:
### Util
General utility functions, including:
- `ImportDataset` - imports files or complex file structures into one Dataset
![ImportDataset](https://i.imgur.com/rf3JmDD.png)
- `ProgressReport` - progress report with automatic range detection and estimation of remaining time
![ProgressReport](https://i.imgur.com/VgilQA6.png)
- `IndexedFunction` - indexed `#` and `&`
![IndexedFunction](https://i.imgur.com/UGhljqm.png)
- `TableToTex`
- Many more
### PlotUtils
Everything related to creating nice looking plots. Polar plots are significantly more usable with this: Several bugs are fixed, including conflicts of `PlotMarkers->Automatic` and `Joined->True`, inconsistent sizes and more. The plot theme further removes the outermost tick label to prevent it from colliding with the angular axis.
- `"ForScience"` - plot theme with the goal to make more publication ready figures (work in progress)
![ForScience](https://i.imgur.com/UueGjRj.png)
- `Jet` - color scheme
![Jet](https://i.imgur.com/0aW6ojw.png)
### ChemUtils
- `"GROMOS"` - import format for files generated by the Molecular Dynamic program GROMOS
- `MoleculePlot3D` - plots custom molecules, similar to the ones provided by `ChemicalData`
![MoleculePlot3D](https://i.imgur.com/bhV3Qx7.png)
- Many more
### PacletUtils
Everything related to paclet development. Contains functions to automate build processes. Also contains the documentation building framework, that support creation of documentation pages. All documentation pages from the ForScience paclet are created using this framework.
- `FormatUsage` - creates nicely formatted usage string
![FormatUsage](https://i.imgur.com/zGeJx9c.png)
- `BuildPaclet` - paclet build manager
- `DocumentationBuilder` - builds high-quality documentation pages, just like the ones for built-in functions
![DocumentationBuilder](https://i.imgur.com/Y38jsi4.png)
- Many more

## Installation
### Latest release
- Download the latest .paclet file from [releases](https://github.com/MMA-ForScience/ForScience/releases)
- Execute `PacletInstall["path/to/paclet/ForScience-#.#.#.paclet"]` (with the appropriate path and version number)
- Package can now be loaded with ``<<ForScience` ``

### Latest version
- Download the zip (and uncompress it) of this repo or clone it to your computer
- Open build.nb with Mathematica
- Evaluate the notbook
- Check in a new notebook with `PacletFind[]` if it is installed correctly.
  (correct if it apears on top of the list)

## Prerequisites
None, exept a working Mathematica version, newer than 11.1.0
