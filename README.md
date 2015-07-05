# iOS-IPCamViewer
An IPCam Viewer  based on UIImageView subclass.

# Do you have an IpCam?
With this small class set (two calsses) you can develop your custom ip cam surveillance app in a very EZWay!
<br/>
To stream the remote images, you just need to configure some parameters of your IpCam...see instruction below.

# How to use?
This package consists of two classes:
- L3SDKIPCam: it defines the ip camera parameters
- L3SDKIPCamViewer: it allows to stream remote images taken from an IpCamera

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
