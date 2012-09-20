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
#import "BCRendition.h"

/**
 @brief The BCVideo model object 
 
 This object contains properties describing a video in the Brightcove system. It is 
 returned either singly or as part of the items array of a BCItemCollection from 
 video-related API calls.
 
 You do not typically instantiate a BCVideo object in your code.
 */
@interface BCVideo : NSObject 
{
	NSString *name;
	long long videoId;
	NSString *referenceId;
	long long accountId;
	NSString *shortDescription;
	NSString *longDescription;
	NSString *FLVURL;
	NSArray *renditions;
	BCRendition *videoFullLength;
	NSDate *creationDate;
	NSDate *publishedDate;
	NSDate *lastModifiedDate;
	BCItemState itemState;
	NSDate *startDate;
	NSDate *endDate;
	NSString *linkURL;
	NSString *linkText;
	NSArray *tags;
	NSString *videoStillURL;
	NSString *thumbnailURL;
	long long length;
	BCEconomics economics;
	BOOL geoFiltered;
	NSArray *geoFilteredCountries;
	BOOL geoFilterExclude;
	NSArray *cuePoints;
	long long playsTotal;
	long long playsTrailingWeek;
    NSDictionary *customFields;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, assign) long long videoId;
@property (nonatomic, retain) NSString *referenceId;
@property (nonatomic, assign) long long accountId;
@property (nonatomic, retain) NSString *shortDescription;
@property (nonatomic, retain) NSString *longDescription;
@property (nonatomic, retain) NSString *FLVURL;
@property (nonatomic, retain) NSArray *renditions;
@property (nonatomic, retain) BCRendition *videoFullLength;
@property (nonatomic, retain) NSDate *creationDate;
@property (nonatomic, retain) NSDate *publishedDate;
@property (nonatomic, retain) NSDate *lastModifiedDate;
@property (nonatomic, assign) BCItemState itemState;
@property (nonatomic, retain) NSDate *startDate;
@property (nonatomic, retain) NSDate *endDate;
@property (nonatomic, retain) NSString *linkURL;
@property (nonatomic, retain) NSString *linkText;
@property (nonatomic, retain) NSArray *tags;
@property (nonatomic, retain) NSString *videoStillURL;
@property (nonatomic, retain) NSString *thumbnailURL;
@property (nonatomic, assign) long long length;
@property (nonatomic, assign) BCEconomics economics;
@property (nonatomic, assign) BOOL geoFiltered;
@property (nonatomic, retain) NSArray *geoFilteredCountries;
@property (nonatomic, assign) BOOL geoFilterExclude;
@property (nonatomic, retain) NSArray *cuePoints;
@property (nonatomic, assign) long long playsTotal;
@property (nonatomic, assign) long long playsTrailingWeek;
@property (nonatomic, retain) NSDictionary *customFields;

+ (BCVideo *) initFromDictionary:(NSDictionary *) dict;

+ (NSDictionary *) toDictionary:(BCVideo *) video;

/**
 @brief Compare BCVideos
 
 This is the method used to compare a BCVideo to another BCVideo instance. 
 */
- (BOOL)isEqualToBCVideo:(id)object;

@end
