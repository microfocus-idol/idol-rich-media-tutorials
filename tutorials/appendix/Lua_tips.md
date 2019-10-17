# Lua scripting tips

<!-- TOC depthFrom:2 -->

- [Logging](#logging)
- [Accessing record data](#accessing-record-data)
  - [Example records](#example-records)
  - [Output Lua records](#output-lua-records)
- [Next steps](#next-steps)

<!-- /TOC -->

For an introduction to the Lua language, look no further than [lua.org](https://www.lua.org/pil/contents.html).

## Logging

When developing your own Lua scripts, it is obviously useful to be able to log values to check your logic.  Media Server provides a logging function to do just that, which is used as follows:

```lua
function pred(record)
  local oopangle = record.FaceData.outofplaneanglex
  log("Out of plane angle x: " .. oopangle)
  ...
end
```

To enable this logging, the following section needs to be included in the `mediaserver.cfg` file:

```ini
[Logging]
...
7=LUA_LOG_STREAM

[LUA_LOG_STREAM]
LogFile=lua.log
LogTypeCSVs=lua
```

## Accessing record data

It is also very useful to have a reference of the record data structure so that you know which values are available and how to access them, *e.g.*

```lua
local oopangle = record.FaceData.outofplaneanglex
```

### Example records

Media Server provides a useful action to list the record data structure for your analytic of interest, in this case *Face Detection*.  Launch this action in your browser to see the structure:

```url
http://localhost:14000/action=GetExampleRecord&EngineType=FaceDetect&Track=Result
```

, which returns the following Lua *table* (as well as an XML representation of the same record):

```lua
{
  trackname = 'exampleEngine.Result',
  timestamp = {
    startTime = '0',
    duration = '1000000',
    endTime = '1000000',
    peakTime = '0',
  },
  FaceData = {
    lefteye = {
      center = { x = 199.093, y = 136.59, },
      radius = 2.64936,
    },
    region = { top = 167, height = 52, width = 52, left = 123, },
    righteye = {
      center = { x = 181.328, y = 139.929, },
      radius = 3.0446,
    },
    ellipse = {
      center = { x = 192, y = 148, },
      a = 22.5955,
      angle = -10.6418,
      b = 31.6337,
    },
    outofplaneangley = 0,
    percentageinimage = 100,
    outofplaneanglex = 0,
  },
  FaceResult = {
    face = {
      lefteye = {
        center = { x = 199.093, y = 136.59, },
        radius = 2.64936,
      },
      region = { top = 167, height = 52, width = 52, left = 123, },
      righteye = {
        center = { x = 181.328, y = 139.929, },
        radius = 3.0446,
      },
      ellipse = {
        center = { x = 192, y = 148, },
        a = 22.5955,
        angle = -10.6418,
        b = 31.6337,
      },
      outofplaneangley = 0,
      percentageinimage = 100,
      outofplaneanglex = 0,
    },
    id = {
        uuid = '4d69390f-a8c4-4c5d-a0b0-705a3f98aa9b',
    },
  },
  RegionData = { top = 167, height = 52, width = 52, left = 123, },
  UUIDData = { uuid = '4d69390f-a8c4-4c5d-a0b0-705a3f98aa9b', },
}
```

You will notice that the table structure contains some repetition.  The following keys reference sub-tables which mirror the structure seen in the XML:

- trackname
- timestamp
- FaceResult

In addition there are three other keys, which are named for Media Server data types, and act as alternative accessors to the same data:

- FaceData
- RegionData
- UUIDData

These alternatives can be more convenient than the XML-style paths since they allow you to write more reusable code.  For example to access a face's width, we can use:

```lua
local width = record.FaceData.region.width
```

, which is equivalent to all of these XML-style paths for related analytics:

```lua
local width = record.FaceResult.face.region.width
local width = record.FaceResultAndImage.face.region.width
local width = record.FaceStateResult.face.region.width
local width = record.FaceStateResultAndImage.face.region.width
local width = record.DemographicsResult.face.region.width
local width = record.DemographicsResultAndImage.face.region.width
local width = record.FaceRecognitionResult.face.region.width
local width = record.FaceRecognitionResultAndImage.face.region.width
```

### Output Lua records

Media Server provides a [Lua output engine](https://www.microfocus.com/documentation/idol/IDOL_12_3/MediaServer_12.3_Documentation/Help/index.html#Configuration/OutputEngines/Lua/_Lua.htm), which produces a Lua representation of each record that it receives, and writes it to a file on disk. You can use the output to help you to write and troubleshoot Lua scripts.

An example configuration file based on our first process session from [PART I](../introduction/PART_I.md#run-face-detection) of the introductory tutorial:

```ini
[Session]
Engine0 = VideoIngest
Engine1 = FaceDetection
Engine2 = OutputTrackedFaces

[VideoIngest]
Type = Video
Format = dshow

[FaceDetection]
Type = FaceDetect

[OutputTrackedFaces]
Type = lua
Input = FaceDetection.Result
LuaOutputPath=./output/faces1/%segment.startTime.timestamp%.lua
```

## Next steps

For more inspiration, see the examples under `configurations/lua`.
