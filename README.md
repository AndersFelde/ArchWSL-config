# Arch WSL config

## WSL

> In powershell with administrator rights

```powershell
wsl --install
wsl --set-default-version 2
```

Restart the computer

> Tip: Ubuntu is installed by default (why?), to uninstall run `wsl --unregister Ubuntu`

### Debugging

If you get this error:

```
Please enable the Virtual Machine Platform Windows feature and ensure virtualization is enabled in the BIOS.
```

Run in windows powershell (with admin rights)

```powershell
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

Restart computer

If it still does not work, ensure that virtualization is enabled in BIOS

## Install

#### 1. [Download](https://github.com/yuk7/ArchWSL/releases/latest) installer zip file.

#### 2. Extract all files in the zip file to the same directory.

Please extract to a folder that you have full access permission.
For example, 'Program Files' can not be used.

#### 3. Run Arch.exe to Extract rootfs and Register to WSL.

Also, the name of the EXE file is used as the name of your WSL instance.
That means, if you copy multiple EXE files and rename them to different names, you can have multiple different ArchWSL at the same time without conflict.

## Config

#### Set up the enviroment

> In Arch.exe

```bash
sh -c "$(curl https://raw.githubusercontent.com/AndersFelde/ArchWSL-config/main/install.sh)"
```

#### Set your user as default user

> In powershell in directory where you unzipped "Arch.zip"

```powershell
.\Arch.exe config --default-user YourUsername
```

## Windows Terminal

Install from Microsoft Store: [Windows Terminal](https://www.microsoft.com/en-us/p/windows-terminal/9n0dx20hk701?activetab=pivot:overviewtab)

#### Fonts

Download [Caskadia Cove (font)](https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/CascadiaCode.zip)

Unzip the folder

Right click the file `Caskaydia Cove Nerd Font Complete Windows Compatible.ttf` and install

#### Windows Terminal Settings

Open JSON file

Add Argonaut to "schemes" [argonaut.json](https://raw.githubusercontent.com/AndersFelde/ArchWSL-config/main/argonaut.json)

Set Argonaut as default colorscheme for Arch

> [How to add custom colorscheme in Windows Terminal](https://aavtech.site/2020/03/how-to-change-the-color-scheme-in-the-new-windows-terminal/#third-party-theme)

Set CaskadyiaCove Nerd Font as default Font face for Arch

## Paru

> Paru is now used instead of Pacman to install and update packages

#### Update all packages

```bash
paru
```

#### Install

```bash
paru NameOfPackage
```

Then choose the package you want to install by pressing the coresponding number (usually 1)

> Tip: if a file is opened after starting the install, press "q" to exit the file and continue installing

#### Remove

```bash
paru -Rs NameOfPackage
```

## Run GUI apps from WSL 2 (optional)

[How to run GUI apps from wsl](https://docs.microsoft.com/en-us/windows/wsl/tutorials/gui-apps)

It should work out of the box for Windows 2200 Build og higher

Install for example gedit to install required software: `paru gedit`
