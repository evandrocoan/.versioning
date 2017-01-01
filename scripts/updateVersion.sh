#!/usr/bin/env bash


#
# This file must be ran from the main repository folder. It updates the software version number
# indicated at "filePathToUpdate" and "versionFilePath". The versions at these two files must to be
# synchronized for a correct version update.
#
# You can also update the version manually, but you must to update both files:
# "$AUTO_VERSIONING_ROOT_FOLDER_NAME/VERSION.txt" and "./project_folder/project_file.txt" using
# the same version number.
#
# Program usage: updateVersion [major | minor | patch | build]
# Example: ./updateVersion build
#
#



# This script is run straight from the project's git root folder, as the current working directory.
printf "Running the updateVersion.sh script...\n"


# Reliable way for a bash script to get the full path to itself?
# http://stackoverflow.com/questions/4774054/reliable-way-for-a-bash-script-to-get-the-full-path-to-itself
pushd `dirname $0` > /dev/null
SCRIP_FOLDER_PATH=`pwd`
popd > /dev/null

# Get the submodule (if any) or the main's repository root directory
PROJECT_ROOT_DIRECTORY=$(git rev-parse --show-toplevel)


# Read the configurations file.
configurationFileName=githooksConfig.txt
configurationFilePath=$SCRIP_FOLDER_PATH/../../$configurationFileName

if [ -f $configurationFilePath ]
then
    gitHooksConfiguration=$(cat $configurationFilePath)
else
    printf "Creating the configuration file '$configurationFilePath'...\n"
    cp $SCRIP_FOLDER_PATH/$configurationFileName $SCRIP_FOLDER_PATH/../../
    exit 1
fi

# $versionFilePath example: $SCRIP_FOLDER_PATH/GALILEO_SMA_VERSION.txt
versionFilePath=$PROJECT_ROOT_DIRECTORY/$(echo $gitHooksConfiguration | cut -d',' -f 1 | tr -d ' ')

# $filePathToUpdate example: $PROJECT_ROOT_DIRECTORY/scripting/galileo.sma
filePathToUpdate=$PROJECT_ROOT_DIRECTORY/$(echo $gitHooksConfiguration | cut -d',' -f 2 | tr -d ' ')

# Get the current version from the dedicated versioning file.
if [ -f $versionFilePath ]
then
    currentVersion=$(cat $versionFilePath)
else
    printf "Creating the configuration file '$versionFilePath'...\n"
    printf "1.0.0-1" > $versionFilePath
    exit 1
fi

originalVersion=$currentVersion
component=$1


# 'cut' Print selected parts of lines from each FILE to standard output
#
# '-d' use another delimiter instead of TAB for field delimiter.
# '-f' select only these fields.
#
major=$(echo $currentVersion | cut -d'.' -f 1)
minor=$(echo $currentVersion | cut -d'.' -f 2)
patch=$(echo $currentVersion | cut -d'.' -f 3 | cut -d'-' -f 1)
build=$(echo $currentVersion | cut -d'-' -f 2)


if [ -z "${major}" ] || [ -z "${minor}" ] || [ -z "${patch}" ] || [ -z "${build}" ]
then
    printf "VAR <$major>.<$minor>.<$patch>-<$build> is bad set or set to the empty string\n"
    exit 1
fi


case "$component" in
    major )
        major=$(expr $major + 1)
        minor=0
        patch=0
        ;;

    minor )
        minor=$(expr $minor + 1)
        patch=0
        ;;

    patch )
        patch=$(expr $patch + 1)
        ;;

    build )
        build=$(expr $build + 1)
        ;;

    * )
        printf "Error - argument must be 'major', 'minor', 'patch' or 'build'\n"
        printf "Usage: updateVersion [major | minor | patch | build]\n"
        printf "\n"
        printf "Semantic Versioning 2.0.0\n"
        printf "\n"
        printf "Given a version number MAJOR.MINOR.PATCH, increment the:\n"
        printf "\n"
        printf "MAJOR version when you make incompatible API changes,\n"
        printf "MINOR version when you add functionality in a backwards-compatible manner, and\n"
        printf "PATCH version when you make backwards-compatible bug fixes.\n"
        printf "Additional labels for pre-release and build metadata are available as extensions to\n"
        printf "the MAJOR.MINOR.PATCH format.\n"
        printf "\n"

        exit 1
        ;;
esac


currentVersion=$major.$minor.$patch-$build


# To prints a error message when it does not find the version number on the file.
#
# 'F' affects how PATTERN is interpreted (fixed string instead of a regex).
# 'q' shhhhh... minimal printing.
#
if ! grep -Fq "v$originalVersion" "$filePathToUpdate"
then
    printf "Error! Could not find v$originalVersion and update the file '$filePathToUpdate'.\n"
    printf "The current version number on this file must be v$originalVersion!\n"
    printf "Or fix the file '$versionFilePath' to the correct value.\n"
    exit 1
fi


if sed -i -- "s/v$originalVersion/v$currentVersion/g" $filePathToUpdate
then
    printf "Replacing the version v$originalVersion -> v$currentVersion in '$filePathToUpdate'\n"

    # Replace the file with the $versionFilePath with the $currentVersion.
    echo $currentVersion > $versionFilePath
else
    printf "ERROR! Could not replace the version v$originalVersion -> v$currentVersion in '$filePathToUpdate'\n"
    exit 1
fi


# Fix line endings
if awk '/\r$/{exit 0;} 1{exit 1;}' $filePathToUpdate
then
    printf "( CRLF ) The file $filePathToUpdate is uses CRLF.\n"
    dos2unix $filePathToUpdate
else
    printf "( LF ) The file $filePathToUpdate is uses LF.\n"
    unix2dos $filePathToUpdate
fi


# To add the recent updated files to the commit
printf "Staging '$versionFilePath'...\n"
printf "Staging '$filePathToUpdate'...\n"
git add $versionFilePath
git add $filePathToUpdate


# Exits the program using a successful exit status code.
exit 0


