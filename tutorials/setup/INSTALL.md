# Get started with your IDOL rich media setup

This is a setup guide for a basic installation of IDOL rich media and associated components.

<!-- TOC -->

- [Useful third-party tools](#useful-third-party-tools)
- [IDOL components](#idol-components)
  - [Obtaining IDOL software](#obtaining-idol-software)
    - [License key](#license-key)
    - [IDOL installer (*recommended*)](#idol-installer-recommended)
    - [IDOL components ZIPs (*alternative*)](#idol-components-zips-alternative)
  - [Install](#install)
    - [Using the IDOL installer (*recommended*)](#using-the-idol-installer-recommended)
    - [Using the IDOL components ZIPs (*alternative*)](#using-the-idol-components-zips-alternative)
  - [Validate install](#validate-install)
  - [Further reading](#further-reading)

<!-- /TOC -->

## Useful third-party tools

A text editor, *e.g.*:

- [VS Code](https://code.visualstudio.com/download), or
- [Notepad++](https://notepad-plus-plus.org/download)

A log follower, *e.g.*:

- [Baretail](https://www.baremetalsoft.com/baretail/) - select the `Free Version`

## IDOL components

### Obtaining IDOL software

Go to the [eSoftware/Partner portal](https://h22255.www2.hpe.com/evalportal/index.do).  Under *Product Center*, select *IDOL* to view available software.  Select *IDOL Ultimate*, then complete the form to gain access.

#### License key

Follow the instructions under the *Get Licensing* tab to obtain your license key `.dat` file.

#### IDOL installer (*recommended*)

Under the *Get Software* tab, select `IDOLServer_12.1.0_WINDOWS_X86_64.exe` or `IDOLServer_12.1.0_LINUX_X86_64.exe` depending on your system.

#### IDOL components ZIPs (*alternative*)

Under the *Get Software* tab, select `LicenseServer_12.1.0_WINDOWS_X86_64.zip` or `LicenseServer_12.1.0_LINUX_X86_64.zip`

Go back to *Product Center* > *IDOL* and request access to a Media Server license type, *e.g.* *IDOL Audio Analytics SW E-Media*.  Again you need to fill out the form to gain access.  Once complete go to the *Get Software* tab and download the following:

- `MediaServer_12.1.0_WINDOWS_X86_64.zip` or `MediaServer_12.1.0_LINUX_X86_64.zip`

### Install

#### Using the IDOL installer (*recommended*)

If you have the installer:

- `IDOLServer_12.1.0_WINDOWS_X86_64.exe` or `IDOLServer_12.1.0_LINUX_X86_64.exe`

You can follow the install wizard to get the required components.

On Windows, right click the installer and run as Administrator.

On Linux, run from the command line:

```bsh
chmod +x IDOLServer_12.1.0_LINUX_X86_64.exe
./IDOLServer_12.1.0_LINUX_X86_64.exe
```

Keep the default options except in the following cases:

- Select `Custom` under *Installation Mode*.
- Confirm that `No`, you do not have an existing License Server.
- Set the location of your license `.dat` file.
- To cover all tutorials you need to have at least the following components (on Windows also select to create services for each of them):
  - License Server
  - Media Server

#### Using the IDOL components ZIPs (*alternative*)

If you have the component `.zip` files:

- `LicenseServer_12.1.0_WINDOWS_X86_64.zip` or `LicenseServer_12.1.0_LINUX_X86_64.zip`
- `MediaServer_12.1.0_WINDOWS_X86_64.zip` or `MediaServer_12.1.0_LINUX_X86_64.zip`

Installation scripts are included in this tutorial for Windows (`install.bat`) and Linux (`install.sh`).

Before running the appropriate script, open it and check the following:

1. the `SOURCE_DIR` variable is pointed correctly at the directory where you have placed your `.zip` files, *e.g.* in `install.sh` for Linux this is assumed to be:

  ```bsh
  SOURCE_DIR="~/Downloads"
  ```

1. the `LICENSE_KEY` variable gives the correct name for your license `.dat` file.

Now run the `install.bat` or `install.sh` script with administrator privileges, which will unzip the software (and install C++ dependencies on Windows).

### Validate install

If you used the installer wizard or the scripts without altering them, your installed software will be in:

- `C:\MicroFocus\IDOLServer-12.1.0` (Windows)
- `~/IDOLServer-12.1.0` (Linux)

Each component has its own sub-directory, which includes all required executables, dependencies and configuration files.  The primary configuration file for each shares the name of the component executable, *e.g.* `mediaserver.cfg` for `mediaserver.exe`.

Now let's start up license server:

- On Windows, start the `MicroFocus-LicenseServer` Windows Service.
- On Linux, launch the startup script from the License Server directory:

  ```bsh
  ./start-licenseserver.sh
  ```

To ensure License Server is running, point your browser to [`action=getLicenseInfo`](http://127.0.0.1:20000/a=getlicenseinfo).

Next start up Media Server in the same way and verify it is also running at [`action=getStatus`](http://127.0.0.1:14000/a=getstatus).

### Further reading

The admin guides for all components can be accessed from these links:

- [IDOL documentation home page](https://www.microfocus.com/documentation/idol/)
- [License Server administration guide](https://www.microfocus.com/documentation/idol/IDOL_12_1/LicenseServer/Guides/html/English/)
- [Media Server administration guide](https://www.microfocus.com/documentation/idol/IDOL_12_1/MediaServer/Guides/html/English/index.html)

_*END*_
