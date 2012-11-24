//
//  BTHSpotifyInterface.h
//  Spotify Assistant
//
//  Created by Tomek Wójcik on 9/26/12.
//  Copyright (c) 2012 BTHLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BTHPlayerInterface.h"
#import "Spotify.h"

#define BTHSpotifyLinkBaseURL @"http://open.spotify.com/track/"

@interface BTHSpotifyInterface : NSObject <BTHPlayerInterface> {
    SpotifyApplication *spotify;
}
@end
