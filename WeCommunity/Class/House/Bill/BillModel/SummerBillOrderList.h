//
//  SummerBillOrderList.h
//  WeCommunity
//
//  Created by madarax on 15/10/31.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SummerBillOrderList : NSObject

@property (nonatomic, copy) NSString * partner;
@property (nonatomic, copy) NSString * seller;

@property (nonatomic ,copy) NSString * tradeNO;              /**<订单ID*/
@property (nonatomic, copy) NSString * productName;         /**<商品名称/标题*/
@property (nonatomic, copy) NSString * productDescription;  /**<商品说明/描述*/
@property (nonatomic, copy) NSString * amount;              /**<商品价格*/
@property (nonatomic, copy) NSString * notifyURL;           /**<回调URL*/

@property(nonatomic, copy) NSString * service;
@property(nonatomic, copy) NSString * paymentType;
@property(nonatomic, copy) NSString * inputCharset;
@property(nonatomic, copy) NSString * itBPay;
@property(nonatomic, copy) NSString * showUrl;


@property(nonatomic, copy) NSString * rsaDate;//可选
@property(nonatomic, copy) NSString * appID;//可选

@property(nonatomic, readonly) NSMutableDictionary * extraParams;

@end
