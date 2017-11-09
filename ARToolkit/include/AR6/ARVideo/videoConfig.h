/*
 *	videoConfig.h
 *  ARToolKit6
 *
 *  This file is part of ARToolKit.
 *
 *  Copyright 2015-2017 Daqri, LLC.
 *  Copyright 2002-2015 ARToolworks, Inc.
 *
 *  Author(s): Hirokazu Kato, Philip Lamb
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *
 */

#ifndef __ARvideo_videoConfig_h__
#define __ARvideo_videoConfig_h__

#include "config.h"

#ifdef  __cplusplus
extern "C" {
#endif

#ifdef AR6_ARVIDEO_INPUT_V4L
#define   AR_VIDEO_V4L_MODE_PAL              0
#define   AR_VIDEO_V4L_MODE_NTSC             1
#define   AR_VIDEO_V4L_MODE_SECAM            2
#define   AR_VIDEO_V4L_DEFAULT_DEVICE        "/dev/video0"
#define   AR_VIDEO_V4L_DEFAULT_WIDTH         640
#define   AR_VIDEO_V4L_DEFAULT_HEIGHT        480
#define   AR_VIDEO_V4L_DEFAULT_CHANNEL       3
#define   AR_VIDEO_V4L_DEFAULT_MODE          AR_VIDEO_V4L_MODE_NTSC
#endif

#ifdef AR6_ARVIDEO_INPUT_V4L2
#define   AR_VIDEO_V4L2_MODE_PAL              0
#define   AR_VIDEO_V4L2_MODE_NTSC             1
#define   AR_VIDEO_V4L2_MODE_SECAM            2
#define   AR_VIDEO_V4L2_DEFAULT_DEVICE        "/dev/video0"
#define   AR_VIDEO_V4L2_DEFAULT_WIDTH         640
#define   AR_VIDEO_V4L2_DEFAULT_HEIGHT        480
#define   AR_VIDEO_V4L2_DEFAULT_CHANNEL       0
#define   AR_VIDEO_V4L2_DEFAULT_MODE          AR_VIDEO_V4L2_MODE_NTSC
#endif


#ifdef AR6_ARVIDEO_INPUT_LIBDC1394
enum {
    AR_VIDEO_1394_MODE_320x240_YUV422 = 32,
    AR_VIDEO_1394_MODE_640x480_YUV411,
    AR_VIDEO_1394_MODE_640x480_YUV411_HALF,
    AR_VIDEO_1394_MODE_640x480_YUV422,
    AR_VIDEO_1394_MODE_640x480_RGB,
    AR_VIDEO_1394_MODE_640x480_MONO,
    AR_VIDEO_1394_MODE_640x480_MONO_COLOR,
    AR_VIDEO_1394_MODE_640x480_MONO_COLOR_HALF,
    AR_VIDEO_1394_MODE_640x480_MONO_COLOR2,
    AR_VIDEO_1394_MODE_640x480_MONO_COLOR_HALF2,
    AR_VIDEO_1394_MODE_640x480_MONO_COLOR3,
    AR_VIDEO_1394_MODE_640x480_MONO_COLOR_HALF3,
    AR_VIDEO_1394_MODE_800x600_RGB,
    AR_VIDEO_1394_MODE_800x600_MONO,
    AR_VIDEO_1394_MODE_800x600_MONO_COLOR,
    AR_VIDEO_1394_MODE_800x600_MONO_COLOR_HALF,
    AR_VIDEO_1394_MODE_800x600_MONO_COLOR2,
    AR_VIDEO_1394_MODE_800x600_MONO_COLOR_HALF2,
    AR_VIDEO_1394_MODE_800x600_MONO_COLOR3,
    AR_VIDEO_1394_MODE_800x600_MONO_COLOR_HALF3,
    AR_VIDEO_1394_MODE_1024x768_RGB,
    AR_VIDEO_1394_MODE_1024x768_MONO,
    AR_VIDEO_1394_MODE_1024x768_MONO_COLOR,
    AR_VIDEO_1394_MODE_1024x768_MONO_COLOR_HALF,
    AR_VIDEO_1394_MODE_1024x768_MONO_COLOR2,
    AR_VIDEO_1394_MODE_1024x768_MONO_COLOR_HALF2,
    AR_VIDEO_1394_MODE_1024x768_MONO_COLOR3,
    AR_VIDEO_1394_MODE_1024x768_MONO_COLOR_HALF3,
    AR_VIDEO_1394_MODE_1280x720_RGB,
    AR_VIDEO_1394_MODE_1280x720_MONO,
    AR_VIDEO_1394_MODE_1280x720_MONO_COLOR,
    AR_VIDEO_1394_MODE_1280x720_MONO_COLOR_HALF,
    AR_VIDEO_1394_MODE_1280x720_MONO_COLOR2,
    AR_VIDEO_1394_MODE_1280x720_MONO_COLOR_HALF2,
    AR_VIDEO_1394_MODE_1280x720_MONO_COLOR3,
    AR_VIDEO_1394_MODE_1280x720_MONO_COLOR_HALF3,
    AR_VIDEO_1394_MODE_1280x960_RGB,
    AR_VIDEO_1394_MODE_1280x960_MONO,
    AR_VIDEO_1394_MODE_1280x960_MONO_COLOR,
    AR_VIDEO_1394_MODE_1280x960_MONO_COLOR_HALF,
    AR_VIDEO_1394_MODE_1280x960_MONO_COLOR2,
    AR_VIDEO_1394_MODE_1280x960_MONO_COLOR_HALF2,
    AR_VIDEO_1394_MODE_1280x960_MONO_COLOR3,
    AR_VIDEO_1394_MODE_1280x960_MONO_COLOR_HALF3,
    AR_VIDEO_1394_MODE_1280x1024_RGB,
    AR_VIDEO_1394_MODE_1280x1024_MONO,
    AR_VIDEO_1394_MODE_1280x1024_MONO_COLOR,
    AR_VIDEO_1394_MODE_1280x1024_MONO_COLOR_HALF,
    AR_VIDEO_1394_MODE_1280x1024_MONO_COLOR2,
    AR_VIDEO_1394_MODE_1280x1024_MONO_COLOR_HALF2,
    AR_VIDEO_1394_MODE_1280x1024_MONO_COLOR3,
    AR_VIDEO_1394_MODE_1280x1024_MONO_COLOR_HALF3,
    AR_VIDEO_1394_MODE_1600x900_RGB,
    AR_VIDEO_1394_MODE_1600x900_MONO,
    AR_VIDEO_1394_MODE_1600x900_MONO_COLOR,
    AR_VIDEO_1394_MODE_1600x900_MONO_COLOR_HALF,
    AR_VIDEO_1394_MODE_1600x900_MONO_COLOR2,
    AR_VIDEO_1394_MODE_1600x900_MONO_COLOR_HALF2,
    AR_VIDEO_1394_MODE_1600x900_MONO_COLOR3,
    AR_VIDEO_1394_MODE_1600x900_MONO_COLOR_HALF3,
    AR_VIDEO_1394_MODE_1600x1200_RGB,
    AR_VIDEO_1394_MODE_1600x1200_MONO,
    AR_VIDEO_1394_MODE_1600x1200_MONO_COLOR,
    AR_VIDEO_1394_MODE_1600x1200_MONO_COLOR_HALF,
    AR_VIDEO_1394_MODE_1600x1200_MONO_COLOR2,
    AR_VIDEO_1394_MODE_1600x1200_MONO_COLOR_HALF2,
    AR_VIDEO_1394_MODE_1600x1200_MONO_COLOR3,
    AR_VIDEO_1394_MODE_1600x1200_MONO_COLOR_HALF3
};
#define   AR_VIDEO_1394_FRAME_RATE_1_875                1
#define   AR_VIDEO_1394_FRAME_RATE_3_75                 2
#define   AR_VIDEO_1394_FRAME_RATE_7_5                  3
#define   AR_VIDEO_1394_FRAME_RATE_15                   4
#define   AR_VIDEO_1394_FRAME_RATE_30                   5
#define   AR_VIDEO_1394_FRAME_RATE_60                   6
#define   AR_VIDEO_1394_FRAME_RATE_120                  7
#define   AR_VIDEO_1394_FRAME_RATE_240                  8
#define   AR_VIDEO_1394_SPEED_400                       1
#define   AR_VIDEO_1394_SPEED_800                       2

#if AR6_ARVIDEO_INPUT_LIBDC1394_DEFAULT_PIXEL_FORMAT == AR_PIXEL_FORMAT_MONO
#  if defined(AR6_ARVIDEO_INPUT_LIBDC1394_USE_FLEA_XGA)
#    define   AR_VIDEO_1394_DEFAULT_MODE               AR_VIDEO_1394_MODE_1024x768_MONO
#  else
#    define   AR_VIDEO_1394_DEFAULT_MODE               AR_VIDEO_1394_MODE_640x480_MONO
#  endif
#else
#  if defined(AR6_ARVIDEO_INPUT_LIBDC1394_USE_DRAGONFLY)
#    define   AR_VIDEO_1394_DEFAULT_MODE               AR_VIDEO_1394_MODE_640x480_MONO_COLOR
#  elif defined(AR6_ARVIDEO_INPUT_LIBDC1394_USE_DF_EXPRESS)
#    define   AR_VIDEO_1394_DEFAULT_MODE               AR_VIDEO_1394_MODE_640x480_MONO_COLOR2
#  elif defined(AR6_ARVIDEO_INPUT_LIBDC1394_USE_FLEA)
#    define   AR_VIDEO_1394_DEFAULT_MODE               AR_VIDEO_1394_MODE_640x480_MONO_COLOR2
#  elif defined(AR6_ARVIDEO_INPUT_LIBDC1394_USE_FLEA_XGA)
#    define   AR_VIDEO_1394_DEFAULT_MODE               AR_VIDEO_1394_MODE_1024x768_MONO_COLOR
#  elif defined(AR6_ARVIDEO_INPUT_LIBDC1394_USE_DFK21AF04)
#    define   AR_VIDEO_1394_DEFAULT_MODE               AR_VIDEO_1394_MODE_640x480_MONO_COLOR3
#  else
#    define   AR_VIDEO_1394_DEFAULT_MODE               AR_VIDEO_1394_MODE_640x480_YUV411
#  endif
#endif
#define   AR_VIDEO_1394_DEFAULT_FRAME_RATE             AR_VIDEO_1394_FRAME_RATE_30
#define   AR_VIDEO_1394_DEFAULT_SPEED                  AR_VIDEO_1394_SPEED_400
#define   AR_VIDEO_1394_DEFAULT_PORT                   0
#endif

#ifdef  __cplusplus
}
#endif
#endif // !__ARvideo_videoConfig_h__
