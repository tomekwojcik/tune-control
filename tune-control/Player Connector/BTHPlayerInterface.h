//
//  BTHPlayerInterface.h
//  Spotify Assistant
//
//  Created by Tomek Wójcik on 9/26/12.
//  Copyright (c) 2012 BTHLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@protocol BTHPlayerInterface <NSObject>
-(NSString *)appName;
-(NSString *)appBundleIdentifier;
-(NSString *)playerStateChangedNotificationName;
-(NSString *)extractPlayerStatusFromNotification:(NSNotification *)notification;
-(BOOL)shouldListenToLaunchNotification;

-(BOOL)isRunning;
-(NSString *)playerState;
-(NSDictionary *)currentTrack;
-(NSImage *)currentTrackArtwork;

-(void)play;
-(void)pause;
-(void)nextTrack;
-(void)previousTrack;

-(NSInteger)soundVolume;
-(void)setSoundVolume:(NSInteger)newVolume;
@end
