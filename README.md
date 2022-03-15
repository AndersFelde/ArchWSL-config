# Arch WSL config

## WSL

> In powershell with administrator rights

```powershell
wsl --install
wsl --set-default-version 2
```

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
curl https://raw.githubusercontent.com/AndersFelde/ArchWSL-config/main/install.sh | /bin/bash
```

#### Set your user as default user

> In powershell

```bash
Arch.exe config --default-user YourUsername
```

## Windows Terminal

Install from Microsoft Store: [Windows Terminal](https://www.microsoft.com/en-us/p/windows-terminal/9n0dx20hk701?activetab=pivot:overviewtab)

#### Fonts

Download [Caskadia Cove (font)](https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/CascadiaCode.zip)

Unzip and install `Caskaydia Cove Nerd Font Complete Windows Compatible.ttf`

#### Windows Terminal Settings

Open JSON file

Add Argonaut to "schemes" [argonaut.json](https://raw.githubusercontent.com/AndersFelde/ArchWSL-config/main/argonaut.json)

Set Argonaut as default colorscheme for Arch

> [How to add custom colorscheme in Windows Terminal](https://aavtech.site/2020/03/how-to-change-the-color-scheme-in-the-new-windows-terminal/)

Set CaskadyiaCove Nerd Font as default Font face for Arch
