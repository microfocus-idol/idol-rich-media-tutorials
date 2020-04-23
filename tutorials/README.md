# Rich Media Tutorials

A set of guides to introduce you to IDOL Media Server and associated components.

<!-- TOC depthFrom:2 -->

- [Getting started](#getting-started)
  - [Minimum requirements](#minimum-requirements)
  - [Setup IDOL Media Server](#setup-idol-media-server)
- [Introduction](#introduction)
- [Analytics showcase examples](#analytics-showcase-examples)
  - [Speech transcription](#speech-transcription)
  - [Logo Recognition](#logo-recognition)
  - [Vehicle analysis](#vehicle-analysis)
  - [ID Card reading](#id-card-reading)
- [Further reading](#further-reading)
  - [Example configurations](#example-configurations)
  - [Appendix](#appendix)
  - [Links](#links)

<!-- /TOC -->

## Getting started

### Minimum requirements

- 2 cores, 4 GB RAM and 20GB free disk space.
- 64-bit Windows or Linux (this guide has been most recently tested on Windows 10 and Ubuntu 18.10).
- A text editor.
- Administrator privileges to install software.
- A webcam.

Sizing Media Server for your own production tasks depends greatly on your use case, as discussed [later in these tutorials](introduction/PART__III.md#hardware-requirements).

### Setup IDOL Media Server

> Do this before starting any tutorials.

Follow [these steps](setup/SETUP.md) to install IDOL Media Server and set up ready to run the tutorials.

## Introduction

> Everyone should do this tutorial first.

Get started with rich media analytics, using face analytics as our guiding example.  An end-to-end setup taking you from your first Media Server configuration to running your own app that makes use of Media Server as an analytics service.  All you need is a webcam!

[Get started](introduction/README.md).

## Analytics showcase examples

> These guides assume some familiarity with Media Server concepts.

Dip into any of the following showcase guides to try more analytics.

### Speech transcription

Process audio to transcribe human speech from a news broadcast. Search those speech transcripts to understand what's being reported on without having to watch TV!

[Get started](showcase/speech-transcription/README.md).

### Logo Recognition

Find and track logos in broadcast video from a football/soccer match.

[Get started](showcase/logo-recognition/README.md).

### Vehicle analysis

Read number/license places.  Perform additional vehicle analytics to identify the make and color.

[Get started](showcase/vehicle-analysis/README.md).

### ID Card reading

Process a scanned image of an ID card to extract useful structured information.

[Get started](showcase/id-card-ocr/README.md).

*MORE COMING SOON*

## Further reading

### Example configurations

Many more example analysis configurations are provided with your Media Server installation, under `configurations/examples`.  Now you know your Media Server, you can use these as inspiration for our own use cases!

### Appendix

- Working with Lua. [Get started](appendix/Lua_tips.md).
- Working with XSL. [Get started](appendix/XSL_tips.md).

### Links

- Full administration guides are available for all IDOL products [here](https://www.microfocus.com/documentation/idol/).
- Read more tips on working with IDOL products in [IDOL Expert](https://www.microfocus.com/documentation/idol/IDOL_12_5/IDOLServer_12.5_Documentation/Guides/html/English/expert/index.html).
- To learn more about IDOL Media Server and other products from the Micro Focus data analytics, visit [microfocus.com/information-data-analytics-idol](https://software.microfocus.com/en-us/software/information-data-analytics-idol).
