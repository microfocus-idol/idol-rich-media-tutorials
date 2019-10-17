# PART I - Automatic Subtitles

Media Server can be used to perform audio analytics, including speech transcription (often called Speech-to-Text), speaker identification and language identification.  We will configure Media Server to support a simple use case of this speech transcription capability: to record video clips from on a live news broadcast stream and automatically generate subtitles for those clips.

We will:

1. configure a speech language pack and run speech transcription
1. record video clips from a live stream
1. use XSL transforms to re-format Media Server output to create subtitles

This guide assumes you have already completed the [introductory tutorial](../../README.md#introduction).

<!-- TOC depthFrom:2 -->

- [Setup](#setup)
  - [Third-party software](#third-party-software)
  - [Configure speech transcription](#configure-speech-transcription)
    - [Enabled modules](#enabled-modules)
    - [Licensed channels](#licensed-channels)
    - [Language packs](#language-packs)
- [Process configuration](#process-configuration)
- [Process a news channel stream](#process-a-news-channel-stream)
- [PART II - Custom Language Model](#part-ii---custom-language-model)

<!-- /TOC -->

## Setup

### Third-party software

Download and install [VLC player](http://www.videolan.org/vlc/) for video clip playback.

### Configure speech transcription

Media Server is separately licensed for visual and audio analytics, as described in the [introductory tutorial](../../introduction/PART_I.md#enabling-analytics).  To reconfigure Media Server you must edit your `mediaserver.cfg` file.

#### Enabled modules

The `Modules` section is where we list the engines that will be available to Media Server on startup.  Ensure that this list contains the module `speechtotext`:

```ini
[Modules]
Enable=...,speechtotext,...
```

#### Licensed channels

The `Channels` section is where we instruct Media Server to request license seats from License Server.  To enable speech transcription for this tutorial, you need to enable at least one channel of type *Audio*:

```ini
[Channels]
...
AudioChannels=1
```

> For any changes you make in `mediaserver.cfg` to take effect you must restart Media Server.

#### Language packs

Speech transcription language packs are distributed separately from the main Media Server installer.  To obtain a language pack:

- Go to the [eSoftware/Partner portal](https://pdapi-web-pro.microfocus.com/evalportal/index.do).
- Under *Product Center*, select *IDOL* to view available software.  Select *IDOL Audio Analytics SW E-Media*, then complete the form to gain access.

For this tutorial we will use the British English pack:

1. go to the *Get Software* tab
1. download the language pack `ENUK-12.3.0.zip`
1. unzip the contents into Media Server's static data directory, to give you, e.g. `staticdata/speechtotext/ENUK`, containing files like `ver-ENUK-12.3.0*`

This language pack is targeted to high quality *broadband* audio.  An additional language pack is available for telephony.  Many other languages and dialects are supported.  Please refer to the [admin guide](https://www.microfocus.com/documentation/idol/IDOL_12_3/MediaServer_12.3_Documentation/Guides/html/English/#Appendixes/SpeechLanguages.htm) for details.

You can manually load the ENUK language pack with the action <http://127.0.0.1:14000/action=LoadSpeechLanguageResource&LanguagePack=ENUK>.

If you skip this manual load, Media Server will automatically load the language (if installed) when processing begins but doing this will add latency to the processing.  Now review the list of loaded language pack(s) with the action <http://127.0.0.1:14000/action=ListSpeechLanguageResources>.

## Process configuration

To ingest a video stream, we will include the following in our process configuration:

```ini
[Session]
Engine0 = StreamIngest

[StreamIngest]
Type = Video
```

To run speech transcription, we will add the following settings:

```ini
[SpeechToText]
Type = SpeechToText
LanguagePack = ENUK
SpeedBias = Live
```

More options are available for the *SpeechToText* analysis engine.  Please refer to the [reference guide](https://www.microfocus.com/documentation/idol/IDOL_12_3/MediaServer_12.3_Documentation/Help/index.html#Configuration/Analysis/SpeechToText/_SpeechToText.htm) for details.

To view the results in a simple and standalone way, we will record the stream to video files and format the speech transcription output to generate subtitles for those clips.

First we need to configure video encoding:

```ini
[VideoClips]
Type = mpeg
AudioProfile = mpeg4audio
VideoProfile = mpeg4video_h264_360p
MIMEType = video/mp4
Segment = True
SegmentDuration = 30s
OutputPath = output/speechToText1/%session.token%/clip_%segment.sequence%.mp4
UseTempFolder = True
```

Next we need to generate the subtitles.  This requires two steps:

1. segmenting the text into short chunks with the *TextSegmentation* analysis engine
1. transforming the XML output into [SRT format](https://en.wikipedia.org/wiki/SubRip#SubRip_text_file_format), *e.g.*

    ```txt
    4
    00:03:09,365 --> 00:03:13,034
    It's like people only do these things because they can get paid.

    5
    00:03:12,117 --> 00:03:15,037
    And that's just really sad.
    ```

    > [Wayne's World (1992) Quotes - IMDB](http://www.imdb.com/title/tt0105793/quotes)

To achieve all this, we need to add the following to our process configuration:

```ini
[TextSegmentation]
Type = TextSegmentation
Input = SpeechToText.Result
MaximumDuration = 5s

[SrtOutput]
Type = XML
Input = VideoClips.Proxy,TextSegmentation.Result
Mode = Bounded
EventTrack = VideoClips.Proxy
XMLOutputPath = output/speechToText1/%session.token%/clip_%segment.sequence%.srt
XslTemplate = toSRT.xsl
```

We use using the *Bounded* output mode to bundle together all the text segments that overlap the video clip in time.  Please read the [admin guide](https://www.microfocus.com/documentation/idol/IDOL_12_3/MediaServer_12.3_Documentation/Guides/html/English/#Operations/Outputs/IndexingModes_BoundedEvent.htm), for details.

## Process a news channel stream

We will process the open stream from *Al Jazeera English*:

``` url
http://english.streaming.aljazeera.net/aljazeera/english2/index576.m3u8
```

Copy the config file `speechToText1.cfg` from this guide into `configurations/tutorials`, then paste the following parameters into [`test-action`](http://127.0.0.1:14000/a=admin#page/console/test-action):

```url
action=process&source=http://english.streaming.aljazeera.net/aljazeera/english2/index576.m3u8&configName=tutorials/speechToText1
```

Click the `Test Action` button to start processing.  The video clip and srt are produced every 30 seconds based on the `SegmentDuration` parameter.

Review the results with [`/action=activity`](http://127.0.0.1:14000/a=activity), then go to `output/speechToText1` to see the video clips and associated subtitle files.

Having ensured that the `.srt` file and the `.mp4` clip share the same filename in the above configuration, we can now simply open the clip in VLC player to view the time-aligned subtitles.

![news-srt](./figs/news-srt.png)

Stop processing with [`stop`](http://127.0.0.1:14000/a=queueInfo&queueAction=stop&queueName=process).

## PART II - Custom Language Model

Start [here](PART_II.md).
