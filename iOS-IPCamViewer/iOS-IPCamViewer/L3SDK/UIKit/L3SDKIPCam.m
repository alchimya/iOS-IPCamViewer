//
//  L3SDKIPCam.m
//  iOS-IPCamViewer
//
//  Created by Domenico Vacchiano on 04/07/15.
//  Copyright (c) 2015 DomenicoVacchiano. All rights reserved.
//

#import "L3SDKIPCam.h"

@implementation L3SDKIPCam
@synthesize url;
@synthesize port;
@synthesize username;
@synthesize password;
@synthesize videoFolder;
@synthesize videoName;
@synthesize videoParams;

-(id) init {

    if ([super init]) {
        //sets default values
        self.port=80;
    }
    return self;
}
@end
