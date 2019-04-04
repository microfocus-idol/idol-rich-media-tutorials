# Install IDOL Media Server

Use the IDOL installer wizard to get IDOL Media Server.

<!-- TOC -->

- [Download the IDOL installer](#download-the-idol-installer)
- [Install](#install)

<!-- /TOC -->

## Download the IDOL installer

Download software from the [eSoftware/Partner portal](https://pdapi-web-pro.microfocus.com/evalportal/index.do).

1. Select __My previous orders__ in the side menu.
1. Click your order number for *IDOL Ultimate*.
2. Under the *Get Software* tab, select and download `IDOLServer_12.2.0_WINDOWS_X86_64.exe` or `IDOLServer_12.2.0_LINUX_X86_64.exe` depending on your system.

## Install

On Windows, right click the installer and __run as Administrator__.

On Linux, run from the command line:

```bsh
chmod +x IDOLServer_12.2.0_LINUX_X86_64.exe
./IDOLServer_12.2.0_LINUX_X86_64.exe
```

Follow the install wizard to get the required components.

Keep the default options except in the following cases:

1. Accept the licese agreement.
2. Keep the default installation directory.
3. Select `Custom` under *Installation Mode*.
4. Do not choose an OEM installation
5. Confirm that `No`, you do not have an existing License Server.
6. (On Windows keep the default service name.)
7. Leave the default port settings and set location of your license `.dat` file.
8. Component Selection:
   - To cover these tutorials you need to select only the *Media Server* component.
   - (On Windows also create a service with the default name).

    ![idol-installer](./figs/idol-installer.png)

9. Click Next to proceed with the installation.
