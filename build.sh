#!/bin/bash

FILE=$(cat << EOF 
build.sh - build the project

build.sh [options]
                    
options:
    -h, --help                show brief help
    -c, --clean               clean the project
    -r, --release             build the project in release mode
    -x, --copy-to-wow         copy the build to the wow addons folder
    -n, --name                the name of the package to build
    -v, --version             the version of the package to build
    -d, --build-dir           the directory to build the project in
    -o, --output-dir          the directory to output the build to
    -w, --wow-dir             copy the build to the specified location
    -f, --toc-file            the toc file to use
    -i, --interface-version   the interface version to use
EOF
)

# Default flags
CLEAN=0
RELEASE=0
COPY_TO_WOW=0
NAME="",
VERSION=$(cat VERSION.txt)
BUILD_DIR="build"
OUTPUT_DIR="dist"
COPY_TO_WOW=0
WOW_DIR="/Applications/World of Warcraft/_retail_"
TOC_FILE="template.toc"
INTERFACE_VERSION="100000"

while test $# -gt 0; do
    case "$1" in
        -h|--help) 
            echo "$FILE"
            exit 0
            ;;
        -c|--clean)
            CLEAN=1
            ;;
        -r|--release)
            RELEASE=1
            ;;
        -x|--copy-to-wow)
            COPY_TO_WOW=1
            ;;
        -n|--name)
            NAME=$2
            ;;
        -v|--version)
            VERSION=$2
            ;;
        -d|--build-dir)
            BUILD_DIR=$2
            ;;
        -w|--wow-dir)
            WOW_DIR=$2
            ;;
        -o|--output-dir)
            OUTPUT_DIR=$2
            ;;
        -f|--toc-file)
            TOC_FILE=$2
            ;;
        -i|--interface-version)
            INTERFACE_VERSION=$2
            ;;
        *)
            break
            ;;
    esac
done

# Create the build directory

echo "Creating build directory: $BUILD_DIR"
if [ $CLEAN -eq 1 ]; then
    rm -rf "$BUILD_DIR"
    mkdir -p "$BUILD_DIR"
fi

# Parse the toc file

echo "Parsing toc file: $($TOC_FILE || 'template.toc')"

TOC

while IFS= read -r line; do
    if [[ $line == \#* ]]; then
        continue
    fi

    if [[ $line == Interface:* ]]; then
        INTERFACE_VERSION=$(echo $line | cut -d ':' -f 2)
        continue
    fi

    if [[ $line == Title:* ]]; then
        NAME=$(echo $line | cut -d ':' -f 2)
        continue
    fi

    if [[ $line == Version:* ]]; then
        VERSION=$(echo $line | cut -d ':' -f 2)
        continue
    fi

    TOC+="$line"
done < "$TOC_FILE"

# Archive files

echo "Archiving files to $BUILD_DIR/$ZIP_FILE.zip"

# Set TOC to the contents of a temporary file
TOC > "$BUILD_DIR/$NAME.toc"

zip -r "$BUILD_DIR/$NAME-$VERSION.zip" . \
-x "docs" \
"Icons" \
"Libs" \
"Locales" \
"Rings" \
"$BUILD_DIR/$NAME.toc" \
"*.lua" \
"*.xml" \
"*.txt" \
"*.md" 

# Exit if we're not copying to wow or release is not set

if [ $COPY_TO_WOW -eq 0 ] || [ $RELEASE -eq 0 ]; then
    echo "Build complete! ✔️"
    exit 0
fi

# Copy to wow

if [ "$COPY_TO_WOW" -eq 1 ] && [ "$RELEASE" -lt 1 ]; then
    echo "Copying to wow directory: $WOW_DIR/Interface/AddOns/$NAME"
    rm -rf "$WOW_DIR/Interface/AddOns/$NAME"
    unzip -o "$BUILD_DIR/$NAME.zip" -d "$WOW_DIR/Interface/AddOns/$NAME"
fi