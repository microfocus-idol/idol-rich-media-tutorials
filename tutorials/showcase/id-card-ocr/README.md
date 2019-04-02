# ID Card Processing

Media Server includes an Optical Character Recognition (OCR) analysis engine, which can be configured to read specific scripts in images and video, such as Japanese characters or Arabic numerals.

For a more detailed introduction to Optical Character Recognition, see the [admin guide](https://www.microfocus.com/documentation/idol/IDOL_12_2/MediaServer_12.2_Documentation/Guides/html/English/index.html#Operations/Analyze/OCR_overview.htm).

We will:

1. use the OCR analysis engine to read the text from an image of an ID card
2. use Face Detection to identify rotated images along with a transform engine to correct them
3. recognize a type of document in order to define OCR regions to maintain document structure
4. encode a redacted image to hide sensitive data

This guide assumes you have already completed the [introductory tutorial](../../introduction/README.md).

<!-- TOC -->

- [Setup](#setup)
  - [Configure the required analytics](#configure-the-required-analytics)
    - [Enabled modules](#enabled-modules)
    - [Licensed channels](#licensed-channels)
- [Process configuration to read text](#process-configuration-to-read-text)
  - [Image file ingest](#image-file-ingest)
  - [Analysis](#analysis)
  - [Output](#output)
  - [Running our analysis](#running-our-analysis)
- [Adding Face Recognition to correct rotations](#adding-face-recognition-to-correct-rotations)
  - [Analysis](#analysis-1)
  - [Transform](#transform)
  - [Running our analysis](#running-our-analysis-1)

<!-- /TOC -->

## Setup

### Configure the required analytics

Media Server must be licensed for visual analytics, as described in the [introductory tutorial](../../introduction/PART_I.md#enabling-analytics).  To reconfigure Media Server you must edit your `mediaserver.cfg` file.

#### Enabled modules

The `Modules` section is where we list the engines that will be available to Media Server on startup.  Ensure that this list contains the module `objectrecognition`:

```ini
[Modules]
Enable=...,facedetect,objectrecognition,ocr,...
```

#### Licensed channels

*Reminder*: The `Channels` section is where we instruct Media Server to request license seats from License Server.  Media Server has four license *flavours*:

1. Audio
1. Surveillance
1. Visual
1. Video Management

To enable object recognition for this tutorial, you need to enable at least one channel of type *Visual*:

```ini
[Channels]
...
VisualChannels=1
```

*N.B.* For any changes you make in `mediaserver.cfg` to take effect you must restart Media Server.

## Process configuration to read text

### Image file ingest

To ingest an image file couldn't be simpler.  We will include the following in our process configuration:

```ini
[Session]
Engine0 = Source

[Source]
Type = image
```

For full details on the options available for ingesting image sources, please read the [reference guide](https://www.microfocus.com/documentation/idol/IDOL_12_2/MediaServer_12.2_Documentation/Help/index.html#Configuration/Ingest/Image/_Image.htm).

### Analysis

To read text, we need to include the following minimal configuration:

```ini
[OCR]
Type = ocr
Languages = en,tr
WordRejectThreshold = 75
```

We have specified two parameters that affect how the analytic: the lanagues to search for and a confidence threshold.  For full details on these and other available options, please read the [reference guide](https://www.microfocus.com/documentation/idol/IDOL_12_2/MediaServer_12.2_Documentation/Help/index.html#Configuration/Analysis/OCR/_OCR.htm).

### Output

For this first step we will simply output all the words we have read in a single plain-text file:

```ini
[WriteText]
Type = xml
Input = OCR.Result
XMLOutputPath = output/idCard1/%source.filename%.txt
XSLTemplate = toText.xsl
```

As in the introductory tutorials, we are using an XSL transform to extact the words from the internal structured information.  In this case, using an out-of-the-box transfor included with Media Server.

### Running our analysis

Let's try it. Paste the following parameters into [`test-action`](http://127.0.0.1:14000/a=admin#page/console/test-action), remembering to update the `source` and `configPath` parameters to match your setup:

```url
action=process&source=C:/MicroFocus/image/Turkey1.png&configPath=C:/MicroFocus/idol-rich-media-tutorials/showcase/id-card-ocr/idCard1.cfg
```

Click `Test Action` to start processing.

Go to Media Server's `output/idCard1` to see the results.

## Adding Face Recognition to correct rotations

Image this document was scanned upside down.  We would like to handle these documents automatically.  For documents containing faces, we can make use of engine chaining and Face Detection in order to find the true orientation and correct it before running OCR as before.

### Analysis

To detect faces in any orientation, we need to include the following analysis configuration:

```ini
[FaceDetect]
Type = FaceDetect
Orientation = Any
```

We have specified that faces should be looked for in any orientation.  For full details on these and other available options, please read the [reference guide](https://www.microfocus.com/documentation/idol/IDOL_12_2/MediaServer_12.2_Documentation/Help/index.html#Configuration/Analysis/Face/_Face.htm).

### Transform

To rotate the image based on the orientation of the detected face, we need to include the following transform configuration:

```ini
[RotateFace]
Type = Rotate
Input = FaceDetect.ResultWithSource
LuaScript = inverseFaceAngle.lua
```

We are envoking an out-of-the-box Lua script to capture the angle of rotation of the detected face.  For full details on this and other available transformations, please read the [reference guide](https://www.microfocus.com/documentation/idol/IDOL_12_2/MediaServer_12.2_Documentation/Help/index.html#Configuration/Transform/_Transform.htm).

### Running our analysis

Paste the following parameters into [`test-action`](http://127.0.0.1:14000/a=admin#page/console/test-action), remembering to update the `source` and `configPath` parameters to match your setup:

```url
action=process&source=C:/MicroFocus/image/Turkey2.png&configPath=C:/MicroFocus/idol-rich-media-tutorials/showcase/id-card-ocr/idCard2.cfg
```

Click `Test Action` to start processing.

Go to Media Server's `output/idCard2` to see the results.



_*END*_
