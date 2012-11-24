//
//  BTHiTunesInterface.m
//  Spotify Assistant
//
//  Created by Tomek Wójcik on 9/26/12.
//  Copyright (c) 2012 BTHLabs. All rights reserved.
//

#import "BTHiTunesInterface.h"

@implementation BTHiTunesInterface
-(id)init {
    if (self = [super init]) {
        iTunes = [[SBApplication alloc] initWithBundleIdentifier:[self appBundleIdentifier]];
    }
    
    return self;
}

-(void)dealloc {
    [iTunes release]; iTunes = nil;
    [super dealloc];
}

# pragma mark - BTHPlayerInterface protocol implementation
-(NSString *)appName {
    return @"iTunes";
}

-(NSString *)appBundleIdentifier {
    return @"com.apple.iTunes";
}

-(NSString *)playerStateChangedNotificationName {
    return @"com.apple.iTunes.playerInfo";
}

-(NSString *)extractPlayerStatusFromNotification:(NSNotification *)notification {
    return [[notification userInfo] objectForKey:@"Player State"];
}

-(BOOL)shouldListenToLaunchNotification {
    return YES;
}

-(BOOL)isRunning {
    return [iTunes isRunning];
}

-(NSString *)playerState {
    if ([iTunes isRunning] == YES) {
        if ([iTunes playerState] == iTunesEPlSStopped) {
            return @"Stopped";
        } else if ([iTunes playerState] == iTunesEPlSPaused) {
            return @"Paused";
        } else if ([iTunes playerState] == iTunesEPlSPlaying) {
            return @"Playing";
        }
    } else {
        return @"Not running";
    }
    
    return @"Unknown";
}

-(NSDictionary *)currentTrack {
    if (([iTunes isRunning]) && ([iTunes playerState] != iTunesEPlSStopped)) {
        iTunesTrack *currentTrack = [iTunes currentTrack];
        NSMutableDictionary *currentTrack_ = [NSMutableDictionary dictionaryWithCapacity:1];
        [currentTrack_ setObject:[currentTrack name] forKey:@"title"];
        [currentTrack_ setObject:[currentTrack artist] forKey:@"artist"];
        [currentTrack_ setObject:[currentTrack album] forKey:@"album"];
                
        return [NSDictionary dictionaryWithDictionary:currentTrack_];
	}
    
    return nil;
}

-(NSImage *)currentTrackArtwork {
    NSImage *image = nil;
    if (([iTunes isRunning]) && ([iTunes playerState] != iTunesEPlSStopped)) {
        iTunesTrack *track = [iTunes currentTrack];
		if ([[track artworks] count] > 0) {
			iTunesArtwork *artwork = [[track artworks] objectAtIndex:0];
			image = [artwork data];
		}
    }
    
    return image;
}

-(void)play {
    [iTunes playpause];
}

-(void)pause {
    [self play];
}

-(void)nextTrack {
    [iTunes nextTrack];
}

-(void)previousTrack {
    NSInteger playerPosition = [iTunes playerPosition];
	
	if (playerPosition <= 5) {
		[iTunes previousTrack];
	} else {
		[iTunes setPlayerPosition:0];
	}
}

-(NSInteger)soundVolume {
    return [iTunes soundVolume];
}

-(void)setSoundVolume:(NSInteger)newVolume {
    [iTunes setSoundVolume:newVolume];
}
@end
