//
//  Accreditation.h
//  WeCommunity
//
//  Created by Harry on 8/30/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Accreditation : NSObject

@property (nonatomic,strong) NSString *objectId;
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSURL *headPhoto;
@property (nonatomic,strong) NSString *communityId;
@property (nonatomic,strong) NSDictionary *community;
@property (nonatomic,strong) NSString *realName;
@property (nonatomic,strong) NSString *cardType;
@property (nonatomic,strong) NSString *cardTypeName;
@property (nonatomic,strong) NSString *cardNumber;
@property (nonatomic,strong) NSString *houseId;
@property (nonatomic,strong) NSString *houseName;
@property (nonatomic,strong) NSString *buildingId;
@property (nonatomic,strong) NSString *buildingName;
@property (nonatomic,strong) NSString *applyTime;
@property (nonatomic,strong) NSString *auditorId;
@property (nonatomic,strong) NSString *auditTime;
@property (nonatomic,strong) NSString *auditStatus;
@property (nonatomic,strong) NSString *auditFailedReason;
@property (nonatomic,strong) NSString *ownerType;
@property (nonatomic,strong) NSString *ownerTypeName;
@property (nonatomic,strong) NSString *reciveTime;

-(id)initWithData:(NSDictionary *)data;

@end
