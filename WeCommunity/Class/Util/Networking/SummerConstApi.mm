//
//  SummerConstApi.m
//  WeCommunity
//
//  Created by madarax on 16/1/4.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "SummerConstApi.h"

#define ServerUrl(api) [kServerUrl stringByAppendingString:api]

@implementation SummerConstApi

//#define HOST_URL @"http://www.xiaoquhezi.com"
//#define HOST_URL @"http://192.168.1.101"
NSString *const kServerUrl = @"http://www.xiaoquhezi.com";

NSString *const get_reply_notice      = ServerUrl(@"/notice/replyNotice"); /**<回复公告*/
NSString *const GET_NOTICE_REPLIS     = ServerUrl(@"/notice/getReplies"); //查询公告回复
NSString *const GET_REPLY_TO_REPLY    = ServerUrl(@"/notice/replyToReply");//楼中楼回复
NSString *const get_Reply_Replies     = ServerUrl(@"/notice/getReplyReplies");//查询楼中楼
NSString *const getNoticesOfCommunity = ServerUrl(@"/notice/getNoticesOfCommunity");//小区公告
NSString *const getNoticeDetail       = ServerUrl(@"/notice/getNotice");           //公告详情
NSString *const getMyAuthentications  = ServerUrl(@"/user/getMyAuthentications");

NSString *const get_COMPLAINTS_DETAIL = ServerUrl(@"/complaint/getComplaint");//投诉详情
NSString *const get_REPLIES_DETAIL    = ServerUrl(@"/complaint/getReplies");//查询投诉回复

NSString *const getMyAuthentictionDelete = ServerUrl(@"/authc/delete"); //删除认证
NSString *const get_HOUSE_LEVEL          = ServerUrl(@"/community/house/level/get");

NSString *const getMyComplaints            = ServerUrl(@"/complaint/user/getMyComplaints");
NSString *const getMyRepairs               = ServerUrl(@"/repair/user/getMyRepairs");
NSString *const getPraisesOfCommunity      = ServerUrl(@"/praise/getPraisesOfCommunity");
NSString *const getHouseDealsOfCommunity   = ServerUrl(@"/houseDeal/getHouseDealsOfCommunity");//小区房屋交易
NSString *const getMyHouseDealsOfCommunity = ServerUrl(@"/houseDeal/user/getMyHouseDeals");
NSString *const getAllHouseDeals           = ServerUrl(@"/houseDeal/getAllHouseDeals");
NSString *const getActivityOfCommunity     = ServerUrl(@"/activity/getActivityOfCommunity");
NSString *const getFleaMarketOfCommunity   = ServerUrl(@"/market/getFleaMarketOfCommunity");
NSString *const phoneLogin                 = ServerUrl(@"/phoneLogin");
NSString *const resetUserPassword          = ServerUrl(@"/user/resetUserPassword");
NSString *const phoneRegister              = ServerUrl(@"/phoneRegister");
NSString *const updateBasicInfo            = ServerUrl(@"/user/updateBasicInfo");
NSString *const getPhoneRegisterCaptcha    = ServerUrl(@"/getPhoneRegisterCaptcha");
NSString *const getResetUserPasswordCaptcha = ServerUrl(@"/user/getResetUserPasswordCaptcha");

NSString *const uploadImage    = ServerUrl(@"/upload/image/onem");//1M图片空间
NSString *const upload_Images  = ServerUrl(@"/upload/image");     //5M图片空间

NSString *const market_add               = ServerUrl(@"/market/add");
NSString *const getBuilding              = ServerUrl(@"/community/house/list"); /**<查找房号，楼号，单元号*/
NSString *const get_HOURSE_PEOPLE_NUMBER = ServerUrl(@"/user/authc/house/authc/get");//查看所有认证的房间的认证用户
NSString *const GET_AUTHC_HOUSE          = ServerUrl(@"/user/authc/house/get");//查询用户在当前小区认证房间
NSString *const GET_HOUSE_FEE            = ServerUrl(@"/fee/property/getOfHouse"); //指定的房间物业费
NSString *const GET_PROPERTY_HOUSE_FEE   = ServerUrl(@"/fee/property/house/get");//查找当前用户在指定小区已经认证过的房间,包含物业费是否缴纳信息

NSString *const getHouseId  = ServerUrl(@"/community/getHouses");

NSString *const get_Apple_ReAuthentication = ServerUrl(@"/user/authc/update");
NSString *const applyAuthentication        = ServerUrl(@"/user/applyAuthentication");
NSString *const getAuthenticationStatus    = ServerUrl(@"/user/getAuthenticationStatus");
NSString *const houseDeal_add              = ServerUrl(@"/houseDeal/add");
NSString *const complaint_add              = ServerUrl(@"/complaint/add");
NSString *const repair_add                 = ServerUrl(@"/repair/add");
NSString *const praise_add                 = ServerUrl(@"/praise/add");

NSString *const bookingHouse           = ServerUrl(@"/houseDeal/bookingHouse");
NSString *const get_HOUSE_DETAIL_EDITE = ServerUrl(@"/houseDeal/edit"); //房屋租售再次编辑
NSString *const  get_HOUSE_DETAIL      = ServerUrl(@"/houseDeal/getHouseDeal"); //房屋交易信息（若是自己的，是否有人预约）
NSString *const POST_CANCELL_BOOKING   = ServerUrl(@"/houseDeal/cancelBooking"); /**<取消预约*/
NSString *const getBooking             = ServerUrl(@"/houseDeal/getBooking"); /**<查询预约看房纪录*/
NSString *const GET_USER_BOOK          = ServerUrl(@"/houseDeal/isUserBooking"); /**<查询用户是否在当前租售上预约过*/
NSString *const GET_USER_BOOK_DETAIL   = ServerUrl(@"/houseDeal/getUserBookingOfHouseDeal"); /**<查询用户在指定房屋上的预约看房记录*/
NSString *const getMyComplaintsOfCommunity = ServerUrl(@"/complaint/user/getMyComplaintsOfCommunity");
NSString *const getMyRepairsOfCommunity    = ServerUrl(@"/repair/user/getMyRepairsOfCommunity");
NSString *const get_reply_complaint        = ServerUrl(@"/complaint/reply"); /**<回复投诉>*/

#pragma mark - 维修
NSString *const  GET_REPAIR       = ServerUrl(@"/repair/getRepair");   /**<报修详情*/
NSString *const  GET_REPLISE      = ServerUrl(@"/repair/getReplies");  /**<查询报修回复*/
NSString *const  GET_REPAIR_REPLY = ServerUrl(@"/repair/reply");       /**<查询回复报修*/

#pragma mark - 附近的小区
NSString *const  get_ONLY_CITY          = ServerUrl(@"/dd/getOnlyCity");               /**<获取城市*/
NSString *const  get_reply_repair       = ServerUrl(@"/repair/reply"); /**<回复报修*/
NSString *const  getNearbyCommnity      = ServerUrl(@"/community/getNearby");          /**<附近小区*/
NSString *const  getCommnityOfCity      = ServerUrl(@"/community/getCommunityOfCity"); /**<城市小区*/
NSString *const  get_COMMNITY_PRICE     = ServerUrl(@"/repair/getPrice");
NSString *const  get_Nearby_Phones_list = ServerUrl(@"/community/getPhones");
NSString *const  get_COMMNITY_PHONE_NMBER = ServerUrl(@"/community/getPropertyPhone");

NSString *const  get_ORDER_LIST_DELETE    = ServerUrl(@"/fee/property/order/delete");    //删除缴费记录
NSString *const  get_ORDER_LIST_FEE       = ServerUrl(@"/fee/property/order/payed/get"); //缴费记录
/**
 *  第三方登录接口
 */
NSString *const  get_LOGIN_CODE        = ServerUrl(@"/third/login/weixin/get"); //根据code 查询用户
NSString *const  get_THIRD_LOADING     = ServerUrl(@"/third/login/weixin/bind");
NSString *const  get_WXAPP_LOADING     = ServerUrl(@"/third/login");
NSString *const  get_THIRD_LOGIN_WXAPP = ServerUrl(@"/third/login/captcha/get"); //获取验证码
// 订单
NSString *const  get_Order_LIST     = ServerUrl(@"/fee/property/order/create"); //生成订单
NSString *const  get_Baidu_Push     = ServerUrl(@"/user/baidu/setPushId"); //推送
NSString *const  GET_CITY_PROVINCE  = ServerUrl(@"/city/getAllProvinces"); //省份
NSString *const  GET_CITY_CITYS     = ServerUrl(@"/city/getCities"); // 指定省份城市列表
NSString *const  GET_CITY_DISTRICTS = ServerUrl(@"/city/getDistricts"); //指定城市县区

NSString *const  GET_ALL_CITY = ServerUrl(@"/city/getAll");//所有城市
/**
 *
 *  金马会兑换
 *
 */
NSString *const JIN_EXPORY           = ServerUrl(@"/member/prize/list/get");
NSString *const JIN_MY_EXPORY        = ServerUrl(@"/user/prize/cash/my/list");
NSString *const JIN_EXPORY_DEFULT    = ServerUrl(@"/member/prize/detail/get"); /**兑奖详情*/
NSString *const JIN_EXPORY_SURE      = ServerUrl(@"/user/prize/cash"); /**确认兑奖*/
NSString *const JIN_MY_CITY_LIST     = ServerUrl(@"/user/address/my/list"); /**查询地址列表*/
NSString *const JIN_ADD_ADDRESS      = ServerUrl(@"/user/address/add/phone"); /**添加地址*/
NSString *const JIN_UPDATE_ADD       = ServerUrl(@"/user/address/update/phone"); /**更新地址*/
NSString *const JIN_DELETE_ADD       = ServerUrl(@"/user/address/delete/phone"); /**删除地址*/

NSString *const JIN_SUBMITE_INFOR    = ServerUrl(@"/user/info/member/fill"); //提交资料
NSString *const JIN_CARD_BIND        = ServerUrl(@"/user/card/member/bind"); //绑定会员卡
NSString *const JIN_CARD_BIND_CANCEL = ServerUrl(@"/user/card/member/cancel"); //解除绑定

@end
