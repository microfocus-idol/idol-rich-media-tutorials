# Create your own IDOL rich media setup

This is a setup guide for a basic installation of IDOL rich media and associated components.

<!-- TOC depthFrom:2 -->

- [Useful third-party tools](#useful-third-party-tools)
- [IDOL components](#idol-components)
  - [Obtain an IDOL license](#obtain-an-idol-license)
  - [Access IDOL software](#access-idol-software)
    - [IDOL components ZIPs (*alternative*)](#idol-components-zips-alternative)
  - [Install](#install)
  - [Obtaining tutorial materials](#obtaining-tutorial-materials)
    - [Following this guide offline](#following-this-guide-offline)
  - [Obtaining training materials](#obtaining-training-materials)
    - [Validate install](#validate-install)
  - [Further reading](#further-reading)

<!-- /TOC -->

## Useful third-party tools

A text editor, *e.g.*:

- [VS Code](https://code.visualstudio.com/download), or
- [Notepad++](https://notepad-plus-plus.org/download)

A log follower, *e.g.*:

- `tail -F` from the command line, or
- [Baretail](https://www.baremetalsoft.com/baretail/) - select the *Free Version*

## IDOL components

### Obtain an IDOL license

IDOL components are licensed via the IDOL License Server application, which requies a license key.

You can obtain software and licenses from the [eSoftware/Partner portal](https://pdapi-web-pro.microfocus.com/evalportal/index.do).

1. Under *Product Center*, select *IDOL*, then *IDOL Ultimate*
2. Complete the web form with your details to gain access
3. Under the *Get Licensing* tab, scroll to the bottom and click __Get License__:

    ![eSoftware-getLicense](./figs/eSoftware-getLicense.png)

4. Click through the pop-ups then, scroll to the bottom and click __Activate__ next to your *IDOL # day Personal license*

   ![eSoftware-activateLicense](./figs/eSoftware-activateLicense.png)

5. Select this license, then choose your preferred version (the latest is 12.5):

   ![eSoftware-selectLicense](./figs/eSoftware-selectLicense.png)

6. Fill in the license details, including the MAC address and hostname of the machine where you will install IDOL License Server:

   ![eSoftware-configureLicense](./figs/eSoftware-configureLicense.png)

7. Confirm your details the finally download your key, which is a `.dat` file.

### Access IDOL software

IDOL software is available under a range of license types, inlcuding the *IDOL Ultimate* that we just accessed.  To have access to all the components used in these tutorials, you need to request access to one additional license type:

1. Under *Product Center*, select *IDOL*, then *IDOL Ultimate*
2. Complete the web form with your details to gain access

#### IDOL components ZIPs (*alternative*)

Under the *Get Software* tab, select `LicenseServer_12.5.0_WINDOWS_X86_64.zip` or `LicenseServer_12.5.0_LINUX_X86_64.zip`.

Go back to *Product Center* > *IDOL* and request access to a Media Server license type, *e.g.* *IDOL Audio Analytics SW E-Media*.  Again you need to fill out the form to gain access.  Once complete go to the *Get Software* tab and download the following:

- `MediaServer_12.5.0_WINDOWS_X86_64.zip` or `MediaServer_12.5.0_LINUX_X86_64.zip`

### Install

Follow one of these two methods to install IDOL on your system:

- Follow [these steps](INSTALL_WIZARD.md) to install IDOL using the graphical installer (*recommended*).
- Follow [these steps](INSTALL_ZIPS.md) for a scripted installation of IDOL components (*advanced*).

### Obtaining tutorial materials

Get a local copy of this tutorial to give you all the configuration files you will need.  You can either clone this repository or download the `.zip` from [GitHub](https://github.com/microfocus-idol/idol-rich-media-tutorials).

![github-download](./figs/github-download.png)

We will now run a script to move some of these materials into convenient locations for running the excersises later on.

#### Following this guide offline

You can stay on GitHub to follow the steps in this and further linked README files in your browser, or if you prefer to work with the downloaded files, see [these steps](appendix/Markdown_reader.md) to turn your browser into a smart markdown viewer.

### Obtaining training materials

All required sample videos are available from this hosted [directory](http://tech-demo.idol.swinfra.net/tutorial/). 

> Use `Save As` to avoid opening the video in your browser.

You will be instructed what to download in the guides as needed.

#### Validate install

If you used the installer wizard, or the scripts without altering them, your installed software will be in:

- `C:\MicroFocus\IDOLServer-12.5.0` (Windows)
- `~/IDOLServer-12.5.0` (Linux)

Each component has its own sub-directory, which includes all required executables, dependencies and configuration files.  The primary configuration file for each shares the name of the component executable, *e.g.* `mediaserver.cfg` for `mediaserver.exe`.

Now let's start up license server:

- On Windows, start the `MicroFocus-LicenseServer` Windows Service.
- On Linux, launch the startup script from the License Server directory:

  ```bsh
  ./start-licenseserver.sh
  ```

To ensure License Server is running, point your browser to [`action=getLicenseInfo`](http://localhost:20000/a=getlicenseinfo).

Next start up Media Server in the same way and verify it is also running at [`action=getStatus`](http://localhost:14000/a=getstatus).

### Further reading

The admin guides for all components can be accessed from these links:

- [IDOL documentation home page](https://www.microfocus.com/documentation/idol/)
- [License Server administration guide](https://www.microfocus.com/documentation/idol/IDOL_12_5/LicenseServer_12.5_Documentation/Guides/html/English/)
- [Media Server administration guide](https://www.microfocus.com/documentation/idol/IDOL_12_5/MediaServer_12.5_Documentation/Guides/html/English/index.html)
