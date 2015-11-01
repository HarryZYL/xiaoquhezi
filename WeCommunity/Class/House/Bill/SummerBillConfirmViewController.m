//
//  SummerBillConfirmViewController.m
//  WeCommunity
//
//  Created by madarax on 15/10/30.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerBillConfirmViewController.h"
#import "UIViewController+HUD.h"
#import "SummerSelectPayWayView.h"
#import "SummerBillOrderList.h"
#import "SummerAuthV2Info.h"
#import "SummerRegisterID.h"
#import <AlipaySDK/AlipaySDK.h>
#import <WXApiObject.h>
#import <WXApi.h>
#import "payRequsestHandler.h"
#import "DataSigner.h"
#import "JSONKit.h"

@interface SummerBillConfirmViewController ()
{
    CGFloat moneyTotal;
}
@property (nonatomic ,copy)NSString *orderListID;/**<返回的订单ID*/

@end

@implementation SummerBillConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initWithOrderListData];
    [self initSelfOrderListView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wxPayReturnInfo:) name:@"WXPayWay" object:nil];
}

- (void)initWithOrderListData{
    NSDictionary *parama = @{@"token": [User getUserToken],@"ids":_billOrderIDArrary};
    [Networking retrieveData:get_Order_LIST parameters:parama success:^(id responseObject) {
        NSLog(@"-->%@",responseObject);
        _orderListID = responseObject;
    }];
}

- (void)initSelfOrderListView{
    UIScrollView *billOrderView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    billOrderView.contentSize = CGSizeMake(SCREENSIZE.width, 700);
    billOrderView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    [self.view addSubview:billOrderView];
    
    CGFloat feeLabHeight = _billOrderIDArrary.count * 15.0;
    
    UIView *topBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 6, SCREENSIZE.width, 88 + 22 + feeLabHeight)];
    topBgView.backgroundColor = [UIColor whiteColor];
    [billOrderView addSubview:topBgView];
    NSMutableArray *roomNO = _commnityDic[@"parentNames"];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREENSIZE.width - 20, 42)];
    nameLabel.text = [NSString stringWithFormat:@"%@%@室",_commnityDic[@"communityName"],[roomNO componentsJoinedByString:@""]];
    nameLabel.font = [UIFont systemFontOfSize:17];
    [topBgView addSubview:nameLabel];
    
    UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(5, 43, SCREENSIZE.width - 10, 1)];
    lineLab.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    [topBgView addSubview:lineLab];
    
    for (NSInteger iRow = 0; iRow <_billOrderIDArrary.count; iRow ++) {
        UILabel *feeLab = [[UILabel alloc] init];
        feeLab.frame = CGRectMake(10, 55 * (iRow + 1), SCREENSIZE.width - 20, 10);
        
        NSDictionary *temDic = _commnityArrary[iRow];
        feeLab.text = [NSString stringWithFormat:@"%@年%@月物业费",temDic[@"year"],temDic[@"month"]];
        feeLab.font = [UIFont systemFontOfSize:13];
        feeLab.textColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
        [topBgView addSubview:feeLab];
        moneyTotal += [temDic[@"fee"] floatValue];
    }
    UILabel *feeMoneyLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 44 + 22 + _billOrderIDArrary.count * 10, SCREENSIZE.width - 20, 44)];
    NSMutableAttributedString *tempStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"支付金额：%.2f",moneyTotal]];
    [tempStr addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:61/255.0 green:204/255.0 blue:180/255.0 alpha:1],NSFontAttributeName:[UIFont systemFontOfSize:20]} range:NSMakeRange(4, tempStr.length - 4)];
    feeMoneyLab.attributedText = tempStr;
    [topBgView addSubview:feeMoneyLab];
    
    UILabel *labPayWay = [[UILabel alloc] initWithFrame:CGRectMake(10, topBgView.frame.origin.y + topBgView.frame.size.height, SCREENSIZE.width - 20, 36)];
    labPayWay.text = @"请选择支付方式";
    [billOrderView addSubview:labPayWay];
    
    CGFloat heightView = labPayWay.frame.origin.y + 36;
    SummerSelectPayWayView *bootomView = [[SummerSelectPayWayView alloc] initWithFrame:CGRectMake(0, heightView, SCREENSIZE.width, 91)];
    bootomView.backgroundColor = [UIColor whiteColor];
    bootomView.tag = 100;
    [billOrderView addSubview:bootomView];
    
    CGFloat sureBtnOrigin = heightView + 91 + 20;
    UIButton *btnSureOrderListUpload = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSureOrderListUpload.frame = CGRectMake(10, sureBtnOrigin, SCREENSIZE.width - 20, 45);
    [btnSureOrderListUpload setTitle:@"确认支付" forState:UIControlStateNormal];
    [btnSureOrderListUpload setBackgroundColor:[UIColor colorWithRed:61/255.0 green:204/255.0 blue:180/255.0 alpha:1]];
    [btnSureOrderListUpload addTarget:self action:@selector(orderListSureUpload) forControlEvents:UIControlEventTouchUpInside];
    [billOrderView addSubview:btnSureOrderListUpload];
    
}

- (void)orderListSureUpload{
    SummerSelectPayWayView *payView = (SummerSelectPayWayView *)[self.view viewWithTag:100];
    if (payView.currentSelect == 0) {
        [self showHint:@"请选择支付方式"];
        return;
    }else{
        switch (payView.currentSelect) {
            case 1:
            {//微信
                [self sendPay_demo];
            }
                break;
            case 2:
            {//支付宝
                [self generateData];
            }
                break;
                
            default:
                break;
        }
    }
}

#pragma mark -
#pragma mark   ==============支付宝产生订单信息==============

- (void)generateData{
    SummerBillOrderList *order = [[SummerBillOrderList alloc] init];
    order.partner   = kAlipay_Partner;
    order.seller    = kAlipay_Seller;
    order.tradeNO   = _orderListID;
    order.notifyURL = kAlipay_ReUrl;
    order.service = @"mobile.securitypay.pay";
    order.productName = @"物业费";
    
    NSMutableArray *arraryTemp = [[NSMutableArray alloc] init];
    for (NSInteger iRow = 0; iRow <_billOrderIDArrary.count; iRow ++) {
        NSDictionary *temDic = _commnityArrary[iRow];
        NSString *tempStr = [NSString stringWithFormat:@"%@年%@月物业费",temDic[@"year"],temDic[@"month"]];
        [arraryTemp addObject:tempStr];
    }
    order.productDescription = [arraryTemp componentsJoinedByString:@","];
    order.amount             = [NSString stringWithFormat:@"%.2f",moneyTotal];
    order.paymentType        = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30.m";
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"m.alipay.com";
    NSString *orderSpec = [order description];
    id<DataSigner>signer = CreateRSADataSigner(kAlipay_Private_Key);
    NSString *signedString = [signer signString:orderSpec];
    
    NSString *orderString;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }
}

#pragma mark -
#pragma mark   ==============微信产生订单信息==============

//微信签名
- (void)sendPay_demo
{
    //{{{
    //本实例只是演示签名过程， 请将该过程在商户服务器上实现
    
    //创建支付签名对象
    payRequsestHandler *req = [payRequsestHandler alloc];
    //初始化支付签名对象
    [req init:APP_ID mch_id:MCH_ID];
    //设置密钥
    [req setKey:PARTNER_ID];
    
    //}}}
    
    //获取到实际调起微信支付的参数后，在app端调起支付
    NSMutableDictionary *dict = [req sendPay_demo:@"物业费信息" withTotalPrice:[NSString stringWithFormat:@"%.0f",moneyTotal*100] withOrderNo:_orderListID];
    
    if(dict == nil){
        //错误提示
        NSString *debug = [req getDebugifo];
        
        [self alert:@"提示信息" msg:debug];
        
        NSLog(@"%@\n\n",debug);
    }else{
        NSLog(@"%@\n\n",[req getDebugifo]);
        //[self alert:@"确认" msg:@"下单成功，点击OK后调起支付！"];
        
        NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
        
        //调起微信支付
        PayReq* req             = [[PayReq alloc] init];
        req.openID              = [dict objectForKey:@"appid"];
        req.partnerId           = [dict objectForKey:@"partnerid"];
        req.prepayId            = [dict objectForKey:@"prepayid"];
        req.nonceStr            = [dict objectForKey:@"noncestr"];
        req.timeStamp           = stamp.intValue;
        req.package             = [dict objectForKey:@"package"];
        req.sign                = [dict objectForKey:@"sign"];
        
        [WXApi sendReq:req];
    }
}

- (void)sendWXAppPayWay{
    
    //从服务器获取支付参数，服务端自定义处理逻辑和格式
    //订单标题
    NSString *ORDER_NAME    = @"物业费信息";
    //订单金额，单位（元）
    NSString *ORDER_PRICE   = [NSString stringWithFormat:@"%.2f",moneyTotal];
    
    //根据服务器端编码确定是否转码
    NSStringEncoding enc;
    //if UTF8编码
    //enc = NSUTF8StringEncoding;
    //if GBK编码
    enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *urlString = [NSString stringWithFormat:@"%@?plat=ios&order_no=%@&product_name=%@&order_price=%@",
                           SP_URL,
                           [[NSString stringWithFormat:@"%ld",time(0)] stringByAddingPercentEscapesUsingEncoding:enc],
                           [ORDER_NAME stringByAddingPercentEscapesUsingEncoding:enc],
                           ORDER_PRICE];
    
    //解析服务端返回json数据
    NSError *error;
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if ( response != nil) {
        NSMutableDictionary *dict = NULL;
        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
        dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        
        NSLog(@"url:%@",urlString);
        if(dict != nil){
            NSMutableString *retcode = [dict objectForKey:@"retcode"];
            if (retcode.intValue == 0){
                NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
                
                //调起微信支付
                PayReq* req             = [[PayReq alloc] init];
                req.openID              = [dict objectForKey:@"appid"];
                req.partnerId           = [dict objectForKey:@"partnerid"];
                req.prepayId            = [dict objectForKey:@"prepayid"];
                req.nonceStr            = [dict objectForKey:@"noncestr"];
                req.timeStamp           = stamp.intValue;
                req.package             = [dict objectForKey:@"package"];
                req.sign                = [dict objectForKey:@"sign"];
                [WXApi sendReq:req];
                
                //日志输出
                NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",req.openID,req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
            }else{
                [self alert:@"提示信息" msg:[dict objectForKey:@"retmsg"]];
            }
        }else{
            [self alert:@"提示信息" msg:@"服务器返回错误，未获取到json对象"];
        }
    }else{
        [self alert:@"提示信息" msg:@"服务器返回错误"];
    }

    
    //        BOOL flag = [WXApi sendReq:req];
    
}

//客户端提示信息
- (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alter show];
}

- (void)wxPayReturnInfo:(NSNotification *)anotification{
    BOOL isSeccessPay = [anotification.userInfo[@"WXSeccessOrFail"] boolValue];
    if (isSeccessPay) {
        [self showHint:@"支付成功"];
    }else{
        PayResp*resp = [anotification.userInfo objectForKey:@"WXReturnModel"];
        [self showHint:resp.errStr];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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



































