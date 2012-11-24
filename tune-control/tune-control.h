//
//  tune-control.h
//  tune-control
//
//  Created by Tomek Wójcik on 11/24/12.
//  Copyright (c) 2012 BTHLabs. All rights reserved.
//

#ifndef tune_control_tune_control_h
#define tune_control_tune_control_h

#define BTHAppVersion @"1.0"
#define BTHDefaultPlayer @"iTunes"
#define BTHDefaultsDomain @"pl.bthlabs.tune-control"
#define BTHHomeURL @"http://tomekwojcik.github.com/tune-control/"

void pstdout(NSString *whatever);
void pstderr(NSString *whatever);
void print_usage();

#endif
