//
//  BTHSpotifyInterface.m
//  Spotify Assistant
//
//  Created by Tomek Wójcik on 9/26/12.
//  Copyright (c) 2012 BTHLabs. All rights reserved.
//

#import "BTHSpotifyInterface.h"

@implementation BTHSpotifyInterface
-(id)init {
    if (self = [super init]) {
        spotify = [[SBApplication alloc] initWithBundleIdentifier:[self appBundleIdentifier]];
    }
    
    return self;
}

-(void)dealloc {
    [spotify release]; spotify = nil;
    [super dealloc];
}

# pragma mark - BTHPlayerInterface protocol implementation
-(NSString *)appName {
    return @"Spotify";
}

-(NSString *)appBundleIdentifier {
    return @"com.spotify.client";
}

-(NSString *)playerStateChangedNotificationName {
    return @"com.spotify.client.PlaybackStateChanged";
}

-(NSString *)extractPlayerStatusFromNotification:(NSNotification *)notification {
    return [[notification userInfo] objectForKey:@"Player State"];
}

-(BOOL)shouldListenToLaunchNotification {
    return YES;
}

-(BOOL)isRunning {
    return [spotify isRunning];
}

-(NSString *)playerState {
    if ([spotify isRunning] == YES) {
        if ([spotify playerState] == SpotifyEPlSStopped) {
            return @"Stopped";
        } else if ([spotify playerState] == SpotifyEPlSPaused) {
            return @"Paused";
        } else if ([spotify playerState] == SpotifyEPlSPlaying) {
            return @"Playing";
        }        
    } else {
        return @"Not running";
    }
    
    return @"Unknown";
}

-(NSDictionary *)currentTrack {
    if ([spotify isRunning] == YES) {
        if ([spotify playerState] != SpotifyEPlSStopped) {
            SpotifyTrack *currentTrack = [spotify currentTrack];
            NSMutableDictionary *currentTrack_ = [NSMutableDictionary dictionaryWithCapacity:1];
            [currentTrack_ setObject:[currentTrack name] forKey:@"title"];
            [currentTrack_ setObject:[currentTrack artist] forKey:@"artist"];
            [currentTrack_ setObject:[currentTrack album] forKey:@"album"];
            
            NSRange isLocalRange = [[currentTrack spotifyUrl] rangeOfString:@"spotify:track:"];
            if (isLocalRange.location != NSNotFound) {
                NSString *link = [NSString stringWithFormat:@"%@%@", BTHSpotifyLinkBaseURL, [[[spotify currentTrack] spotifyUrl] stringByReplacingOccurrencesOfString:@"spotify:track:" withString:@""]];
                [currentTrack_ setObject:link forKey:@"link"];
            }
            
            return [NSDictionary dictionaryWithDictionary:currentTrack_];
        }
    }
    
    return nil;
}

-(NSImage *)currentTrackArtwork {
    if ([spotify isRunning] == YES) {
        return [[spotify currentTrack] artwork];
    }
    
    return nil;
}

-(void)play {
    if ([spotify isRunning] == YES) {
        [spotify play];
    }
}

-(void)pause {
    if ([spotify isRunning] == YES) {
        [spotify pause];
    }
}

-(void)nextTrack {
    if ([spotify isRunning] == YES) {
        [spotify nextTrack];
    }
}

-(void)previousTrack {
    if ([spotify isRunning] == YES) {
        [spotify previousTrack];
    }
}

-(NSInteger)soundVolume {
    if ([spotify isRunning] == YES) {
        return [spotify soundVolume];
    }
    
    return 0;
}

-(void)setSoundVolume:(NSInteger)newVolume {
    if ([spotify isRunning] == YES) {
        [spotify setSoundVolume:newVolume];
    }
}
@end
