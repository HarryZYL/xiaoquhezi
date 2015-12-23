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
    UIImageView *lineLayer;
    UIImageView *imgBound;
}
@property (nonatomic ,strong)AVCaptureSession *avSession;
@property (nonatomic,strong)UIView *preView;//显示预览视图
@end

@implementation SummerQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"二维码";
    self.view.backgroundColor =[UIColor whiteColor];
    if (!self.preView) {
        self.preView  = [[UIView alloc] initWithFrame:self.view.frame];
        self.preView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:self.preView];
    }
    
    imgBound = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"qr_code_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(25, 25, 25, 25)]];
    imgBound.bounds = CGRectMake(0, 0, 200, 200);
    imgBound.center = self.view.center;
    [self.view addSubview:imgBound];
    
    
    lineLayer = [UIImageView new];
    lineLayer.frame = CGRectMake(0, 0, 200, 3);
    
    UIImage *lineImg = [UIImage imageNamed:@"qr_code_line"];
    lineLayer.image = [lineImg resizableImageWithCapInsets:UIEdgeInsetsMake(10, 2, 10, 2)];
    [imgBound addSubview:lineLayer];
    
    [self reading];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
        NSLog(@"--------->%@",metadataObject.stringValue);
        [[[UIAlertView alloc] initWithTitle:nil message:metadataObject.stringValue delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
        [lineLayer.layer removeAnimationForKey:@"rotation"];
        [_avSession stopRunning];
        
    }
}

- (void)reading{
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
    layer.frame = self.view.frame;
    [self.preView.layer addSublayer:layer];
    
    //在layer上添加一个masker层
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //添加外层的半透明效果
    
    CGContextSetRGBFillColor(context, 0, 0, 0, .5f);
    CGContextAddRect(context, self.view.bounds);
    CGContextFillPath(context);
    
    //绘制内层的全不透明效果
    CGContextSetRGBFillColor(context, 1, 1, 1, 1.f);
    CGContextAddRect(context, imgBound.frame);
    CGContextFillPath(context);
    UIImage *maskImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CALayer *maskLayer = [[CALayer alloc] init];
    maskLayer.bounds = self.view.bounds;
    maskLayer.position = self.view.center;
    maskLayer.contents = (__bridge id)maskImage.CGImage;
    layer.mask = maskLayer;
    layer.masksToBounds = YES;
    
    [self optionsWithAnimation:lineLayer.layer];
    
    [_avSession startRunning];
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
    [self optionsWithAnimation:lineLayer.layer];
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
