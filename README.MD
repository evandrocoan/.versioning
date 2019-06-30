
# Automated Versioning Scripts

Automatically updates the version number for your project files.

Open the file [scripts/gitHooksConfigTemplate.txt](scripts/gitHooksConfigTemplate.txt) to configure the files to be used and updated when the program
"./update_version.sh" to run. To install it as an automated git versioning on every commit, run
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
1. Run the script `update_version.sh` and read the instructions.

Program usage:
```
./update_version.sh [major | minor | patch | build]
```
Example:

1. `./update_version` to show help.
1. `./update_version build` to increment the build number.



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



## Change log
```
2017-06-16 _ v3.1.0
Added a new setting option 5, to allow general settings configurations.
Moved the `updateVersion.sh` from ./scripts to `./update_version.sh`
Fixed the `githooksConfig.txt` name to `gitHooksConfigTemplate.txt`

2017-06-16 _ v3.0.1
Fixed the `install-githooks.sh` script install instructions.

2017-02-03 _ v3.0.0
Partially allowed multiple configurations files to be installed.

2016-01-01 _ v2.1.0
Allowed free folder renaming for the auto-versioning root folder.

2016-11-14 _ v2.0.0
Added installer script `install_githooks.sh`.
Removed redundant configurations from `gitHooksConfig.txt`.
Added a new setting to choose which branch is the target branch for auto versioning.

2016-11-14 _ v1.1.2
Added error message when the 'sed' operation fails.

2016-11-14 _ v1.1.1
Placed this file within the repository sub-folder "./$AUTO_VERSIONING_ROOT_FOLDER_NAME".

2016-11-14 _ v1.1.0
 Implemented build incrementing number.
 Created variables to hold the used files names.
 Added file search and replace to update the version numbers.

2016-11-14 _ v1.0.0
 Downloaded from: https://github.com/cloudfoundry/cli/blob/master/bin/bump-version
```


___
## License

All files in this repository are released under GNU General Public License v3.0
or the latest version available on http://www.gnu.org/licenses/gpl.html

See:

1. The [LICENSE](LICENSE) file for the GPL v3.0 license
1. The website https://www.gnu.org/licenses/gpl-3.0.en.html

For more information.



