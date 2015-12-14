//
//  SummerQRCodeViewController.m
//  WeCommunity
//
//  Created by madarax on 15/12/8.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerQRCodeViewController.h"

@interface SummerQRCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate ,UIAlertViewDelegate>
{
    CALayer *lineLayer;
}
@property (nonatomic ,strong)AVCaptureSession *avSession;

@end

@implementation SummerQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"二维码";
    self.view.backgroundColor =[UIColor whiteColor];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imgView.image = [UIImage imageNamed:@"shadow"];
    [self.view addSubview:imgView];
    
    UIImageView *imgBound = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qr_code_bg"]];
    imgBound.bounds = CGRectMake(0, 0, 200, 200);
    imgBound.center = self.view.center;
    [self.view addSubview:imgBound];
    
    lineLayer = [CALayer layer];
    lineLayer.frame = CGRectMake(10, 10, 180, 3);
    UIImage *lineImg = [[UIImage imageNamed:@"qr_code_line"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 0, 5, 0)];
    lineLayer.contents = (__bridge id _Nullable)(lineImg.CGImage);
    [imgBound.layer addSublayer:lineLayer];
    [self optionsWithAnimation:lineLayer];
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    output.rectOfInterest = CGRectMake(imgBound.frame.origin.y/SCREENSIZE.height, imgBound.frame.origin.x/SCREENSIZE.width, 200/SCREENSIZE.height, 200/SCREENSIZE.width); //解析范围
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];

    _avSession = [[AVCaptureSession alloc] init];
    [_avSession setSessionPreset:AVCaptureSessionPresetHigh];
    [_avSession addInput:input];
    [_avSession addOutput:output];
    
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode ,AVMetadataObjectTypeEAN13Code ,AVMetadataObjectTypeEAN8Code ,AVMetadataObjectTypeCode128Code];
    
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:_avSession];
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    layer.frame = self.view.bounds;
    [imgView.layer addSublayer:layer];
    
    [_avSession startRunning];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
        NSLog(@"--------->%@",metadataObject.stringValue);
        [[[UIAlertView alloc] initWithTitle:nil message:metadataObject.stringValue delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
        [lineLayer removeAnimationForKey:@"rotation"];
        [_avSession stopRunning];
        
    }
}

- (void)optionsWithAnimation:(CALayer *)animaitonLayer{
    CABasicAnimation *frameAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    frameAnimation.duration = 2;
    frameAnimation.repeatCount = 900;
    frameAnimation.fromValue = [NSNumber numberWithInteger:0];
    frameAnimation.toValue = [NSNumber numberWithInteger:185];
    [animaitonLayer addAnimation:frameAnimation forKey:@"rotation"];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self optionsWithAnimation:lineLayer];
    [_avSession startRunning];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
