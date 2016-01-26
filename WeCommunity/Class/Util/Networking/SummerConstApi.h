//
//  SummerConstApi.h
//  WeCommunity
//
//  Created by madarax on 16/1/4.
//  Copyright © 2016年 Jack. All rights reserved.
//  接口API

#import <Foundation/Foundation.h>

@interface SummerConstApi : NSObject

FOUNDATION_EXPORT NSString *const get_reply_notice      ;/**<回复公告*/
FOUNDATION_EXPORT NSString *const GET_NOTICE_REPLIS     ;//查询公告回复
FOUNDATION_EXPORT NSString *const GET_REPLY_TO_REPLY    ;//楼中楼回复
FOUNDATION_EXPORT NSString *const get_Reply_Replies     ;//查询楼中楼
FOUNDATION_EXPORT NSString *const getNoticesOfCommunity ;//小区公告
FOUNDATION_EXPORT NSString *const getNoticeDetail       ;//公告详情
FOUNDATION_EXPORT NSString *const getMyAuthentications  ;
FOUNDATION_EXPORT NSString *const get_COMPLAINTS_DETAIL ;//投诉详情
FOUNDATION_EXPORT NSString *const get_REPLIES_DETAIL    ;//查询投诉回复

FOUNDATION_EXPORT NSString *const getMyAuthentictionDelete ;//删除认证
FOUNDATION_EXPORT NSString *const get_HOUSE_LEVEL          ;
FOUNDATION_EXPORT NSString *const getMyComplaints          ;
FOUNDATION_EXPORT NSString *const getMyRepairs             ;
FOUNDATION_EXPORT NSString *const getPraisesOfCommunity    ;
FOUNDATION_EXPORT NSString *const getHouseDealsOfCommunity ;//小区房屋交易
FOUNDATION_EXPORT NSString *const getMyHouseDealsOfCommunity ;//个人房屋交易
FOUNDATION_EXPORT NSString *const getAllHouseDeals;
FOUNDATION_EXPORT NSString *const getActivityOfCommunity ;
FOUNDATION_EXPORT NSString *const getFleaMarketOfCommunity ;
FOUNDATION_EXPORT NSString *const phoneLogin ;
FOUNDATION_EXPORT NSString *const resetUserPassword ;
FOUNDATION_EXPORT NSString *const phoneRegister ;
FOUNDATION_EXPORT NSString *const updateBasicInfo ;
FOUNDATION_EXPORT NSString *const getPhoneRegisterCaptcha ;
FOUNDATION_EXPORT NSString *const getResetUserPasswordCaptcha ;
FOUNDATION_EXPORT NSString *const uploadImage   ;//1M图片上传空间
FOUNDATION_EXPORT NSString *const upload_Images ;//5M图片上传空间

FOUNDATION_EXPORT NSString *const market_add ;
FOUNDATION_EXPORT NSString *const getBuilding ;/**<查找房号，楼号，单元号*/
FOUNDATION_EXPORT NSString *const get_HOURSE_PEOPLE_NUMBER ;//查看所有认证的房间的认证用户
FOUNDATION_EXPORT NSString *const GET_AUTHC_HOUSE ;//查询用户在当前小区认证房间
FOUNDATION_EXPORT NSString *const GET_HOUSE_FEE  ; //指定的房间物业费
FOUNDATION_EXPORT NSString *const GET_PROPERTY_HOUSE_FEE  ;//查找当前用户在指定小区已经认证过的房间,包含物业费是否缴纳信息

FOUNDATION_EXPORT NSString *const getHouseId;

FOUNDATION_EXPORT NSString *const get_Apple_ReAuthentication ;
FOUNDATION_EXPORT NSString *const applyAuthentication        ;
FOUNDATION_EXPORT NSString *const getAuthenticationStatus    ;
FOUNDATION_EXPORT NSString *const houseDeal_add              ;
FOUNDATION_EXPORT NSString *const complaint_add              ;
FOUNDATION_EXPORT NSString *const repair_add                 ;
FOUNDATION_EXPORT NSString *const praise_add                 ;
FOUNDATION_EXPORT NSString *const bookingHouse          ;
FOUNDATION_EXPORT NSString *const get_HOUSE_DETAIL_EDITE;     //房屋租售再次编辑

FOUNDATION_EXPORT NSString *const get_HOUSE_DETAIL     ; //房屋交易信息（若是自己的，是否有人预约）
FOUNDATION_EXPORT NSString *const POST_CANCELL_BOOKING ; /**<取消预约*/
FOUNDATION_EXPORT NSString *const getBooking           ;    /**<查询预约看房纪录*/
FOUNDATION_EXPORT NSString *const GET_USER_BOOK        ; /**<查询用户是否在当前租售上预约过*/
FOUNDATION_EXPORT NSString *const GET_USER_BOOK_DETAIL ; /**<查询用户在指定房屋上的预约看房记录*/

FOUNDATION_EXPORT NSString *const getMyRepairsOfCommunity    ;
FOUNDATION_EXPORT NSString *const getMyComplaintsOfCommunity ;
FOUNDATION_EXPORT NSString *const get_reply_complaint ;/**<回复投诉>*/

#pragma mark - 报修
FOUNDATION_EXPORT NSString *const GET_REPAIR       ;  /**<报修详情*/
FOUNDATION_EXPORT NSString *const GET_REPLISE      ; /**<查询报修回复*/
FOUNDATION_EXPORT NSString *const GET_REPAIR_REPLY;      /**<查询回复报修*/
#pragma mark - 附近小区

FOUNDATION_EXPORT NSString *const get_Nearby_Phones_list;
FOUNDATION_EXPORT NSString *const getNearbyCommnity     ;          /**<附近小区*/
FOUNDATION_EXPORT NSString *const getCommnityOfCity     ; /**<城市小区*/
FOUNDATION_EXPORT NSString *const get_ONLY_CITY         ;           /**<获取城市*/
FOUNDATION_EXPORT NSString *const get_reply_repair      ; /**<回复报修*/
FOUNDATION_EXPORT NSString *const get_COMMNITY_PRICE    ;
FOUNDATION_EXPORT NSString *const get_COMMNITY_PHONE_NMBER ;
FOUNDATION_EXPORT NSString *const get_ORDER_LIST_DELETE     ; //删除缴费记录
FOUNDATION_EXPORT NSString *const get_ORDER_LIST_FEE        ;//缴费记录

#pragma mark -  第三方登录接口
FOUNDATION_EXPORT NSString *const get_LOGIN_CODE; //根据code 查询用户
FOUNDATION_EXPORT NSString *const get_THIRD_LOGIN_WXAPP;//获取验证码
FOUNDATION_EXPORT NSString *const get_THIRD_LOADING ;
FOUNDATION_EXPORT NSString *const get_WXAPP_LOADING ;
#pragma mark -  订单
FOUNDATION_EXPORT NSString *const get_Order_LIST ;//生成订单
FOUNDATION_EXPORT NSString *const get_Baidu_Push ; //推送
FOUNDATION_EXPORT NSString *const GET_CITY_PROVINCE  ; //省份
FOUNDATION_EXPORT NSString *const GET_CITY_CITYS     ; // 指定省份城市列表
FOUNDATION_EXPORT NSString *const GET_CITY_DISTRICTS ; //指定城市县区
FOUNDATION_EXPORT NSString *const GET_ALL_CITY ;//所有城市

#pragma mark - 金马会
FOUNDATION_EXPORT NSString *const JIN_EXPORY;
FOUNDATION_EXPORT NSString *const JIN_MY_EXPORY;
FOUNDATION_EXPORT NSString *const JIN_EXPORY_DEFULT;/**<兑奖详情*/
FOUNDATION_EXPORT NSString *const JIN_EXPORY_SURE ;/**<确认兑奖*/
FOUNDATION_EXPORT NSString *const JIN_MY_CITY_LIST ;/**<查询地址列表*/
FOUNDATION_EXPORT NSString *const JIN_ADD_ADDRESS  ;/**<添加地址*/
FOUNDATION_EXPORT NSString *const JIN_UPDATE_ADD   ;/**<更新地址*/
FOUNDATION_EXPORT NSString *const JIN_DELETE_ADD   ;/**<删除地址*/

FOUNDATION_EXPORT NSString *const JIN_SUBMITE_INFOR  ;  //提交资料
FOUNDATION_EXPORT NSString *const JIN_CARD_BIND       ;  //绑定会员卡
FOUNDATION_EXPORT NSString *const JIN_CARD_BIND_CANCEL;

@end
