//
//  main.m
//  tune-control
//
//  Created by Tomek Wójcik on 11/24/12.
//  Copyright (c) 2012 BTHLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import "BTHPlayerInterface.h"
#import "BTHiTunesInterface.h"
#import "BTHSpotifyInterface.h"

#import "tune-control.h"

void pstdout(NSString *whatever) {
    [[NSFileHandle fileHandleWithStandardOutput] writeData:[[whatever stringByAppendingString:@"\n"] dataUsingEncoding:NSUTF8StringEncoding]];
};

void pstderr(NSString *whatever) {
    [[NSFileHandle fileHandleWithStandardError] writeData:[[whatever stringByAppendingString:@"\n"] dataUsingEncoding:NSUTF8StringEncoding]];
};

void print_usage() {
    pstderr(@"Usage: tune-control command");
    pstderr(@"");
    
    pstderr(@"Playback control:");
    pstderr(@"  play");
    pstderr(@"  pause");
    pstderr(@"  next");
    pstderr(@"  prev");
    pstderr(@"");
    
    pstderr(@"Player info:");
    pstderr(@"  track");
    pstderr(@"  state");
    pstderr(@"  player");
    pstderr(@"");
    
    pstderr(@"Other:");
    pstderr(@"  home");
    pstderr(@"  version");
    pstderr(@"  help");
}

int main (int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray *args = [[NSProcessInfo processInfo] arguments];
        
        if ([args count] > 1) {
            NSUserDefaults *defaults = [[[NSUserDefaults alloc] init] autorelease];
            NSDictionary *prefs = [defaults persistentDomainForName:BTHDefaultsDomain];
            NSString *playerName = [prefs objectForKey:@"PlayerName"];
            if (!playerName) {
                playerName = BTHDefaultPlayer;
            }
            
            NSObject<BTHPlayerInterface> *player = nil;
            if ([playerName isEqualToString:@"iTunes"] == YES) {
                player = [[[BTHiTunesInterface alloc] init] autorelease];
            } else if ([playerName isEqualToString:@"Spotify"] == YES) {
                player = [[[BTHSpotifyInterface alloc] init] autorelease];
            } else {
                pstderr([NSString stringWithFormat:@"Unknown player: %@", playerName]);
                return 1;
            }
            
            NSString *command = [args objectAtIndex:1];
            if ([command isEqualToString:@"play"] == YES) {
                if (([[player playerState] isEqualToString:@"Paused"] == YES) || ([[player playerState] isEqualToString:@"Stopped"])) {
                    [player play];
                }
            } else if ([command isEqualToString:@"pause"] == YES) {
                if ([[player playerState] isEqualToString:@"Playing"] == YES) {
                    [player pause];
                }
            } else if ([command isEqualToString:@"next"] == YES) {
                [player nextTrack];
            } else if ([command isEqualToString:@"prev"] == YES) {
                [player previousTrack];
            } else if ([command isEqualToString:@"track"] == YES) {
                NSDictionary *track = [player currentTrack];
                if (track) {
                    pstdout([NSString stringWithFormat:@"'%@' by %@ from '%@'",
                             [track objectForKey:@"title"], [track objectForKey:@"artist"],
                             [track objectForKey:@"album"]]);
                }
            } else if ([command isEqualToString:@"player"] == YES) {
                pstderr(playerName);
            } else if ([command isEqualToString:@"state"] == YES) {
                pstderr([NSString stringWithFormat:@"%@ State: %@", playerName, [player playerState]]);
            } else if ([command isEqualToString:@"home"] == YES) {
                [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:BTHHomeURL]];
            } else if ([command isEqualToString:@"version"] == YES) {
                pstderr(BTHAppVersion);
            } else if ([command isEqualToString:@"help"] == YES) {
                print_usage();
            } else {
                pstderr([NSString stringWithFormat:@"Unknown command: %@", command]);
                return 1;
            }
        } else {
            print_usage();
            return 64;
        }
    }

    return 0;
}

