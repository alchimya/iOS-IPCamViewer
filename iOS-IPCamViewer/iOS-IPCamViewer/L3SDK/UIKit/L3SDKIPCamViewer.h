//
//  L3SDKIPCamViewer.h
//  iOS-IPCamViewer
//
//  Created by Domenico Vacchiano on 04/07/15.
//  Copyright (c) 2015 DomenicoVacchiano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class L3SDKIPCam;
@class L3SDKIPCamViewer;
//delegate protocols used to raise some events
@protocol L3SDKIPCamViewerDelegate <NSObject>
//it will be raised when occur a connection error
- (void)L3SDKIPCamViewer_ConnectionError:(NSError *)error;
//it will be raised if ipcma requires authentication
- (void)L3SDKIPCamViewer_AuthenticationRequired:(L3SDKIPCam*)ipCam sender:(L3SDKIPCamViewer*)sender;
@end


@interface L3SDKIPCamViewer :UIImageView
//it allows to configure ip cam parameters (see L3SDKIPCam.h)
@property (nonatomic,strong)L3SDKIPCam*ipCam;
//sets credetials behavior
@property (nonatomic,assign)BOOL allowSelfSignedCertificates;
@property (nonatomic,assign)BOOL allowClearTextCredentials;
//class delegate
@property (nonatomic,assign) id<L3SDKIPCamViewerDelegate> delegate;
//it allows to start, by a remote conenction, the ipcam streaming
-(void)play;
//close connection and stop streaming
-(void)stop;
//streaming pause
-(void)pause;
//it allows to take a picture (image cature) from the current streaming
-(UIImage*)takePicture;
@end
