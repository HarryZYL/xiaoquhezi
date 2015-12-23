//
//  Networking.h
//  WeCommunity
//
//  Created by Harry on 7/31/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define HOST_URL @"http://www.wshequ.net"

#define HOST_URL @"http://192.168.1.101"

#define get_reply_notice      (HOST_URL @"/notice/replyNotice") /**<回复公告*/
#define GET_NOTICE_REPLIS     (HOST_URL @"/notice/getReplies") //查询公告回复
#define GET_REPLY_TO_REPLY    (HOST_URL @"/notice/replyToReply")//楼中楼回复
#define get_Reply_Replies     (HOST_URL @"/notice/getReplyReplies")//查询楼中楼
#define getNoticesOfCommunity (HOST_URL @"/notice/getNoticesOfCommunity")//小区公告
#define getNoticeDetail       (HOST_URL @"/notice/getNotice")           //公告详情
#define getMyAuthentications  (HOST_URL @"/user/getMyAuthentications")

#define get_COMPLAINTS_DETAIL (HOST_URL @"/complaint/getComplaint")//投诉详情
#define get_REPLIES_DETAIL    (HOST_URL @"/complaint/getReplies")//查询投诉回复

#define getMyAuthentictionDelete (HOST_URL @"/authc/delete") //删除认证
#define get_HOUSE_LEVEL          (HOST_URL @"/community/house/level/get")

#define getMyComplaints          (HOST_URL @"/complaint/user/getMyComplaints")
#define getMyRepairs             (HOST_URL @"/repair/user/getMyRepairs")
#define getPraisesOfCommunity    (HOST_URL @"/praise/getPraisesOfCommunity")
#define getHouseDealsOfCommunity (HOST_URL @"/houseDeal/getHouseDealsOfCommunity")//小区房屋交易
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
#define uploadImage   (HOST_URL @"/upload/image/onem")//1M图片空间
#define upload_Images (HOST_URL @"/upload/image")     //5M图片空间

#define market_add  (HOST_URL @"/market/add")
#define getBuilding (HOST_URL @"/community/house/list") /**<查找房号，楼号，单元号*/
#define get_HOURSE_PEOPLE_NUMBER (HOST_URL @"/user/authc/house/authc/get")//查看所有认证的房间的认证用户
#define GET_AUTHC_HOUSE (HOST_URL @"/user/authc/house/get")//查询用户在当前小区认证房间
#define GET_HOUSE_FEE   (HOST_URL @"/fee/property/getOfHouse") //指定的房间物业费
#define GET_PROPERTY_HOUSE_FEE    (HOST_URL @"/fee/property/house/get")//查找当前用户在指定小区已经认证过的房间,包含物业费是否缴纳信息

#define getHouseId  (HOST_URL @"/community/getHouses")

#define get_Apple_ReAuthentication (HOST_URL @"/user/authc/update")
#define applyAuthentication        (HOST_URL @"/user/applyAuthentication")
#define getAuthenticationStatus    (HOST_URL @"/user/getAuthenticationStatus")
#define houseDeal_add              (HOST_URL @"/houseDeal/add")
#define complaint_add              (HOST_URL @"/complaint/add")
#define repair_add                 (HOST_URL @"/repair/add")
#define praise_add                 (HOST_URL @"/praise/add")

#define bookingHouse                (HOST_URL @"/houseDeal/bookingHouse")
#define get_HOUSE_DETAIL_EDITE      (HOST_URL @"/houseDeal/edit")         //房屋租售再次编辑

#define get_HOUSE_DETAIL     (HOST_URL @"/houseDeal/getHouseDeal") //房屋交易信息（若是自己的，是否有人预约）
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

#define get_Nearby_Phones_list    (HOST_URL @"/community/getPhones")
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
#define get_WXAPP_LOADING (HOST_URL @"/third/login")
// 订单
#define get_Order_LIST (HOST_URL @"/fee/property/order/create")//生成订单

#define get_Baidu_Push (HOST_URL @"/user/baidu/setPushId")   //推送

#define GET_CITY_PROVINCE   (HOST_URL @"/city/getAllProvinces") //省份
#define GET_CITY_CITYS      (HOST_URL @"/city/getCities")  // 指定省份城市列表
#define GET_CITY_DISTRICTS  (HOST_URL @"/city/getDistricts")  //指定城市县区

#define GET_ALL_CITY (HOST_URL @"/city/getAll")//所有城市

/**
 *
 *  金马会兑换
 *
 */
#define JIN_EXPORY        (HOST_URL @"/member/prize/list/get")/**所有兑奖*/
#define JIN_MY_EXPORY     (HOST_URL @"/user/prize/cash/my/list")/**我的兑奖*/
#define JIN_EXPORY_DEFULT (HOST_URL @"/member/prize/detail/get")/**兑奖详情*/
#define JIN_EXPORY_SURE   (HOST_URL @"/user/prize/cash")/**确认兑奖*/
#define JIN_MY_CITY_LIST  (HOST_URL @"/user/address/my/list")/**查询地址列表*/
#define JIN_ADD_ADDRESS   (HOST_URL @"/user/address/add/phone")/**添加地址*/
#define JIN_UPDATE_ADD    (HOST_URL @"/user/address/update/phone")/**更新地址*/
#define JIN_DELETE_ADD    (HOST_URL @"/user/address/delete/phone")/**删除地址*/

@interface Networking : NSObject

+(void)retrieveData:(NSString*)url parameters:(NSDictionary*)parameters success:(void (^)(id responseObject))ablock;
+(void)retrieveData:(NSString*)url parameters:(NSDictionary*)parameters success:(void (^)(id responseObject))ablock addition:(void (^)())ablock2;
+(void)retrieveData:(NSString*)url parameters:(NSDictionary*)parameters roomSuccess:(void(^)(id responseObject))ablock;

+(void)retrieveData:(NSString*)url parameters:(NSDictionary*)parameters;
+(void)upload:(NSMutableArray*)imageArr success:(void (^)(id responseObject))ablock;
+(void)uploadOne:(UIImage*)image success:(void (^)(id responseObject))ablock;
@end


























