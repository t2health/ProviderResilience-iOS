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
 @brief Controls your region selection for all libraries from Brightcove.
 
 The BCConfigManager class controls your region selection for all libraries from Brightcove.
 This changes the end point for api calls (api.brightcove.com and api.brightcove.co.jp) and 
 tracking urls also go the the correct region.
 
 @section Sample Code
 @code
 // Don't forget to include this line in your source:
 #import "BCConfigManager.h"
 
 [[BCConfigManager sharedInstance] setRegion:BCRegionJP];
 
 BCMediaAPI *api = [[BCMediaAPI alloc] initWithReadToken:APIToken];
 NSError *e;
 self.video = [api findVideoById:self.vId error:&e]; // makes a call to api.brightcove.co.jp
 @endcode
 */
@interface BCConfigManager : NSObject {
    BCRegion region;
    BOOL logging;
}

+ (BCConfigManager *)sharedInstance;

/**
 @brief Used to target different end points and tracking urls.
 
 Developers deploying apps that work with content from a JP region account can use this
 setting to target .co.jp urls. The default is .com urls BCRegionUS.
 */
@property (nonatomic, assign) BCRegion region;

/**
 @brief Turns on call, response, bit-rate selection logging to the console
 
 The data being sent to the server, the raw response and the rendition the 
 player has selected are logged to the console. Turn this setting off for 
 release builds.
 */
@property (nonatomic, assign) BOOL logging;

@end
