//
//  WechatPayManager.h
//  WeCommunity
//
//  Created by madarax on 15/11/1.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXUtil.h"
#import "ApiXml.h"
#import "WXApi.h"

@interface WechatPayManager : NSObject



// 账号帐户资料
// 更改商户把相关参数后可测试
//#define APP_ID          @"wx8728578ba70796d9"               //APPID
//#define APP_SECRET      @"d8b5a8bd463de63472970f5452d902b8" //appsecret
////商户号，填写商户对应参数
//#define MCH_ID          @"1276283701"
////商户API密钥，填写相应参数
//#define PARTNER_ID      @"2a19b58eae8e15675a5086207dafd5b2"
//支付结果回调页面
#define NOTIFY_URL      @"http://wxpay.weixin.qq.com/pub_v2/pay/notify.v2.php"
//获取服务器端支付数据地址（商户自定义）
#define SP_URL          @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php"


//预支付网关url地址
@property (nonatomic,strong) NSString* payUrl;

//debug信息
@property (nonatomic,strong) NSMutableString *debugInfo;
@property (nonatomic,assign) NSInteger lastErrCode;//返回的错误码

//商户关键信息
@property (nonatomic,strong) NSString *appId,*mchId,*spKey;


//初始化函数
- (instancetype)initWithAppID:(NSString*)appID mchID:(NSString*)mchID spKey:(NSString*)key;

//获取当前的debug信息
-(NSString *) getDebugInfo;

//获取预支付订单信息（核心是一个prepayID）
- (NSMutableDictionary*)getPrepayWithOrderName:(NSString*)name
                                         price:(NSString*)price
                                        device:(NSString*)device;
@end
