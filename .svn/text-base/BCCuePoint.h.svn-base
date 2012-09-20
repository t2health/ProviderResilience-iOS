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
 @brief The BCCuePoint model object
 
 This object describes metadata related to a specific point within
 a video as programmed by the content owner through the Brightcove 
 services.
 */
@interface BCCuePoint : NSObject 
{
	NSString *name;
	NSString *videoId;
	long long time;
	BOOL forceStop;
	BCCuePointType type;
	NSString *metadata;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *videoId;
@property (nonatomic, assign) long long time;
@property (nonatomic, assign) BOOL forceStop;
@property (nonatomic, assign) BCCuePointType type;
@property (nonatomic, retain) NSString *metadata;

@end
