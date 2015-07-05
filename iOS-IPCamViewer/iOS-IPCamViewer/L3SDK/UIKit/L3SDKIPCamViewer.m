//
//  L3SDKIPCamViewer.m
//  iOS-IPCamViewer
//
//  Created by Domenico Vacchiano on 04/07/15.
//  Copyright (c) 2015 DomenicoVacchiano. All rights reserved.
//

#import "L3SDKIPCamViewer.h"
#import "L3SDKIPCam.h"
#define END_MARKER_BYTES { 0xFF, 0xD9 }

@interface L3SDKIPCamViewer()
@property (nonatomic,strong) NSURLConnection*connection;
@property (nonatomic,strong) NSMutableData *receivedData;
-(NSURL*)getURL;
-(void)initDefaults;
@end


@implementation L3SDKIPCamViewer
static NSData *_endMarkerData = nil;

@synthesize ipCam;
@synthesize allowSelfSignedCertificates;
@synthesize allowClearTextCredentials;
@synthesize delegate;
#pragma mark - Override Methods
-(id) initWithCoder:(NSCoder *)aDecoder {

    if ([super initWithCoder:aDecoder]) {
        [self initDefaults];
    }
    return self;
}
-(id) initWithFrame:(CGRect)frame{
    
    if ([self initWithFrame:frame]) {
        [self initDefaults];
    }
    return self;
}
#pragma mark - Public Methods
-(void)play{
    //TODO THROW EXCEPTION IF ipCam IS NULL
    if (self.ipCam==nil) {
        @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                       reason:[NSString stringWithFormat:@"%@ You must set ipCam property. ",
                                               NSStringFromClass([self class])]
                                     userInfo:nil];
        return;
    }
    self.connection = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[self getURL]] delegate:self];
}
-(void)stop{
    [self.connection cancel];
    self.image=nil;
}
-(void)pause{
    [self.connection cancel];
}
-(UIImage*)takePicture {
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenShot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenShot;
}

#pragma mark - Private Methods

-(NSURL*)getURL{
    
    NSString*urlString=[NSString stringWithFormat:@"http://%@:%ld/%@/%@?%@",
                        self.ipCam.url,
                        self.ipCam.port,
                        self.ipCam.videoFolder,
                        self.ipCam.videoName,
                        self.ipCam.videoParams];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    return url;
    
}
-(void)initDefaults{
    if (_endMarkerData == nil) {
        uint8_t endMarker[2] = END_MARKER_BYTES;
        _endMarkerData = [[NSData alloc] initWithBytes:endMarker length:2];
    }
    self.allowClearTextCredentials=YES;
    self.allowSelfSignedCertificates=YES;
    
}



#pragma mark - NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    self.receivedData = [[NSMutableData alloc] init];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    
    
    [self.receivedData appendData:data];
    
    NSRange endRange = [_receivedData rangeOfData:_endMarkerData
                                          options:0
                                            range:NSMakeRange(0, _receivedData.length)];
    
    long long endLocation = endRange.location + endRange.length;
    if (_receivedData.length >= endLocation) {
        NSData *imageData = [_receivedData subdataWithRange:NSMakeRange(0, endLocation)];
        UIImage *receivedImage = [UIImage imageWithData:imageData];
        if (receivedImage) {
            self.image = receivedImage;
        }
    }
    
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    //nothing ;-)
}

-(BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    
    BOOL allow = NO;
    if ([protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        allow = self.allowSelfSignedCertificates;
    }
    else {
        allow = self.allowClearTextCredentials;
    }
    
    return allow;
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    
    if ([challenge previousFailureCount] == 0 &&
        self.ipCam.username && self.ipCam.username.length > 0 &&
        self.ipCam.password && self.ipCam.password.length > 0) {
        
        NSURLCredential *credentials =[NSURLCredential credentialWithUser:self.ipCam.username
                                   password:self.ipCam.password
                                persistence:NSURLCredentialPersistenceForSession];
        [[challenge sender] useCredential:credentials
               forAuthenticationChallenge:challenge];
    }
    else {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
        //send event
        if (self.delegate != NULL && [delegate respondsToSelector:@selector(L3SDKIPCamViewer_AuthenticationRequired:sender:)]) {
            [self.delegate L3SDKIPCamViewer_AuthenticationRequired:self.ipCam sender:self];
        }
        
    }
}
- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection {
    return YES;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    //send event
    if (self.delegate != NULL && [delegate respondsToSelector:@selector(L3SDKIPCamViewer_ConnectionError:)]) {
        [self.delegate L3SDKIPCamViewer_ConnectionError:error];
    }
    
}



@end
