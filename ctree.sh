#!/bin/bash

mainDirSymbol='$'
folderIcon='📂'
indentSymbol='│'
branchSymbol='├──'
endBranchSymbol='└──'
emptyFolderSymbol='.'

# Function to print the tree structure
tree() {
    indent=0
    mainDir=1
    processDir "$1"
}

# Function to process directories and files
processDir() {
    indentString=""
    for ((i = 1; i <= indent; i++)); do
        indentString="$indentString$indentSymbol   "
    done
    if [ $indent -ne 0 ]; then
        if [ -z "$1" ]; then
            echo "$indentString$branchSymbol $mainDirSymbol $folderIcon $emptyFolderSymbol"
        else
            echo "$indentString$branchSymbol $mainDirSymbol $folderIcon ${1##*/}"
        fi
    else
        if [ -z "$1" ]; then
            echo "$indentString$branchSymbol $mainDirSymbol $folderIcon $emptyFolderSymbol"
        else
            echo "$indentString$branchSymbol $mainDirSymbol $folderIcon ${1##*/}"
        fi
    fi
    ((indent++))
    cd "$1" || return
    lastDir=""
    for d in */; do
        lastDir="$d"
    done
    for f in *; do
        processFile "$f"
    done
    for d in */; do
        if [ -d "$d" ]; then
            processSubDir "$d"
        fi
    done
    cd ..
    ((indent--))
}

# Function to process subdirectories
processSubDir() {
    indentString=""
    for ((i = 1; i <= indent; i++)); do
        indentString="$indentString$indentSymbol   "
    done
    echo "$indentString$branchSymbol $mainDirSymbol $folderIcon ${1%%/}"
    ((indent++))
    cd "$1" || return
    for f in *; do
        processFile "$f"
    done
    for d in */; do
        if [ -d "$d" ]; then
            processSubDir "$d"
        fi
    done
    cd ..
    ((indent--))
}

# Function to process files
processFile() {
    indentString=""
    for ((i = 1; i <= indent; i++)); do
        indentString="$indentString$indentSymbol   "
    done
    if [ ! -e "$1" ]; then
        return
    fi
    lastFile=""
    for f in *; do
        lastFile="$f"
    done
    if [ "$lastFile" != "$1" ]; then
        echo "$indentString$branchSymbol $1"
    else
        echo "$indentString$endBranchSymbol $1"
    fi
}

# Starting point of the script
tree "$1"