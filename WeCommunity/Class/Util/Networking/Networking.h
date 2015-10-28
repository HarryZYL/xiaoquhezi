//
//  Networking.h
//  WeCommunity
//
//  Created by Harry on 7/31/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HOST_URL @"http://www.wshequ.net"

#define getNoticesOfCommunity (HOST_URL @"/notice/getNoticesOfCommunity")
#define getMyAuthentications  (HOST_URL @"/user/getMyAuthentications")
#define getMyComplaints (HOST_URL @"/complaint/user/getMyComplaints")
#define getMyRepairs (HOST_URL @"/repair/user/getMyRepairs")
#define getPraisesOfCommunity (HOST_URL @"/praise/getPraisesOfCommunity")
#define getHouseDealsOfCommunity (HOST_URL @"/houseDeal/getHouseDealsOfCommunity")
#define getMyHouseDealsOfCommunity (HOST_URL @"/houseDeal/user/getMyHouseDeals")
#define getAllHouseDeals (HOST_URL @"/houseDeal/getAllHouseDeals")
#define getActivityOfCommunity (HOST_URL @"/activity/getActivityOfCommunity")
#define getFleaMarketOfCommunity (HOST_URL @"/market/getFleaMarketOfCommunity")
#define phoneLogin (HOST_URL @"/phoneLogin")
#define resetUserPassword (HOST_URL @"/user/resetUserPassword")
#define phoneRegister (HOST_URL @"/phoneRegister")
#define updateBasicInfo (HOST_URL @"/user/updateBasicInfo")
#define getPhoneRegisterCaptcha (HOST_URL @"/getPhoneRegisterCaptcha")
#define getResetUserPasswordCaptcha (HOST_URL @"/user/getResetUserPasswordCaptcha")
#define uploadImage (HOST_URL @"/upload/image/onem")
#define market_add (HOST_URL @"/market/add")
#define getBuilding (HOST_URL @"/community/getBuildings")
#define getHouseId (HOST_URL @"/community/getHouses")
#define applyAuthentication (HOST_URL @"/user/applyAuthentication")
#define getAuthenticationStatus (HOST_URL @"/user/getAuthenticationStatus")
#define houseDeal_add (HOST_URL @"/houseDeal/add")
#define complaint_add (HOST_URL @"/complaint/add")
#define repair_add (HOST_URL @"/repair/add")
#define praise_add (HOST_URL @"/praise/add")
#define bookingHouse (HOST_URL @"/houseDeal/bookingHouse")
#define getBooking (HOST_URL @"/houseDeal/getBooking")
#define getMyRepairsOfCommunity (HOST_URL @"/repair/user/getMyRepairsOfCommunity")
#define getMyComplaintsOfCommunity (HOST_URL @"/complaint/user/getMyComplaintsOfCommunity")

#pragma mark - GET_Repair
#define GET_REPAIR       (HOST_URL @"/repair/getRepair")   //报修详情
#define GET_REPLISE      (HOST_URL @"/repair/getReplies")  //查询报修回复
#define GET_REPAIR_REPLY (HOST_URL @"/repair/reply")       //查询回复报修

#pragma mark - NearbyCommunityOfCity
#define getNearbyCommnity (HOST_URL @"/community/getNearby")
#define getCommnityOfCity (HOST_URL @"/community/getCommunityOfCity")
#define get_COMMNITY_PRICE (HOST_URL @"/repair/getPrice")
#define get_COMMNITY_PHONE_NMBER (HOST_URL @"/community/getPropertyPhone")




@interface Networking : NSObject

+(void)retrieveData:(NSString*)url parameters:(NSDictionary*)parameters success:(void (^)(id responseObject))ablock;
+(void)retrieveData:(NSString*)url parameters:(NSDictionary*)parameters success:(void (^)(id responseObject))ablock addition:(void (^)())ablock2;
+(void)retrieveData:(NSString*)url parameters:(NSDictionary*)parameters;
+(void)upload:(NSMutableArray*)imageArr success:(void (^)(id responseObject))ablock;
+(void)uploadOne:(UIImage*)image success:(void (^)(id responseObject))ablock;
@end


























