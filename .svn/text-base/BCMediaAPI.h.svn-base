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

#import "BCVideo.h"
#import "BCRendition.h"
#import "BCPlaylist.h"
#import "BCImage.h"
#import "BCCuePoint.h"
#import "BCItemCollection.h"

/**
 @mainpage Brightcove Media API
 
 The Brightcove Media API is a Cocoa/Objective-C Library for employing the JSON based Brightcove Media API 
 The media API provides a Cocoa/Objective-C interface for the Brightcove video and playlist API's.
 
 @section The Brightcove Media API
 
 The Brightcove Media API provides a set of JSON services to access Brightcove
 content through custom application development. It is documented on the Brightcove site:
 
 http://docs.brightcove.com/en/media/
 
 Use of the Brightcove Media API requires a developer readToken granted by Brightcove support.
 No invocations in this library will succeed without a valid readToken.
 
 @section BCMediaAPI
 
 The BCMediaAPI class is a facade for all Brightcove Media API calls. This enables
 developers to instantiate it once and reuse it for all invocations:
 
 @code
 BCMediaAPI *bc = [[BCMediaAPI alloc] initWithReadToken:@"MyReadToken"];
 @endcode
 
 Invocations employ Cocoa-style error pointers, thus the 
 pattern for all invocations is similar to the following:
 
 @code
 
 NSError *err;
 BCVideo *video = [bc findVideoById:1234 error:&err];
 
 if (!video)
 {
	// if the result is nil, and we sent the optional error argument,
	// then the error will be populated by all underlying errors reported
	// by the Brightcove server. We can use this convenience method to dump
	// the NSError's userInfo, where the underlying errors are reported, to 
	// an NSString for logging or other purposes:
 
	NSString *errStr = [bc getErrorsAsString:err];
	NSLog(errStr);
 }

 @endcode
 
 For supported methods, view the BCMediaAPI class documentation or header file.
 */

/**
 @brief Creates a facade through which all Brightcove Media APIs may be invoked.
 
 Instantiate this class once and subsequently invoke its methods to interact with the
 remote Brightcove servers:
 
 @code
 BCMediaAPI *bc = [[BCMediaAPI alloc] initWithReadToken:@"MyApiKey"];
 @endcode
 
 Remember to release it when no longer needed.
 */
@interface BCMediaAPI : NSObject
{
	NSString *readToken;
    BCMediaDeliveryType mediaDeliveryType;
}

/**
 @brief Your Developer Read Token
 
 You must supply a valid Brightove developer read token either through this
 property or by using the initWithReadToken:(NSString *) convenience method.
 */
@property (nonatomic, retain) NSString *readToken;

/**
 @brief Used to set the media delivery type for your API calls.
 
 If your Account supports UDS you can turn this on to force http urls returned
 for your media urls. Playback on all iOS devices requires http access. The default 
 value is BCMediaDeliveryTypeDefault.
*/ 
@property (nonatomic, assign) BCMediaDeliveryType mediaDeliveryType;

/**
 @brief Convenience initialization method
 
 Use this method to instantiate a BCMediaAPI object that will subsequently employ 
 the parameterized read token for all interactions with the remote 
 Brightcove servers.
 */
- (id) initWithReadToken:(NSString *) rt;

/**
 @brief Convenience error logging method
 
 Errors logged by the remote Brightcove servers are stored in a standard
 NSError object, and underlying nested errors are passed in the NSError
 userInfo property. This method merely flattens that object's information 
 into a single NSString for logging or other pruposes.
 */
- (NSString *) getErrorsAsString:(NSError *) error;

#pragma mark Video Read APIs

/// A convenience method which invokes findAllVideos using default arguments for all parameters
- (BCItemCollection *) findAllVideos:(NSError **) error;

/// This method wraps the remote find_all_videos API request and returns a BCItemCollection containing the results
- (BCItemCollection *) findAllVideos:(int) pageSize pageNumber:(int)pageNumber sortBy:(BCSortByType)sortByType 
						sortOrder:(BCSortOrderType)sortOrderType getItemCount:(BOOL)getItemCount 
						videoFields:(NSArray *)videoFields customFields:(NSArray *)customFields
						error:(NSError **) error;

/// A convenience method which invokes findVideoById using the specified id and default arguments for optional parameters
- (BCVideo *) findVideoById:(long long) videoId error:(NSError **) error;

/// This method wraps the remote find_video_by_id API request and returns a BCVideo instance containing the results
- (BCVideo *) findVideoById:(long long) videoId videoFields:(NSArray *)videoFields 
						customFields:(NSArray *)customFields error:(NSError **) error;

/// A convenience method which invokes findRelatedVideos using the specified id and default arguments for optional parameters
- (BCItemCollection *) findRelatedVideos:(long long) videoId error:(NSError **) error;

/// This method wraps the remote find_related_videos API request and returns a BCItemCollection containing the results
- (BCItemCollection *) findRelatedVideos:(long long) videoId referenceId:(NSString *) referenceId 
						pageSize:(int) pageSize pageNumber:(int) pageNumber getItemCount:(BOOL) getItemCount 
						videoFields:(NSArray *)videoFields customFields:(NSArray *)customFields
						error:(NSError **) error;

/// A convenience method which invokes findVideosByIds using the specified NSArray of ids and default arguments for optional parameters
- (BCItemCollection *) findVideosByIds:(NSArray *) videoIds error:(NSError **) error;

/// This method wraps the remote find_videos_by_ids API request and returns a BCItemCollection containing the results
- (BCItemCollection *) findVideosByIds:(NSArray *) videoIds videoFields:(NSArray *) videoFields 
						customFields:(NSArray *)customFields error:(NSError **) error;

/// A convenience method which invokes findVideoByReferenceId using the specified reference id and default arguments for optional parameters
- (BCVideo *) findVideoByReferenceId:(NSString *) referenceId error:(NSError **) error;

/// This method wraps the remote find_video_by_reference_id API request and returns a BCVideo instance containing the results
- (BCVideo *) findVideoByReferenceId:(NSString *) referenceId videoFields:(NSArray *) videoFields 
						customFields:(NSArray *)customFields error:(NSError **) error;

/// A convenience method which invokes findVideosByReferenceIds using the specified reference id and default arguments for optional parameters
- (BCItemCollection *) findVideosByReferenceIds:(NSArray *) referenceIds error:(NSError **) error;

/// This method wraps the remote find_videos_by_reference_ids API request and returns a BCItemCollection containing the results
- (BCItemCollection *) findVideosByReferenceIds:(NSArray *) referenceIds videoFields:(NSArray *) videoFields 
						customFields:(NSArray *)customFields error:(NSError **) error;

/// A convenience method which invokes findVideoByUserId using the specified user id and default arguments for optional parameters
- (BCItemCollection *) findVideosByUserId:(NSString *) userId error:(NSError **) error;

/// This method wraps the remote find_videos_by_user_id API request and returns a BCItemCollection containing the results
- (BCItemCollection *) findVideosByUserId:(NSString *) userId pageSize:(int)pageSize pageNumber:(int)pageNumber
						sortBy:(BCSortByType)sortByType sortOrder:(BCSortOrderType)sortOrderType getItemCount:(BOOL)getItemCount 
						videoFields:(NSArray *)videoFields customFields:(NSArray *)customFields error:(NSError **) error;

/// A convenience method which invokes findModifiedVideos using the specified NSDate as a start date and default arguments for optional parameters
- (BCItemCollection *) findModifiedVideos:(NSDate *) fromDate error:(NSError **) error;

/// This method wraps the remote find_modified_videos API request and returns a BCItemCollection containing the results
- (BCItemCollection *) findModifiedVideos:(NSDate *) fromDate filters:(NSArray *) filters pageSize:(int)pageSize pageNumber:(int)pageNumber
						sortBy:(BCSortByType)sortByType sortOrder:(BCSortOrderType)sortOrderType getItemCount:(BOOL)getItemCount 
						videoFields:(NSArray *)videoFields customFields:(NSArray *)customFields error:(NSError **) error;

/// A convenience method which invokes findVideosByText using the specified text and default arguments for optional parameters
- (BCItemCollection *) findVideosByText:(NSString *) text error:(NSError **) error;

/// This method wraps the remote find_videos_by_text API request and returns a BCItemCollection containing the results
- (BCItemCollection *) findVideosByText:(NSString *) text pageSize:(int)pageSize pageNumber:(int)pageNumber getItemCount:(BOOL)getItemCount 
						videoFields:(NSArray *)videoFields customFields:(NSArray *)customFields error:(NSError **) error;

/// A convenience method which invokes findVideosByTags using the specified NSArray of andTag and orTags and default arguments for optional parameters
- (BCItemCollection *) findVideosByTags:(NSArray *) andTags orTags:(NSArray *)orTags error:(NSError **) error;

/// This method wraps the remote find_videos_by_tags API request and returns a BCItemCollection containing the results
- (BCItemCollection *) findVideosByTags:(NSArray *) andTags orTags:(NSArray *)orTags pageSize:(int)pageSize pageNumber:(int)pageNumber
						sortBy:(BCSortByType)sortByType sortOrder:(BCSortOrderType)sortOrderType getItemCount:(BOOL)getItemCount 
						videoFields:(NSArray *)videoFields customFields:(NSArray *)customFields error:(NSError **) error;

#pragma mark Playlist Read APIs

/**
 @brief Playlist Read APIs
 */

/// A convenience method which invokes findAllPlaylists using default arguments for all parameters
- (BCItemCollection *) findAllPlaylists:(NSError **) error;

/// This method wraps the remote find_all_playlists API request and returns a BCItemCollection containing the results
- (BCItemCollection *) findAllPlaylists:(int) pageSize pageNumber:(int)pageNumber sortBy:(BCSortByType)sortByType 
						sortOrder:(BCSortOrderType)sortOrderType getItemCount:(BOOL)getItemCount 
						videoFields:(NSArray *)videoFields playlistFields:(NSArray *)playlistFields 
						customFields:(NSArray *) customFields error:(NSError **) error;

/// A convenience method which invokes findPlaylistById using the specified playlist id and default arguments for optional parameters
- (BCPlaylist *) findPlaylistById:(long long)playlistId error:(NSError **) error;

/// This method wraps the remote find_playlist_by_id API request and returns a BCItemCollection containing the results
- (BCPlaylist *) findPlaylistById:(long long)playlistId videoFields:(NSArray *)videoFields 
						playlistFields:(NSArray *)playlistFields customFields:(NSArray *) customFields 
						error:(NSError **) error;

/// A convenience method which invokes findAllPlaylistsByIds using the specified NSArray of playlist ids and default arguments for optional parameters
- (BCItemCollection *) findPlaylistsByIds:(NSArray *) playlistIds error:(NSError **) error;

/// This method wraps the remote find_playlists_by_ids API request and returns a BCItemCollection containing the results
- (BCItemCollection *) findPlaylistsByIds:(NSArray *) playlistIds videoFields:(NSArray *)videoFields 
						playlistFields:(NSArray *)playlistFields customFields:(NSArray *) customFields 
						error:(NSError **) error;

/// A convenience method which invokes findPlaylistByReferenceId using the specified reference id and default arguments for optional parameters
- (BCPlaylist *) findPlaylistByReferenceId:(NSString *) referenceId error:(NSError **) error;

/// This method wraps the remote find_playlist_by_reference_id API request and returns a BCItemCollection containing the results
- (BCPlaylist *) findPlaylistByReferenceId:(NSString *) referenceId videoFields:(NSArray *)videoFields 
						playlistFields:(NSArray *)playlistFields customFields:(NSArray *) customFields 
						error:(NSError **) error;

/// A convenience method which invokes findAllPlaylistsByReferenceIds using the specified NSArray of reference ids and default arguments for optional parameters
- (BCItemCollection *) findPlaylistsByReferenceIds:(NSArray *) referenceIds error:(NSError **) error;

/// This method wraps the remote find_playlists_by_ids API request and returns a BCItemCollection containing the results
- (BCItemCollection *) findPlaylistsByReferenceIds:(NSArray *) referenceIds videoFields:(NSArray *)videoFields 
						playlistFields:(NSArray *)playlistFields customFields:(NSArray *) customFields 
						error:(NSError **) error;

/// A convenience method which invokes findPlaylistsForPlayerId using the specified player id and default arguments for optional parameters
- (BCItemCollection *) findPlaylistsForPlayerId:(long long) playerId error:(NSError **) error;

/// This method wraps the remote find_playlist_for_player_id API request and returns a BCItemCollection containing the results
- (BCItemCollection *) findPlaylistsForPlayerId:(long long) playerId pageSize:(int) pageSize pageNumber:(int)pageNumber 
						getItemCount:(BOOL)getItemCount videoFields:(NSArray *)videoFields playlistFields:(NSArray *)playlistFields 
						customFields:(NSArray *) customFields error:(NSError **) error;

@end

