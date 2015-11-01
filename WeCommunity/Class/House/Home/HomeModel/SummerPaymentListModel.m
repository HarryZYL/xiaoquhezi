//
//  SummerPaymentListModel.m
//  WeCommunity
//
//  Created by madarax on 15/11/1.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerPaymentListModel.h"

@implementation SummerPaymentListModel

@synthesize communityName;
@synthesize dates;
@synthesize fee;
@synthesize orderNO;
@synthesize parentNames;
@synthesize payTime;
@synthesize propertyName;


- (instancetype)initWithJson:(NSDictionary *)json{
    if (self = [super init]) {
        self.communityName = json[@"communityName"];
        self.dates = [Util formattedDate:json[@"dates"] type:2];
        
        self.fee = [NSString stringWithFormat:@"%@",json[@"fee"]];
        self.orderNO = json[@"orderNo"];
        self.parentNames = [NSString stringWithFormat:@"%@室",[json[@"parentNames"] componentsJoinedByString:@""]];
        self.payTime = [Util formattedDate:json[@"payTime"] type:1];
        self.propertyName = json[@"propertyName"];
    }
    return self;
}

@end
