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

/**
 @brief The BCItemCollection model object
 
 API calls which return a collection of videos or a collection of playlists
 do so in the form of BCItemCollection instances. The individual videos or
 playlists are available through this object's items array, while the other
 properties of the BCItemCollection enable your application to handle paging
 through a series of collections.
 
 This class corresponds to the Brightcove type defined here:
 http://docs.brightcove.com/en/media/#ItemCollection
 */
@interface BCItemCollection : NSObject 
{
	long long totalCount;
	NSArray *items;
	int pageNumber;
	int pageSize;
}

@property (nonatomic, assign) long long totalCount;
@property (nonatomic, retain) NSArray *items;
@property (nonatomic, assign) int pageNumber;
@property (nonatomic, assign) int pageSize;

@end
