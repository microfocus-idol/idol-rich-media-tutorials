# Rich Media Tutorials

A set of guides to introduce you to IDOL Media Server and associated components.

<!-- TOC -->

- [Getting started](#getting-started)
  - [Minimum requirements](#minimum-requirements)
  - [Obtaining tutorial materials](#obtaining-tutorial-materials)
  - [Following this guide](#following-this-guide)
  - [Obtaining training materials](#obtaining-training-materials)
  - [Obtaining IDOL software](#obtaining-idol-software)
    - [If you are a Micro Focus employee or partner](#if-you-are-a-micro-focus-employee-or-partner)
    - [Otherwise](#otherwise)
  - [Basic software installation](#basic-software-installation)
- [Introduction](#introduction)
- [Analytics showcase examples](#analytics-showcase-examples)
  - [Object Recognition](#object-recognition)
  - [Vehicle analysis](#vehicle-analysis)
  - [Event Processing](#event-processing)
  - [Speech transcription](#speech-transcription)
- [Example configurations](#example-configurations)
- [Appendix](#appendix)
- [Links](#links)

<!-- /TOC -->

## Getting started

### Minimum requirements

- A laptop with minimum 2 cores and 4 GB RAM, running 64-bit Windows or Linux.  These tutorials have been tested on Windows 7, Windows 10 and Ubuntu 16.04 / 16.10.
- Administrator privileges to install software.
- A webcam.
- A text editor.

### Obtaining tutorial materials

Get a local copy of this tutorial to give you all the configuration files you will need.  You can either clone this repository or download the `.zip`.

<!-- Larger files such as sample videos are stored with Git LFS. -->

### Following this guide

You can stay on GitHub to follow the steps in this and further linked README files in your browser, or if you prefer to work with the downloaded files, see [these steps](appendix/Markdown_reader.md) to turn your browser into a smart markdown viewer.

### Obtaining training materials

<!-- TODO - Replace with Git LFS. -->

All required sample videos are available from this hosted [directory](http://tech-demo.idol.swinfra.net/tutorial/). *N.B.* Use `Save As` on the file links to avoid opening the videos in your browser.

You will be instructed what to download in the guides as needed.

### Obtaining IDOL software

#### If you are a Micro Focus employee or partner

You can obtain software and a testing license from the [eSoftware/Partner portal](https://h22255.www2.hpe.com/evalportal/index.do).

Under *Product Center*, select *IDOL* to view the software available to you. See the installation instructions below for details on what to download.

#### Otherwise

Please check with the Micro Focus contact who provided you with these tutorials to request the required software and trial license.

### Basic software installation

__*Do this before starting any tutorials.*__

If you do not yet have your own IDOL installation, please follow [this short guide](setup/INSTALL.md) to get your own basic setup.  You will be instructed on how to configure this setup as you follow the guides below.

## Introduction

__*Everyone should do this tutorial first.*__

Get started with rich media analytics, using face analytics as a guiding example.  An end-to-end introduction taking you from your first Media Server configuration to running your own app that makes use of Media Server as an analytics service.  All you need is a webcam!

[Get started](introduction/README.md).

## Analytics showcase examples

__*These guides assume a familiarity with Media Server concepts.*__

Dip into any of the following showcase guides to try more analytics.

### Object Recognition

Find and track logos in broadcast video from a football/soccer/calcio match.

<!-- [Get started](showcase/object-recognition/README.md). -->
__*COMING SOON*__

### Vehicle analysis

Read number/license places.  Perform additional vehicle analytics like make recognition.

<!-- [Get started](showcase/vehicle-analysis/README.md). -->
__*COMING SOON*__

### Event Processing

As a simple exercise, use event processing rules to build your own *ExplosionDetector* "analytic engine" from the output of the simplest analysis engine *KeyFrame*, which identifies video frames in which the scene changes significantly from the previous frame.

<!-- [Get started](showcase/event-processing/README.md). -->
__*COMING SOON*__

### Speech transcription

Process audio to transcribe human speech from a news broadcast.  Search those speech transcripts to understand what's being reported on without having to watch TV!

<!-- [Get started](showcase/speech-transcription/README.md). -->
__*COMING SOON*__

## Example configurations

Many more example analysis configurations are provided with your Media Server installation, under `configurations/examples`.  Now you know your Media Server, you can use these as inspiration for our own use cases!

## Appendix

- Working with Lua. [Get started](appendix/Lua_tips.md).
- Working with XSL. [Get started](appendix/XSL_tips.md).

## Links

- Full administration guides are available for all IDOL products [here](https://www.microfocus.com/documentation/idol/).
- Read more tips on working with IDOL products in [IDOL Expert](https://www.microfocus.com/documentation/idol/IDOL_12_2/IDOLServer/Guides/html/English/expert/index.html).
- To learn more about IDOL Media Server and other products from the Micro Focus data analytics, visit [microfocus.com/information-data-analytics-idol](https://software.microfocus.com/en-us/software/information-data-analytics-idol).
