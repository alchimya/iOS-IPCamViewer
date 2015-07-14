# iOS-IPCamViewer
An IPCam Viewer  based on UIImageView subclass.

# Do you have an IpCam?
With this small class set (two classes) you can build your custom ip cam surveillance app in a very EZWay!
<br/>
To stream the remote images, you just need to configure some parameters of your IpCam...see instruction below.

<br/> 
![ScreenShot](https://raw.github.com/alchimya/iOS-IPCamViewer/master/screenshots/screenshot_01.jpg)

# How to use?
This package consists of two classes:
- <b>L3SDKIPCam</b>: it defines the ip camera parameters
- <b>L3SDKIPCamViewer</b>: it allows to stream remote images taken from an IpCamera

<b>L3SDKIPCam</b>
<h5>properties</h5>

  name                        |     type                    |   description    
------------------------------| ----------------------------|--------------------------------------------------------
url                           | NSString                    | it allows to set the ip camera url ( eg:10.10.10.10 or www.domain.com/ipcams)
port                          | int                         | it allows to set ip camera port (default 80)
username                      | NSString                    | it allows to set authentication username
password                      | NSString                    | it allows to set authentication password
videoFolder                   | NSString                    | to configure this property you have to refer to the ip camera user manual (eg:cgi/mjpg)
videoName                     | NSString                    | to configure this property you have to refer to the ip camera user manual (eg:mjpg.cgi)
videoParams                   | NSString                    | to configure this property you have to refer to the ip camera user manual (eg:camera=&resolution=680x480)


<b>L3SDKIPCamViewer</b>
<h5>properties</h5>

  name                        |     type                    |   description    
------------------------------| ----------------------------|--------------------------------------------------------
ipCam                         | L3SDKIPCam                  | it allows to configure ip cam parameters (see L3SDKIPCam.h)
allowSelfSignedCertificates   | BOOL                        | it sets credetials behavior
allowClearTextCredentials     | BOOL                        | it sets credetials behavior
delegate                      | id                          | class delegate (see L3SDKIPCamViewerDelegate)

<h5>methods</h5>
  name                  |     type        |   description    
--------------          | ----------------|-------------------------------------------------------------------
play                    | void            | it allows to start, by a remote conenction, the ipcam streaming
stop                    | void            | close connection and stop streaming
pause                   | void            | it allows to take a picture (image cature) from the current streaming
takePicture             | UIImage         | it allows to take a picture (image cature) from the current streaming

<h5>protocols</h5>

```objectivec
@protocol L3SDKIPCamViewerDelegate <NSObject>
//it will be raised when occur a connection error
- (void)L3SDKIPCamViewer_ConnectionError:(NSError *)error;
//it will be raised if ipcma requires authentication
- (void)L3SDKIPCamViewer_AuthenticationRequired:(L3SDKIPCam*)ipCam sender:(L3SDKIPCamViewer*)sender;
@end
```

<h5>example</h5>
```objectivec
 //sets remote ipcam params
L3SDKIPCam*ipCam1=[[L3SDKIPCam alloc]init];
ipCam1.url=@"10.10.10.10";
ipCam1.port=8012;
ipCam1.videoFolder=@"axis-cgi/mjpg/";
ipCam1.videoName=@"video.cgi";
    
//start streaming
self.ipCamViewer1.delegate=self;
self.ipCamViewer1.ipCam=ipCam1;
[self.ipCamViewer1 play];

```
#Video stream example
![ScreenShot](https://raw.github.com/alchimya/iOS-IPCamViewer/master/screenshots/iOS-IPCamViewer.gif)
