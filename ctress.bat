@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

set "mainDirSymbol=$"
set "folderIcon=📂"
set "indentSymbol=│"
set "branchSymbol=├──"
set "endBranchSymbol=└──"
set "emptyFolderSymbol=."

REM Function to print the tree structure
:tree
set "indent=0"
set "mainDir=1"
call :processDir %1
goto :eof

REM Function to process directories and files
:processDir
set "indentString="
for /l %%i in (1,1,%indent%) do set "indentString=!indentString!!indentSymbol!   "
if not "%indent%"=="0" (
    if "%~n1"=="" (
        echo %indentString%!branchSymbol! %mainDirSymbol% %folderIcon% %emptyFolderSymbol%
    ) else (
        echo %indentString%!branchSymbol! %mainDirSymbol% %folderIcon% %~n1
    )
) else (
    if "%~n1"=="" (
        echo %indentString%!branchSymbol! %mainDirSymbol% %folderIcon% %emptyFolderSymbol%
    ) else (
        echo %indentString%!branchSymbol! %mainDirSymbol% %folderIcon% %~n1
    )
)
set /a "indent+=1"
pushd %1
set "lastDir="
for /f "delims=" %%d in ('dir /b /ad') do set "lastDir=%%d"
for /f "tokens=*" %%f in ('dir /b /a-d 2^>nul') do (
    call :processFile "%%f"
)
for /d %%d in (*) do (
    call :processSubDir "%%d"
)
popd
set /a "indent-=1"
goto :eof

REM Function to process subdirectories
:processSubDir
set "indentString="
for /l %%i in (1,1,%indent%) do set "indentString=!indentString!!indentSymbol!   "
echo %indentString%!branchSymbol! %mainDirSymbol% %folderIcon% %~n1
set /a "indent+=1"
pushd %1
for /f "tokens=*" %%f in ('dir /b /a-d 2^>nul') do (
    call :processFile "%%f"
)
for /d %%d in (*) do (
    call :processSubDir "%%d"
)
popd
set /a "indent-=1"
goto :eof

REM Function to process files
:processFile
set "indentString="
for /l %%i in (1,1,%indent%) do set "indentString=!indentString!!indentSymbol!   "
set "lastFile="
if not exist "%1" (
    goto :eof
)
for /f "delims=" %%f in ('dir /b /a-d') do set "lastFile=%%f"
if not "%lastFile%"=="%~1" (
    echo %indentString%!branchSymbol! %~1
) else (
    echo %indentString%!endBranchSymbol! %~1
)
goto :eof