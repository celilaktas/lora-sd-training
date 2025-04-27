::@echo off

::%~d0
::cd %~d0\AI

::set GIT=%~dp0bin\PortableGit-2.35.1.2-64-bit\bin\git.exe

%GIT% clone --recurse-submodules https://github.com/bmaltais/kohya_ss.git kohya

echo ------------------------------
echo Python VENV

set VENVDIR=.venv

c:\Python3.10.6\python.exe -m venv %VENVDIR%

set VENVDIR=%~d0/AI/kohya/venv
call %VENVDIR%/Scripts/activate.bat

python --version

::python -m pip install --upgrade pip
::python -m pip install -r kohya/requirements_windows.txt

pause