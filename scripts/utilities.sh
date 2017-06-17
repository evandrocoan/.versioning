#!/usr/bin/env bash


# Install the configuration file, when it does not exists
# printf "Running the utilities.sh installer...\n"


# Reliable way for a bash script to get the full path to itself?
# http://stackoverflow.com/questions/4774054/reliable-way-for-a-bash-script-to-get-the-full-path-to-itself
pushd `dirname $0` > /dev/null
SCRIPT_FOLDER_PATH=`pwd`
popd > /dev/null

# Whether we are dealing with a git-submodule or not, this get the correct git file path for the
# project root folder if run on it directory, or for the sub-module folder if run on its directory.
cd $SCRIPT_FOLDER_PATH
cd ../..
GIT_DIR_="$(git rev-parse --git-dir)"
gitHooksPath="$GIT_DIR_/hooks"

# Get the submodule (if any) or the main's repository root directory. Given:
# pathToSubmodule=$(python -c "import os.path; print os.path.relpath('$PROJECT_ROOT_DIRECTORY', '$GIT_DIR_')")
#
# D:/User/Dropbox/Applications/SoftwareVersioning/SublimeText/Data/Packages/.git/modules/amxmodx (GIT_DIR_)
# D:/User/Dropbox/Applications/SoftwareVersioning/SublimeText/Data/Packages/amxmodx (PROJECT_ROOT_DIRECTORY)
#
# Returns: ../../../amxmodx
PROJECT_ROOT_DIRECTORY=$(git rev-parse --show-toplevel)

configuration_file=$1

REPOSITORY_ROOT_FOLDER_PATH=$GIT_DIR_/..
VERSIONING_TEMPLATE_FILE_NAME=gitHooksConfigTemplate.txt

# echo
# echo "pwd                             : $(pwd)"
# echo "GIT_DIR_                        : $GIT_DIR_"
# echo "gitHooksPath                    : $gitHooksPath"
# echo "configuration_file              : $configuration_file"
# echo "SCRIPT_FOLDER_PATH              : $SCRIPT_FOLDER_PATH"
# echo "PROJECT_ROOT_DIRECTORY          : $PROJECT_ROOT_DIRECTORY"
# echo "REPOSITORY_ROOT_FOLDER_PATH     : $REPOSITORY_ROOT_FOLDER_PATH"
# echo "VERSIONING_TEMPLATE_FILE_NAME   : $VERSIONING_TEMPLATE_FILE_NAME"


# How to find whether or not a variable is empty in Bash script
# https://stackoverflow.com/questions/3061036/how-to-find-whether-or-not-a-variable-is-empty-in-bash-script
if [[ -z "$configuration_file" ]]
then
    printf "\nERROR! This script first command line parameter must to be from valid setup files.\n"
    printf "Usage:\n"
    printf "./install_githooks.sh configuration_file_name.cfg\n"
    printf "\n"
    exit 1
fi

configuration_file_path=$REPOSITORY_ROOT_FOLDER_PATH/$configuration_file
configuration_file_template_path=$SCRIPT_FOLDER_PATH/$VERSIONING_TEMPLATE_FILE_NAME

if ! [ -f "$configuration_file_path" ]
then
    printf "Installing the configuration file...\n\n"
    if ! cp -v "$configuration_file_template_path" "$configuration_file_path"
    then
        printf "\nERROR when installing \`$VERSIONING_TEMPLATE_FILE_NAME\` file from:\n"
        printf "\`$configuration_file_template_path\` to \`$configuration_file_path\`.\n"
        exit 1
    fi
fi


# Goes back to its initial folder
cd - > /dev/null

# Exits the program using a successful exit status code.
exit 0



