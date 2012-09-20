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
 @brief The BCImage model object
 
 This object describes metadata linked to an image, typically 
 either a thumbnail or still frame, in the Brightcove system.
 */
@interface BCImage : NSObject 
{
	long long imageId;
	NSString *referenceId;
	BCImageType type;
	NSString *remoteUrl;
	NSString *displayName;
}

@property (nonatomic, assign) long long imageId;
@property (nonatomic, retain) NSString *referenceId;
@property (nonatomic, assign) BCImageType type;
@property (nonatomic, retain) NSString *remoteUrl;
@property (nonatomic, retain) NSString *displayName;

@end
