# PART II - Custom Language Models

The language models that ship with Media Server cover a broad vocabulary, reflecting the general spoken language. In some cases, you might want to process speech data that covers specialized topics, including for example financial or medical terms.  The standard language model might not cover such specialized vocabulary or sentence structures in your language.

Media Server enables us to build custom language models, which can be used to improve the quality of a transcribed speech related to a specific domain.

We will:

1. transcribe text from a news clip discussing political affairs in Libya
1. build a custom language model from news articles about Libyan politicians and cities
1. configure Media Server to use this custom model
1. reprocess the same news clip and compare the transcription results

<!-- TOC depthFrom:2 -->

- [Setup](#setup)
  - [Third-party software](#third-party-software)
- [Process configuration](#process-configuration)
- [Process our news clip](#process-our-news-clip)
- [Build the custom language model](#build-the-custom-language-model)
- [Reprocess the news clip](#reprocess-the-news-clip)
- [Next steps](#next-steps)

<!-- /TOC -->

## Setup

### Third-party software

Download and install [WinMerge](http://winmerge.org/downloads/) or you favorite text file *diff*-ing tool, so you can easily compare the results at the end.

## Process configuration

We will use a similar configuration to Part I, modified slightly to instruct Media Server to ingest a video file rather than a stream and output a single plain text transcript for our news clip.

To ingest a video file, we will update the `Ingest` and `Analysis` sections accordingly:

1. set the `IngestRate` to `0` to process every frame and so ensure repeatable results

    ```ini
    [Session]
    Engine0 = VideoIngest
    # Process every frame in the video irrespective of time taken
    IngestRate = 0
    ```

1. set `IngestDateTime` to `0` to output results in file time rather than clock time

    ```ini
    [VideoIngest]
    Type = Video
    # Use video time rather than clock time
    IngestDateTime = 0
    ```

1. modify the analysis `SpeedBias` to disable the adaptive quality level applied on live streams.  When processing files, the `SpeedBias` parameter effects the trade-off between transcription quality and processing time.

    ```ini
    [SpeechToText]
    Type = SpeechToText
    LanguagePack = ENUK
    SpeedBias = 3
    ```

    > More options are available for the *SpeechToText* analysis engine.  Please refer to the [reference guide](https://www.microfocus.com/documentation/idol/IDOL_12_6/MediaServer_12.6_Documentation/Help/index.html#Configuration/Analysis/SpeechToText/_SpeechToText.htm) for details.

1. To create a single plain text file transcript for the video clip, we will configure an XML-type output engine with `Mode` set to `AtEnd` and the `toText.xsl` transform as follows:

    ```ini
    [TextOutput]
    Type = XML
    Input = SpeechToText.Result
    Mode = AtEnd
    XMLOutputPath = output/speechToText2/transcript.txt
    XslTemplate = toText.xsl
    ```

## Process our news clip

1. Copy the process configuration file `speechToText2.cfg` from this guide into `configurations/tutorials`.

1. Copy the sample video file `aljazeera.mp4` from this guide into `C:\MicroFocus\video`. 

1. Paste the following parameters into [`test-action`](http://127.0.0.1:14000/a=admin#page/console/test-action):

    ```url
    action=process&source=C:\MicroFocus\video\aljazeera.mp4&configName=tutorials/speechToText2
    ```

1. Click the `Test Action` button to start processing.

Review the results as they are produced with [`/action=GetLatestRecord`](http://127.0.0.1:14000/a=getlatestrecord). The final text transcript will be produced after the whole video clip has been processed.  Navigate to `output/speechToText2` and open the transcript file to read the results.

## Build the custom language model

The first step in creating a custom model is to source suitable text materials.  These should contain descriptive text written in normal sentences, not just a dictionary of new terms. For this tutorial we have sourced a small set of materials for you, copying the text from a news article about similar events in Libya into the file `libya.txt`, which is included with this guide.  In practice, the more data you have (and the more representative that data is) the better. Please read the [admin guide](https://www.microfocus.com/documentation/idol/IDOL_12_6/MediaServer_12.6_Documentation/Guides/html/English/index.html#Training/CustomLM_Introduction.htm), for further advice.

> This text file should be encoded in UTF-8, without [BOM](https://en.wikipedia.org/wiki/Byte_order_mark#UTF-8).

We will next instruct Media Server to build our custom language model from this text:

1. paste the following parameters into [`test-action`](http://127.0.0.1:14000/a=admin#page/console/test-action):
    ```url
    action=TrainCustomSpeechLanguageModel&identifier=LibyaTerms&languagepack=ENUK&textpath=C:\MicroFocus\idol-rich-media-tutorials\tutorials\showcase\speech-transcription\libya.txt
    ```
1. click the `Test Action` button to start building
1. go to [`/action=getStatus`](http://127.0.0.1:14000/a=queueinfo&queuename=TrainCustomSpeechLanguageModel&queueaction=getstatus) to see the training status
1. we can review the results with [`/action=ListCustomSpeechLanguageModels`](http://127.0.0.1:14000/action=ListCustomSpeechLanguageModels). These results indicate the relative weights that could be given to the custom and default models when combined:

    ```xml
    <languagemodels>
      <languagemodel>
        <identifier>LibyaTerms</identifier>
        <language>ENUK</language>
        <totalWords>3311</totalWords>
        <uniqueWords>1068</uniqueWords>
        <recommendedWeight>0.3</recommendedWeight>
      </languagemodel>
    </languagemodels>
    ```

    So, when we come to use this custom model, we are recommended to apply a relative weight of 30% to the likelihood of matching these new terms *vs.* terms in the main ENUK language model.

## Reprocess the news clip

First, we will modify our Media Server process configuration to pick up this custom model, as follows:

```ini
[SpeechToText]
Type = SpeechToText
LanguagePack = ENUK
CustomLanguageModel = LibyaTerms:0.3
SpeedBias = 3
```

Then follow the same steps to reprocess:

1. Copy the process configuration file `speechToText3.cfg` from this guide into `configurations/tutorials`.
1. Paste the following parameters into [`test-action`](http://127.0.0.1:14000/a=admin#page/console/test-action):

    ```url
    action=process&source=C:\MicroFocus\video\aljazeera.mp4&configName=tutorials/speechToText3
    ```

1. Click the `Test Action` button to start processing.

The new text transcript will be produced after the whole video clip has been processed in the directory `output/speechToText3`.

We can now compare the results, *e.g.* with WinMerge, to see improvements in people names, place names and related vocabulary:

![news-srt](./figs/language-model-diff.png)

## Next steps

Why not try more tutorials to explore some of the other analytics available in Media Server, linked from the [main page](../../README.md).
