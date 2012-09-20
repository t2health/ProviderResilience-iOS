/*
 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or
 sell copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:
 
 1.  The permission granted herein does not extend to commercial use of
 the Software by entities primarily engaged in providing online video
 and related services; and
 
 2.  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

#import <Foundation/Foundation.h>


@interface BCObject : NSObject {
}

typedef enum {
	BCSortByTypePublishDate = 0,
	BCSortByTypeCreationDate,
	BCSortByTypeModifiedDate,
	BCSortByTypePlaysTotal,
	BCSortByTypePlaysTrailingWeek
} BCSortByType;

typedef enum {
    BCSortOrderTypeASC = 0,
    BCSortOrderTypeDESC = 1
} BCSortOrderType;

typedef enum {
    BCItemStateActive = 0,
    BCItemStateInactive,
    BCItemStateDeleted
} BCItemState;

typedef enum {
    BCEconomicsFree = 0,
    BCEconomicsAdSupported
} BCEconomics;

typedef enum {
    BCVideoCodecSORENSON = 0,
    BCVideoCodecON2,
    BCVideoCodecH264
} BCVideoCodec;

typedef enum {
    BCPlaylistTypeOldestToNewest = 0,
    BCPlaylistTypeNewestToOldest,
    BCPlaylistTypeAlphabetical,
    BCPlaylistTypePlaysTotal,
    BCPlaylistTypePlaysTrailingWeek,
    BCPlaylistTypeExplicit,
    BCPlaylistTypeStartDateOldestToNewest,
    BCPlaylistTypeStartDateNewestToOldest
} BCPlaylistType;

typedef enum {
    BCImageTypeThumbnail = 0,
    BCImageTypeVideoStill
} BCImageType;

typedef enum {
    BCCuePointTypeAd = 0,
    BCCuePointTypeCode = 1,
    BCCUePointTypeChapter = 2
} BCCuePointType;

typedef enum {
    BCRegionUS = 0,
    BCRegionJP
} BCRegion;

typedef enum {
    BCMediaDeliveryTypeDefault = 0,
    BCMediaDeliveryTypeHTTP,
    BCMediaDeliveryTypeHTTP_IOS
} BCMediaDeliveryType;

typedef enum {
    BCVideoContainerFLV = 0,
    BCVideoContainerMP4,
    BCVideoContainerM2TS,
    BCVideoContainerWEBM
} BCVideoContainer;

@end
