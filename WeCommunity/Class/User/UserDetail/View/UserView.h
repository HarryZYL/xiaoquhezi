//
//  UserView.h
//  WeCommunity
//
//  Created by Harry on 8/21/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GrayLine.h"
#import "Util.h"

typedef enum : NSUInteger {
    UserViewTableViewCellTypeSalesManagement,/**租售管理<*/
    UserViewTableViewCellTypePaymentRecords,/**缴费记录<*/
    UserViewTableViewCellTypeMessage,/**信息<*/
    UserViewTableViewCellTypeSeeting,/**设置<*/
    UserViewTableViewCellTypeMemberManager,/**成员管理<*/
    UserViewTableViewCellTypeUserInformation,/**用户个人中心<*/
    UserViewTableViewCellTypeRoomAuthen,/**房屋认证<*/
    UserViewTableViewCellTypeCollection,/**用户收藏<*/
    UserViewTableViewCellTypeScanBarCode,/**二维码<*/
} UserViewTableViewCellType;
//@[@"租售管理",@"消息中心",@"缴费记录",@"设置",@"成员管理"]
@protocol UserViewDelegate <NSObject>

- (void)userViewDidSelectType:(UserViewTableViewCellType)viewType;

@end

@interface UserView : UIView<UITableViewDataSource ,UITableViewDelegate>

//这个是新版的第二版的用户界面，也就是抽屉的界面  这块是用View写的 所以你看看能不能优化成tableView
//以下所有button 都是用来跳转页面的 是看不见的button
@property (nonatomic, strong)UITableView *mTableView;
@property (nonatomic, strong)NSArray *functionArray;
@property (nonatomic, strong)NSArray *functionImage;

@property (nonatomic, weak)id delegate;

@end
