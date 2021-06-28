# Rich media tips

<!-- TOC depthFrom:2 -->

- [Useful third-party software](#useful-third-party-software)
- [Collecting sample media](#collecting-sample-media)
  - [Video stream sources from the web](#video-stream-sources-from-the-web)
    - [Live YouTube channels](#live-youtube-channels)
  - [CCTV camera streams](#cctv-camera-streams)
  - [Academic datasets](#academic-datasets)
- [Working with video sources](#working-with-video-sources)
  - [Test availability of an IP stream](#test-availability-of-an-ip-stream)
  - [Record video/audio from an IP stream](#record-videoaudio-from-an-ip-stream)
  - [Download a video from YouTube](#download-a-video-from-youtube)
  - [Record video/audio from a live YouTube channel](#record-videoaudio-from-a-live-youtube-channel)
  - [Examine the metadata of a video file](#examine-the-metadata-of-a-video-file)
  - [Extract still images from a video file](#extract-still-images-from-a-video-file)
  - [Make a video clip of an interesting section](#make-a-video-clip-of-an-interesting-section)
  - [Concatenate video clips into one video file](#concatenate-video-clips-into-one-video-file)
  - [Ingest a sequence of videos as a playlist](#ingest-a-sequence-of-videos-as-a-playlist)
  - [Add tracks to existing media file](#add-tracks-to-existing-media-file)
  - [Strip tracks to existing media file](#strip-tracks-to-existing-media-file)
  - [Loop a video file to produce a continuous RTSP stream](#loop-a-video-file-to-produce-a-continuous-rtsp-stream)
- [Next steps](#next-steps)

<!-- /TOC -->

## Useful third-party software

- A text editor, *e.g.* [VS Code](https://code.visualstudio.com/download), [Notepad++](https://notepad-plus-plus.org/)
- A video player, *e.g.* [VLC](http://www.videolan.org/vlc/), [ffmpeg](https://ffmpeg.org/download.html)
- A video editor, *e.g.* [ffmpeg](https://ffmpeg.org/download.html)
- A screen recorder, *e.g.* with the [Xbox Game Bar](https://support.xbox.com/en-GB/help/friends-social-activity/share-socialize/record-game-clips-game-bar-windows-10) included with Windows 10, or [ffmpeg](https://ffmpeg.org/download.html)
- A scripting language, *e.g.* [node.js](https://nodejs.org/), [python](https://www.python.org/downloads/)
- A better terminal for Windows, *e.g.* [GitBash](https://gitforwindows.org/) (even better with [Cmder](http://cmder.net/))

## Collecting sample media

Typically, you will be able to get audio, video or image samples from your customer. If not you have (at least) three choice:

1. Connect to an open online stream, *e.g.* from a news broadcaster's website (see below).
1. Use a webcam - see the setup guide to learn how to [connect](../setup/WEBCAM.md).
1. Make use of open data shared by the academic community, see [below](#academic-datasets).
1. Search for rights-free media on the web, *e.g.* [pexels.com](https://www.pexels.com/).
1. Download video files or stream video from YouTube, *e.g.* as described [below](#download-a-video-from-youtube).

### Video stream sources from the web

There exist many free news streams on the web that you can connect to.  Often news websites include a "Live" page where you can view the channel in your browser.  Under the hood, the page is typically requesting an HLS stream index `.m3u8` file.  We can identify these files by manually inspecting websites, *i.e.* by pressing `F12` and filtering on files downloaded in the Network tab. The following streams were working at time of writing.

Language | Broadcaster | Resolution | Link
--- | --- | --- | ---
Arabic | France 24 | 1024x576 | http://f24hls-i.akamaihd.net/hls/live/221148/F24_AR_HI_HLS/master_2000.m3u8
English | Al Jazeera | 960x540 | http://live-hls-web-aje.getaj.net/AJE/03.m3u8
French | France 24 | 1024x576 | http://f24hls-i.akamaihd.net/hls/live/221146/F24_FR_HI_HLS/master_2000.m3u8
German | DW | 720x400 | http://dwstream6-lh.akamaihd.net/i/dwstream6_live@123962/index_1_av-p.m3u8
Italian | Rai News 24 | 704x396 | http://rainews1-live.akamaized.net/hls/live/598326/rainews1/rainews1/rainews_1800/chunklist.m3u8
Spanish | RTVe Canal 24 | 1024x576 | http://rtvelivestream.akamaized.net/24h_main_dvr_576.m3u8

These streams can be directly ingested by Media Server as we do in the Speech to Text [tutorial](../showcase/speech-transcription/PART_I.md#process-a-news-channel-stream).

#### Live YouTube channels

Increasingly, broadcasters are offering live streaming news via YouTube.  Some examples working at time of writing:

Language | Broadcaster | Resolution | Link
--- | --- | --- | ---
Chinese | CCTV 4 | 1920x1080 (max) | https://www.youtube.com/watch?v=vCDDYb_M2B4
Hindi | NDTV | 1920x1080 (max) | https://www.youtube.com/watch?v=l9ViEIip9q4
Ukrainian | 112 Украина | 1920x1080 (max) | https://www.youtube.com/watch?v=3Q11d6I21PE
Urdu | Geo TV | 640x360 | https://www.youtube.com/watch?v=QpoSuyXQKOs

These channels also wrap HLS stream index `.m3u8` files, which can be accessed as described [below](#record-videoaudio-from-a-live-youtube-channel).

### CCTV camera streams

Media Server can connect directly to live streams from most CCTV camera brands.  To find the stream details you will usually need to consult the operating manual for the particular camera.  

Most modern cameras will offer an [RTSP](https://en.wikipedia.org/wiki/Real_Time_Streaming_Protocol) stream, which looks like `rtsp://<user>:<password>@<IP>:<port>/<channel>`, where `IP` is the IP address (or hostname) of the camera.  If the port is not specified, the default is `554` for RTSP.  The channel part of the URL is optional.  The username and password can be added as shown and are required if security has been enabled on the camera.  Some examples from common brands:

Manufacturer | RTSP
--- | ---
Arecont | `rtsp://<IP>/media/video1`
Axis | `rtsp://<IP>/axis-media/media.amp`
Bosch | `rtsp://<IP>/video?inst=1&h26x=4`
D-Link | `rtsp://<IP>/live1.sdp`
Flir | `rtsp://<IP>/avc`
Geovision | `rtsp://<IP>/CH001.sdp`
Hikvision | `rtsp://<IP>/Streaming/Channels/101/`
IndigoVision | `rtsp://<IP>/`
Pelco | `rtsp://<IP>/stream1`

> If you cannot find a manual for your camera, or your manual does not include RTSP connection details (which is not uncommon), there are a number of websites that aggregate camera connection details.  I have found this one to be useful: <https://community.geniusvision.net/platform/cprndr/manurtsplist>.

As with the Bosch connection example above, some cameras also expose configuration parameters in the URL.Most cameras will need to be configured via an embedded web configuration UI, similar to what you have on your internet router at home.  This UI will be accessible at `http://<IP>:80/`, where `IP` is again the IP address (or hostname) of the camera.

Media Server can connect directly to these RTSP streams if you configure the multi-purpose [Video](https://www.microfocus.com/documentation/idol/IDOL_12_8/MediaServer_12.8_Documentation/Help/index.html#Configuration/Ingest/Libav/_Libav.htm) type ingest engine.  Media Server also includes the following additional ingest engines to support alternative stream types:

- [MJPEG](https://www.microfocus.com/documentation/idol/IDOL_12_8/MediaServer_12.8_Documentation/Help/index.html#Configuration/Ingest/MJPEG/_MJPEG.htm): for cameras supporting motion Jpeg streaming
- [MxPEG](https://www.microfocus.com/documentation/idol/IDOL_12_8/MediaServer_12.8_Documentation/Help/index.html#Configuration/Ingest/MXPEG/_MXPEG.htm): for [Mobotix](https://www.mobotix.com/en/mxpeg) cameras
- [Genetec](https://www.microfocus.com/documentation/idol/IDOL_12_8/MediaServer_12.8_Documentation/Help/index.html#Configuration/Ingest/Genetec/_Genetec.htm): to connect to any camera already integrated into the Genetec Security Center Video Management System (VMS)
- [Milestone](https://www.microfocus.com/documentation/idol/IDOL_12_8/MediaServer_12.8_Documentation/Help/index.html#Configuration/Ingest/Milestone/_Milestone.htm): to connect to any camera already integrated into the Milestone XProtect VMS

### Academic datasets

> Please check the license terms for these datasets.

- [COCO](http://cocodataset.org/): The Common Objects in COntext dataset is a large-scale object detection, segmentation, and captioning benchmark.
- [ImageNet](http://www.image-net.org/): ImageNet is an image dataset organized according to the WordNet hierarchy.
- [LFW](http://vis-www.cs.umass.edu/lfw/): The University of Massachusetts Labeled Faces in the Wild dataset is a public benchmark for face verification.
- [MS-Celeb-1M](https://github.com/EB-Dodo/C-MS-Celeb): The Microsoft Research One Million Celebrities in the Real World dataset is a benchmark for large-scale face recognition.
- [PETS2009](http://cs.binghamton.edu/~mrldata/pets2009): The IEEE International Workshop on Performance Evaluation of Tracking and Surveillance 2009 dataset is a public benchmark for the characterization of different crowd activities.

    > The PETS2009 dataset is provided as folders of stills.  To concatenate them into videos, use the ffmpeg command:
    > ```bsh
    > ffmpeg -r 7 -i S3/Multiple_Flow/Time_12-43/View_008/frame_%04d.jpg -c:v libx264 -vf fps=25 -pix_fmt yuv420p S3_MF_Time_12-43_View_008.mp4
    > ```

- [UA-DETRAC](http://detrac-db.rit.albany.edu/home): The University at Albany DEtection and TRACking dataset is a benchmark for challenging real-world multi-object detection and multi-object tracking.

    > The UA-DETRAC dataset is provided as folders of stills.  To concatenate them into videos, use the ffmpeg command:
    > ```bsh
    > ffmpeg -r 25 -i ./MVI_40864/img%05d.jpg -c:v libx264 -vf fps=25 -pix_fmt yuv420p MVI_40864.mp4
    > ```

## Working with video sources

The two main tools to keep handy are ffmpeg and VLC player.  They have overlapping capabilities, so in the following example tips we will use a mix of both to give you a small flavour of what each is capable of.

### Test availability of an IP stream

With ffmpeg, you also get an executable called `ffplay`. From the command line you can ingest, *e.g.* this HLS stream:

```bsh
ffplay http://live-hls-web-aje.getaj.net/AJE/03.m3u8
```

This executable uses the same underlying libraries as Media Server. So, if you can play with this, it is highly likely you can ingest with Media Server.

### Record video/audio from an IP stream

From the command line, *e.g.* to record a five minute clip:

```bsh
ffmpeg -i http://live-hls-web-aje.getaj.net/AJE/03.m3u8 -t 300 clip-5mins.mp4
```

From the command line, *e.g.* to record from a CCTV camera's RTSP stream in five minute chunks, maintaining the original video encoding:

```bsh
ffmpeg -i rtsp://host:port/channel -f segment -segment_time 300 -an -vcodec copy clip%04d.ts
```

From the command line, *e.g.* to record from a CCTV camera's MJPEG stream in five minute chunks, with a workaround to estimate frame timestamps (for which transcoding is required):

```bsh
ffmpeg -use_wallclock_as_timestamps 1 -i http://localhost:port/ -f segment -segment_time 300 -an -vcodec h264 clip%04d.mp4
```

### Download a video from YouTube

The free tool `youtube-dl` allows you to download video files from YouTube.

Obtain it through your Python package manager:

```bsh
pip install youtube-dl
```

You can now query a YouTube video URL for available formats:

```bsh
$ youtube-dl https://www.youtube.com/watch?v=8bCM0BPwhXE --list-formats
[youtube] 8bCM0BPwhXE: Downloading webpage 
[youtube] 8bCM0BPwhXE: Downloading video info webpage 
[youtube] 8bCM0BPwhXE: Downloading MPD manifest 
[youtube] 8bCM0BPwhXE: Downloading MPD manifest 
[info] Available formats for 8bCM0BPwhXE: 
format code extension resolution note 
139 m4a audio only DASH audio 50k , m4a_dash container, mp4a.40.5@ 48k (22050Hz), 844.27KiB 
140 m4a audio only DASH audio 129k , m4a_dash container, mp4a.40.2@128k (44100Hz), 2.20MiB 
160 mp4 256x144 DASH video 108k , mp4_dash container, avc1.4d400b, 24fps, video only 
133 mp4 426x240 DASH video 242k , mp4_dash container, avc1.4d400c, 24fps, video only 
134 mp4 640x360 DASH video 634k , mp4_dash container, avc1.4d401e, 24fps, video only, 5.47MiB 
135 mp4 854x480 DASH video 1155k , mp4_dash container, avc1.4d4014, 24fps, video only 
136 mp4 1280x720 DASH video 2321k , mp4_dash container, avc1.4d401f, 24fps, video only, 21.13MiB 
17 3gp 176x144 small , mp4v.20.3, mp4a.40.2@ 24k, 1.33MiB 
36 3gp 320x180 small , mp4v.20.3, mp4a.40.2, 3.65MiB 
18 mp4 640x360 medium , avc1.42001E, mp4a.40.2@ 96k, 9.97MiB 
43 webm 640x360 medium , vp8.0, vorbis@128k, 12.65MiB
22 mp4 1280x720 hd720 , avc1.64001F, mp4a.40.2@192k (best)
```

I want the best available quality, which is format code 22.  I can then download that video as follows:

```bsh
youtube-dl -f 22 https://www.youtube.com/watch?v=8bCM0BPwhXE
```

### Record video/audio from a live YouTube channel

Live YouTube channels wrap standard HLS streams in their own API.  The free tool `youtube-dl` allows you to easily work with this.

Obtain it through your Python package manager:

```bsh
pip install youtube-dl
```

Then query a channel for available HLS streams:

```bsh
$ youtube-dl https://www.youtube.com/watch?v=jL8uDJJBjMA --list-formats
[youtube] jL8uDJJBjMA: Downloading webpage
[youtube] jL8uDJJBjMA: Downloading video info webpage
WARNING: Unable to extract video title
[youtube] jL8uDJJBjMA: Downloading m3u8 information
[youtube] jL8uDJJBjMA: Downloading MPD manifest
[info] Available formats for jL8uDJJBjMA:
format code extension resolution note
91 mp4 256x144 HLS 197k , avc1.42c00b, 30.0fps, mp4a.40.5@ 48k
92 mp4 426x240 HLS 338k , avc1.4d4015, 30.0fps, mp4a.40.5@ 48k
93 mp4 640x360 HLS 829k , avc1.4d401e, 30.0fps, mp4a.40.2@128k
94 mp4 854x480 HLS 1380k , avc1.4d401f, 30.0fps, mp4a.40.2@128k
95 mp4 1280x720 HLS 2593k , avc1.4d401f, 30.0fps, mp4a.40.2@256k
96 mp4 1920x1080 HLS 4715k , avc1.640028, 30.0fps, mp4a.40.2@256k (best)
```

I want the highest possible audio quality but I will throw away the video, so I'll choose the lowest available which is format code 95.  I can then record that stream continuously with ffmpeg in one-minute segments, copying the audio and dropping the video as follows:

```bsh
ffmpeg -i $(youtube-dl -f 95 https://www.youtube.com/watch?v=jL8uDJJBjMA --get-url) -f segment -segment_time 60 -vn -acodec copy recording%04d.aac
```

To record the video and audio, I would modify that command to:

```bsh
ffmpeg -i $(youtube-dl -f 95 https://www.youtube.com/watch?v=jL8uDJJBjMA --get-url) -f segment -segment_time 60 -c copy recording%04d.mp4
```

### Examine the metadata of a video file

With ffmpeg, you also get an executable called `ffprobe`. From the command line:

```bsh
ffprobe -v quiet -print_format json -show_format -show_streams myVideo.mp4
```

### Extract still images from a video file

Use ffmpeg to extract an image from the third second of your video:

```bsh
ffmpeg -ss 00:00:03 -i path\to\my\video.mp4 -frames:v 1 path\to\interesting\frame.png
```

Use ffmpeg to extract one image every second from a video, starting from the third second:

```bsh
ffmpeg -ss 00:00:03 -i path\to\my\video.mp4 -vf fps=1 out%03d.png
```

For more details, read this [documentation](https://trac.ffmpeg.org/wiki/Create%20a%20thumbnail%20image%20every%20X%20seconds%20of%20the%20video).

### Make a video clip of an interesting section

Use ffmpeg to create a 135 second long clip, starting from the 1st hour, 6th minute and 11th second of your video:

```bsh
ffmpeg -ss 01:06:11 -i path\to\my\video.ext -t 135 path\to\interesting\clip.ext
```

or

```bsh
ffmpeg -i path\to\my\video.ext -ss 01:06:11 -t 135 path\to\interesting\clip.ext
```

If the start time `-ss` option is passed before the input `-i`, ffmpeg will jump straight to that time in the video. Although this is a faster option, you might start copying far away from an I-frame and so have some mess at the start of your clip.

If the start time `-ss` option is passed after the input `-i`, ffmpeg will process all frames from the start. This can be a slower option but guarantees that your clip will be created with an full frame at the start.

### Concatenate video clips into one video file

Create a playlist file, called *e.g.* `playlist.txt`, containing the text:

```ini
# comment
file 'path\to\my\first\video.ext'
file 'path\to\my\second\video.ext'
file 'path\to\my\third\video.ext'
```

Then use ffmpeg to perform the concatenation:

```bsh
ffmpeg -f concat -i playlist.txt -c copy output.ext
```

For more details, read this [documentation](https://trac.ffmpeg.org/wiki/Concatenate).

### Ingest a sequence of videos as a playlist

IDOL Media Server can read a playlist file in order to ingest a sequence of video files in a single process action.  The easiest way to ingest a playlist file, is with the Ingest Test page:

![playlist-ingest](./figs/playlist-ingest.png)

> To do this, note the Video-type ingest engine requires the `Format` option to be set to `Concat`.

### Add tracks to existing media file

To add an empty audio track to a video file: 

```bsh
ffmpeg -f lavfi -i aevalsrc=0 -i in.mp4 -vcodec copy -acodec aac -map 0:0 -map 1:0 -shortest -strict experimental -y out.mp4
```

To add a video track to an audio file by looping over an image file:

```bsh
ffmpeg -loop 1 -i image.png -i audio.mp3 -shortest out.mp4
```

### Strip tracks to existing media file

To remove the audio track to a video file: 

```bsh
ffmpeg -i in.mp4 -vcodec copy -an out.mp4
```

### Loop a video file to produce a continuous RTSP stream

Sometimes I want to to analyse a video file on a loop for testing. This can be achieved by creating a looping stream of the video content. Using VLC player, from the command line:

```bsh
vlc C:\video\anpr.mp4 --loop :sout=#duplicate{dst=rtp{sdp=rtsp://127.0.0.1:8554/mystream} } :sout-all :sout-keep
```

To view this stream in VLC player, from the command line:

```bsh
vlc rtsp://127.0.0.1:8554/mystream
```

To process this stream with Media Server, do:

<http://127.0.0.1:14000/action=process&source=rtsp://127.0.0.1:8554/mystream&persist=true&configName=mySessionConfig>

, where setting `persist=true` instructs Media Server to wait out any short term interruptions in the incoming video stream that can occur due to network latency.

## Next steps

Why not try some tutorials to explore some of the analytics available in Media Server, linked from the [main page](../../README.md).
