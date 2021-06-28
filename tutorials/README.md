# Rich Media Tutorials

A set of guides to introduce you to IDOL Media Server and associated components.

<!-- TOC depthFrom:2 -->

- [Getting started](#getting-started)
  - [Minimum requirements](#minimum-requirements)
  - [Setup IDOL Media Server](#setup-idol-media-server)
- [Introduction](#introduction)
- [Analytics showcase examples](#analytics-showcase-examples)
  - [Surveillance analytics](#surveillance-analytics)
  - [Speech transcription](#speech-transcription)
  - [Logo Recognition](#logo-recognition)
  - [Vehicle analysis](#vehicle-analysis)
  - [ID Card reading](#id-card-reading)
  - [Cluster Faces](#cluster-faces)
- [Further reading](#further-reading)
  - [Example configurations](#example-configurations)
  - [Hints and Tips](#hints-and-tips)
  - [Links](#links)

<!-- /TOC -->

## Getting started

### Minimum requirements

- 2 cores, 4 GB RAM and 20GB free disk space.
- 64-bit Windows or Linux (this guide has been most recently tested on Windows 10 and Ubuntu 18.10).
- A text editor.
- Administrator privileges to install software.
- A webcam.

Sizing Media Server for your own production tasks depends greatly on your use case, as discussed [later in these tutorials](introduction/PART_III.md#hardware-requirements).

### Setup IDOL Media Server

> Do this before starting any tutorials.

Follow [these steps](setup/SETUP.md) to install IDOL Media Server and get ready to run the tutorials.

## Introduction

> Everyone should do this tutorial.

Make a serious start with rich media analytics, using face analytics as our guiding example.  This end-to-end course takes you from your first Media Server configuration to running your own app, which makes use of Media Server as an analytics service.  All you need is a webcam (and a few hours of your time)!

[Get started](introduction/README.md).

## Analytics showcase examples

> These guides assume some familiarity with Media Server concepts.

Dip into any of the following showcase guides to try more analytics.

### Surveillance analytics

Process CCTV video to track people and vehicles.  Learn how to use Media Server's GUI to easily configure scenario-based alerts to capture events such as loitering, wrong way driving and illegal turning.  Let's keep the roads safe!

[Get started](showcase/surveillance/README.md).

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

### Cluster Faces

Automatically organize unsorted pictures of people into unique identities using Face Recognition clustering.

[Watch](https://www.youtube.com/watch?v=FlnAqKKrQYw&list=PLlUdEXI83_Xoq5Fe2iUnY8fjV9PuX61FA).

## Further reading

### Example configurations

Many more example analysis configurations are provided with your Media Server installation, under `configurations/examples`.  Now you know your Media Server, you can use these as inspiration for our own use cases!

### Hints and Tips

- Working with audio, images and video. [Read more](appendix/Media_tips.md).
- Scripting in Lua. [Read more](appendix/Lua_tips.md).
- XSL transforms. [Read more](appendix/XSL_tips.md).

### Links

- Full administration guides are available for all IDOL products [here](https://www.microfocus.com/documentation/idol/).
- Read more tips on working with IDOL products in [IDOL Expert](https://www.microfocus.com/documentation/idol/IDOL_12_8/IDOLServer_12.8_Documentation/Guides/html/expert/index.html).
- To learn more about IDOL Media Server and other IDOL products, visit [microfocus.com/idol](https://www.microfocus.com/en-us/products/information-data-analytics-idol/overview).
