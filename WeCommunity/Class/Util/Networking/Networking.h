//
//  Networking.h
//  WeCommunity
//
//  Created by Harry on 7/31/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HOST_URL @"http://www.wshequ.net"
//#define HOST_URL @"http://192.168.1.101:10000/wsq"

#define get_reply_notice (HOST_URL @"/notice/replyNotice") /**<回复公告*/

#define getNoticesOfCommunity (HOST_URL @"/notice/getNoticesOfCommunity")
#define getMyAuthentications  (HOST_URL @"/user/getMyAuthentications")

#define getMyAuthentictionDelete      (HOST_URL @"/authc/delete") //删除认证

#define get_HOUSE_LEVEL (HOST_URL @"/community/house/level/get")

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
#define market_add  (HOST_URL @"/market/add")
#define getBuilding (HOST_URL @"/community/house/list") /**<查找房号，楼号，单元号*/
#define get_HOURSE_PEOPLE_NUMBER (HOST_URL @"/user/authc/house/authc/get")//查看所有认证的房间的认证用户
#define GET_AUTHC_HOUSE (HOST_URL @"/user/authc/house/get")//查询用户在当前小区认证房间
#define GET_HOUSE_FEE   (HOST_URL @"/fee/property/getOfHouse") //指定的房间物业费
#define GET_PROPERTY_HOUSE_FEE    (HOST_URL @"/fee/property/house/get")//查找当前用户在指定小区已经认证过的房间,包含物业费是否缴纳信息

#define getHouseId  (HOST_URL @"/community/getHouses")
#define applyAuthentication (HOST_URL @"/user/applyAuthentication")
#define getAuthenticationStatus (HOST_URL @"/user/getAuthenticationStatus")
#define houseDeal_add (HOST_URL @"/houseDeal/add")
#define complaint_add (HOST_URL @"/complaint/add")
#define repair_add (HOST_URL @"/repair/add")
#define praise_add (HOST_URL @"/praise/add")

#define bookingHouse (HOST_URL @"/houseDeal/bookingHouse")
#define POST_CANCELL_BOOKING (HOST_URL @"/houseDeal/cancelBooking") /**<取消预约*/
#define getBooking           (HOST_URL @"/houseDeal/getBooking")    /**<查询预约看房纪录*/
#define GET_USER_BOOK        (HOST_URL @"/houseDeal/isUserBooking") /**<查询用户是否在当前租售上预约过*/
#define GET_USER_BOOK_DETAIL (HOST_URL @"/houseDeal/getUserBookingOfHouseDeal") /**<查询用户在指定房屋上的预约看房记录*/

#define getMyRepairsOfCommunity    (HOST_URL @"/repair/user/getMyRepairsOfCommunity")
#define getMyComplaintsOfCommunity (HOST_URL @"/complaint/user/getMyComplaintsOfCommunity")


#define get_reply_complaint (HOST_URL @"/complaint/reply") /**<回复投诉>*/

#pragma mark - GET_Repair
#define GET_REPAIR       (HOST_URL @"/repair/getRepair")   /**<报修详情*/
#define GET_REPLISE      (HOST_URL @"/repair/getReplies")  /**<查询报修回复*/
#define GET_REPAIR_REPLY (HOST_URL @"/repair/reply")       /**<查询回复报修*/

#pragma mark - NearbyCommunityOfCity
#define getNearbyCommnity         (HOST_URL @"/community/getNearby")          /**<附近小区*/
#define getCommnityOfCity         (HOST_URL @"/community/getCommunityOfCity") /**<城市小区*/
#define get_ONLY_CITY             (HOST_URL @"/dd/getOnlyCity")               /**<获取城市*/

#define get_reply_repair          (HOST_URL @"/repair/reply") /**<回复报修*/
#define get_COMMNITY_PRICE        (HOST_URL @"/repair/getPrice")
#define get_COMMNITY_PHONE_NMBER  (HOST_URL @"/community/getPropertyPhone")

#define get_ORDER_LIST_DELETE     (HOST_URL @"/fee/property/order/delete")     //删除缴费记录
#define get_ORDER_LIST_FEE        (HOST_URL @"/fee/property/order/payed/get") //缴费记录
/**
 *  第三方登录接口
 */
#define get_LOGIN_CODE (HOST_URL @"/third/login/weixin/get") //根据code 查询用户
#define get_THIRD_LOGIN_WXAPP (HOST_URL @"/third/login/captcha/get")//获取验证码
#define get_THIRD_LOADING (HOST_URL @"/third/login/weixin/bind")
// 订单
#define get_Order_LIST (HOST_URL @"/fee/property/order/create")//生成订单

@interface Networking : NSObject

+(void)retrieveData:(NSString*)url parameters:(NSDictionary*)parameters success:(void (^)(id responseObject))ablock;
+(void)retrieveData:(NSString*)url parameters:(NSDictionary*)parameters success:(void (^)(id responseObject))ablock addition:(void (^)())ablock2;
+(void)retrieveData:(NSString*)url parameters:(NSDictionary*)parameters roomSuccess:(void(^)(id responseObject))ablock;

+(void)retrieveData:(NSString*)url parameters:(NSDictionary*)parameters;
+(void)upload:(NSMutableArray*)imageArr success:(void (^)(id responseObject))ablock;
+(void)uploadOne:(UIImage*)image success:(void (^)(id responseObject))ablock;
@end


























