//
//  BTHiTunesInterface.h
//  Spotify Assistant
//
//  Created by Tomek Wójcik on 9/26/12.
//  Copyright (c) 2012 BTHLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BTHPlayerInterface.h"
#import "iTunes.h"

@interface BTHiTunesInterface : NSObject <BTHPlayerInterface> {
    iTunesApplication *iTunes;
}

@end
