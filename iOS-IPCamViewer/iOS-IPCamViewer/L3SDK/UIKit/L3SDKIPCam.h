//
//  L3SDKIPCam.h
//  iOS-IPCamViewer
//
//  Created by Domenico Vacchiano on 04/07/15.
//  Copyright (c) 2015 DomenicoVacchiano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface L3SDKIPCam : NSObject

//ip camera url - eg:192.168.1.11
@property (nonatomic,strong)NSString*url;
//ip camera port - eg:8011
@property (nonatomic,assign)long port;
//ip camera username
@property (nonatomic,strong)NSString*username;
//ip camera password
@property (nonatomic,strong)NSString*password;
///////////////////////////////////////////////////////////////////////////////
//to configure the following properties you have to refer do ipcam user manual
//eg:cgi/mjpg
@property (nonatomic,strong)NSString*videoFolder;
//eg:mjpg.cgi
@property (nonatomic,strong)NSString*videoName;
//eg:camera=&resolution=680x480
@property (nonatomic,strong)NSString*videoParams;
///////////////////////////////////////////////////////////////////////////////

@end
