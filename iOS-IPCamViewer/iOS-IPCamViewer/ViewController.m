//
//  ViewController.m
//  iOS-IPCamViewer
//
//  Created by Domenico Vacchiano on 04/07/15.
//  Copyright (c) 2015 DomenicoVacchiano. All rights reserved.
//

#import "ViewController.h"
#import "L3SDKIPCam.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet L3SDKIPCamViewer *ipCamViewer1;
@property (weak, nonatomic) IBOutlet L3SDKIPCamViewer *ipCamViewer2;
@property (weak, nonatomic) IBOutlet L3SDKIPCamViewer *ipCamViewer3;
@property (weak, nonatomic) IBOutlet L3SDKIPCamViewer *ipCamViewer4;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    ////////////////////////////////////////////////////////////////////////
    //IPCAM 1
    //sets remote ipcam params
    L3SDKIPCam*ipCam1=[[L3SDKIPCam alloc]init];
    ipCam1.url=@"85.46.64.147";
    ipCam1.port=80;
    ipCam1.videoFolder=@"axis-cgi/mjpg/";
    ipCam1.videoName=@"video.cgi";
    
    //start streaming
    self.ipCamViewer1.delegate=self;
    self.ipCamViewer1.ipCam=ipCam1;
    [self.ipCamViewer1 play];

    ////////////////////////////////////////////////////////////////////////
    //IPCAM 2
    //sets remote ipcam params
    L3SDKIPCam*ipCam2=[[L3SDKIPCam alloc]init];
    ipCam2.url=@"iris.not.iac.es";
    ipCam2.port=80;
    ipCam2.videoFolder=@"axis-cgi/mjpg/";
    ipCam2.videoName=@"video.cgi";
    
    //start streaming
    self.ipCamViewer2.delegate=self;
    self.ipCamViewer2.ipCam=ipCam2;
    [self.ipCamViewer2 play];
    
    ////////////////////////////////////////////////////////////////////////
    //IPCAM 3
    //sets remote ipcam params
    L3SDKIPCam*ipCam3=[[L3SDKIPCam alloc]init];
    ipCam3.url=@"195.235.198.107";
    ipCam3.port=3346;
    ipCam3.videoFolder=@"axis-cgi/mjpg/";
    ipCam3.videoName=@"video.cgi";
    
    //start streaming
    self.ipCamViewer3.delegate=self;
    self.ipCamViewer3.ipCam=ipCam3;
    [self.ipCamViewer3 play];
    
    ////////////////////////////////////////////////////////////////////////
    //IPCAM 3
    //sets remote ipcam params
    L3SDKIPCam*ipCam4=[[L3SDKIPCam alloc]init];
    ipCam4.url=@"217.197.157.7";
    ipCam4.port=7070;
    ipCam4.videoFolder=@"axis-cgi/mjpg/";
    ipCam4.videoName=@"video.cgi";
    
    //start streaming
    self.ipCamViewer4.delegate=self;
    self.ipCamViewer4.ipCam=ipCam4;
    [self.ipCamViewer4 play];
    ////////////////////////////////////////////////////////////////////////
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - L3SDKIPCamViewerDelegate Delegate Methods
- (void)L3SDKIPCamViewer_ConnectionError:(NSError *)error{
    UIAlertView*alert=[[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)L3SDKIPCamViewer_AuthenticationRequired:(L3SDKIPCam*)ipCam sender:(L3SDKIPCamViewer*)sender {
    //do something, for instance you can set ipCam.username and ipCam.password and call again play on sender instance
}


@end
