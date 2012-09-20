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
#import "BCObject.h"

/**
 @brief The BCRendition model object 
 
 This object contains properties describing a particular video rendition format
 related to a video title in the Brightcove system. It is returned as part of the
 renditions array property of the BCVideo object. 
 
 Note that reading rendition and FLV URL data from a BCVideo requires an API key 
 that is authorized with greater security access privileges than those granted to 
 the standard API key.
 
 You do not typically instantiate a BCRendition object in your code.
 */
@interface BCRendition : NSObject 
{
	NSString *url;
	int encodingRate;
	int frameHeight;
	int frameWidth;
	long long size;
	NSString *remoteUrl;
	NSString *remoteStreamName;
	long long videoDuration;
	BCVideoCodec videoCodec;
    BOOL audioOnly;
    BCVideoContainer videoContainer;
}

@property (nonatomic, retain) NSString *url;
@property (nonatomic, assign) int encodingRate;
@property (nonatomic, assign) int frameHeight;
@property (nonatomic, assign) int frameWidth;
@property (nonatomic, assign) long long size;
@property (nonatomic, retain) NSString *remoteUrl;
@property (nonatomic, retain) NSString *remoteStreamName;
@property (nonatomic, assign) long long videoDuration;
@property (nonatomic, assign) BCVideoCodec videoCodec;
@property (nonatomic, assign) BOOL audioOnly;
@property (nonatomic, assign) BCVideoContainer videoContainer;

/**
 @brief Compare BCRenditions
 
 This is the method used to compare a BCRendition to another BCRendiotion instance. 
 */
- (BOOL)isEqualToBCRendition: (BCRendition *) object;

@end
