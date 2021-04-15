# Install IDOL Media Server

Use script to install IDOL Media Server from the component `.zip` files.

<!-- TOC depthFrom:2 -->

- [Download IDOL components](#download-idol-components)
- [Install](#install)
  - [Windows](#windows)
  - [Ubuntu](#ubuntu)

<!-- /TOC -->

## Download IDOL components

Download software from the [eSoftware/Partner portal](https://pdapi-web-pro.microfocus.com/evalportal/index.do).

1. Select __My previous orders__ in the side menu.
2. Click your order number for *IDOL Audio Analytics*.
3. Under the *Get Software* tab, select and download the following files:
   -  `LicenseServer_12.8.0_WINDOWS_X86_64.exe` or `LicenseServer_12.8.0_LINUX_X86_64.exe`.
   -  `MediaServer_12.8.0_WINDOWS_X86_64.exe` or `MediaServer_12.8.0_LINUX_X86_64.exe`.

## Install

Installation scripts are included in this tutorial for Windows (`install.bat`) and Linux (`install.sh`).

Before running the appropriate script, open it and check the following:

1. the `SOURCE_DIR` variable is pointed correctly at the directory where you have placed your `.zip` files and license key file, *e.g.* in `install.sh` for Linux this is assumed to be:

  ```bsh
  SOURCE_DIR="~/Downloads"
  ```

1. the `LICENSE_KEY` variable gives the correct name for your license `.dat` file.

### Windows

Run `install-mediaserver.bat` with administrator privileges:

- right click
- select 'Run as administrator'

### Ubuntu

Run the following command to execute the installation script:

```bsh
sudo ./install-mediaserver.sh
```
