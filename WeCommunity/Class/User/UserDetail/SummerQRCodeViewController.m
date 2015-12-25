//
//  SummerQRCodeViewController.m
//  WeCommunity
//
//  Created by madarax on 15/12/8.
//  Copyright © 2015年 Harry. All rights reserved.
//
#import "UIViewController+HUD.h"
#import "SummerQRCodeViewController.h"
#import "SummerJinSubmiteViewController.h"

@interface SummerQRCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate ,UIAlertViewDelegate>
{
    UIImageView *lineLayer;
    UIImageView *imgBound;
    AVCaptureVideoPreviewLayer *videoLayer;
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
    lineLayer.backgroundColor = THEMECOLOR;
//    UIImage *lineImg = [UIImage imageNamed:@"qr_code_line"];
//    lineLayer.image = [lineImg resizableImageWithCapInsets:UIEdgeInsetsMake(.5, 1, .5, 1)];
    [imgBound addSubview:lineLayer];
    
    [self reading];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
        [lineLayer.layer removeAnimationForKey:@"rotation"];
        [_avSession stopRunning];
        
        NSData *qrCode = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?flag=xqhz_admin",metadataObject.stringValue]] options:NSDataReadingMapped error:nil];
        __weak typeof(self)weakSelf = self;
        NSDictionary *strUrlData = [NSJSONSerialization JSONObjectWithData:qrCode options:NSJSONReadingAllowFragments error:nil];
        if (strUrlData == nil) {
            [[[UIAlertView alloc] initWithTitle:@"提示" message:@"二维码校验失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
            return;
        }
        if ([strUrlData[@"state"] boolValue]) {
            NSString *qrID = strUrlData[@"msg"][@"id"];
            [Networking retrieveData:JIN_CARD_BIND parameters:@{@"token":[User getUserToken],@"cardId":qrID}];
            User *userModel = [User shareUserDefult];
            if (userModel.userJinDic.jinCardID == nil || [userModel.userJinDic.jinCardID isEqual:[NSNull null]]) {
                userModel.userJinDic.jinCardID = qrID;
                [weakSelf showHint:@"绑定成功"];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                [[[UIAlertView alloc] initWithTitle:@"提示" message:@"是否确定解除绑定" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
            }
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        //解除绑定
        [Networking retrieveData:JIN_CARD_BIND_CANCEL parameters:@{@"token":[User getUserToken]}];
        [self showHint:@"已经解除绑定"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    [_avSession startRunning];
    [self optionsWithAnimation:lineLayer.layer];
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
    
    videoLayer = [AVCaptureVideoPreviewLayer layerWithSession:_avSession];
    videoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    videoLayer.frame = self.view.frame;
    [self.preView.layer addSublayer:videoLayer];
    
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
    videoLayer.mask = maskLayer;
    videoLayer.masksToBounds = YES;
    
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
