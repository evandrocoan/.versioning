
# Automated Versioning Script

Automatically updates the version number for your project files.

Open the file "githooksConfig.txt" to configure the files to be used and updated when the program
"./updateVersion.sh" to run. To install it as an automated git versioning on every commit, run
the installer `install_githooks.sh`.



### Installing

To run the versioning script, you need to:

1. You could fork this repository before install it into your project and add as a submodule.
1. You could just do download this repository files and commit them with your project files.
1. You could clone this repository on yours git repository main's root folder.
Add this repository folder to your's main repository `.gitignore` file as:
```
/versioning/*
```
Replace the `versioning` name by your's clones name for this repository.



### Running it

For automated versioning when doing git commits/committing:

1. Run the `git hooks` installer script `install_githooks.sh`. And re-run the installer
`install_githooks.sh` every time you rename the folder where this repository is cloned into.
1. Run the script `updateVersion.sh` and read the instructions.

Program usage: 
```
./updateVersion.sh [major | minor | patch | build]
```
Example:

1. `./updateVersion` to show help.
1. `./updateVersion build` to increment the build number.



___
## Semantic Versioning 2.0.0

Given a version number MAJOR.MINOR.PATCH, increment the:

1. MAJOR version when you make incompatible API changes,
1. MINOR version when you add functionality in a backwards-compatible manner, and
1. PATCH version when you make backwards-compatible bug fixes.

Additional labels for pre-release and build metadata are available as extensions to the
MAJOR.MINOR.PATCH format.

http://semver.org/



##### Learn more about git hooks on the following links:

1. https://git-scm.com/docs/githooks
2. https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks




