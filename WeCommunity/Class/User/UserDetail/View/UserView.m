//
//  UserView.m
//  WeCommunity
//
//  Created by Harry on 8/21/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "UserView.h"
#import "SummerUserViewTableViewCell.h"

@interface UserView()
{
    User *user;
    NSString *authenType;
    UserViewTableViewCellType viewType;
}

@end

@implementation UserView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        user = [[User alloc] initWithData];
        authenType = [User getAuthenticationOwnerType];
        if ([authenType isEqualToString:@"认证户主"]) {
            _functionArray = @[@"成员管理",@"租售管理",@"缴费记录",@"我的收藏",@"设置"];
            _functionImage = @[@"我的房屋",@"我的活动",@"缴费记录",@"我的收藏",@"设置"];
        }else{
            _functionArray = @[@"租售管理",@"缴费记录",@"我的收藏",@"设置"];
            _functionImage = @[@"我的活动",@"缴费记录",@"我的收藏",@"设置"];
        }
        _mTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _mTableView.scrollEnabled   = NO;
        _mTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        [_mTableView registerNib:[UINib nibWithNibName:@"SummerUserViewTableViewCell" bundle:nil] forCellReuseIdentifier:@"summercell"];
        _mTableView.backgroundColor = [UIColor colorWithRed:61.0/255.0 green:204.0/255.0 blue:180.0/255.0 alpha:0.9];
        _mTableView.delegate = self;
        _mTableView.dataSource = self;
        [self addSubview:_mTableView];
        [self setTableViewHeaderView];
        _mTableView.separatorColor = [UIColor whiteColor];
        [_mTableView setTableFooterView:[[UIView alloc] init]];
    }
    return self;
}

- (void)setTableViewHeaderView{
    //        上半部分颜色初始化
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor colorWithRed:21.0/255.0 green:186.0/255.0 blue:154.0/255.0 alpha:.9];
    [self addSubview:topView];
    
    //        设置头像
    UIImageView *userHeadImg = [[UIImageView alloc] init];
    userHeadImg.frame = CGRectMake(20, 50, 65, 65);
    userHeadImg.layer.masksToBounds = YES;
    userHeadImg.layer.cornerRadius = userHeadImg.frame.size.width/2;
    userHeadImg.image = [UIImage imageNamed:@"smile"];
    [userHeadImg sd_setImageWithURL:user.headPhoto placeholderImage:[UIImage imageNamed:@"smile"]];
    [self addSubview:userHeadImg];
    
    //        设置用户名
    UILabel *title = [[UILabel alloc] init];
    title.frame = CGRectMake(userHeadImg.frame.origin.x+userHeadImg.frame.size.width+10, userHeadImg.frame.origin.y+userHeadImg.frame.size.height/2 - 15, 100, 30);
    title.text = user.nickName;
    title.textColor = [UIColor whiteColor];
    [self addSubview:title];
    
    UIButton *topBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [topBtn addTarget:self action:@selector(userHeaderView) forControlEvents:UIControlEventTouchUpInside];
    topBtn.frame = CGRectMake(0, userHeadImg.frame.origin.y, self.frame.size.width, userHeadImg.frame.size.height);
    [self addSubview:topBtn];
    
    UIImageView *iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(userHeadImg.frame.origin.x - 3, userHeadImg.frame.origin.y +userHeadImg.frame.size.height +30, 20, 20)];
    iconImg.image = [UIImage imageNamed:@"认证"];
    [self addSubview:iconImg];
    
    UIImageView *selectImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-30, iconImg.frame.origin.y, 20, 20)];
    selectImg.image = [UIImage imageNamed:@"cell_selection_stype"];
    selectImg.contentMode = UIViewContentModeCenter;
    [self addSubview:selectImg];
    //      设置地址
    UILabel *address = [[UILabel alloc] init];
    address.frame = CGRectMake(60, 140, 150, 30);
    address.text = [Util getCommunityName];
    address.textColor = [UIColor whiteColor];
    [self addSubview:address];
    
    UILabel *owerType = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-95, address.frame.origin.y + 2, 60, 25)];
    owerType.backgroundColor = [UIColor colorWithRed:0.953 green:0.408 blue:0.380 alpha:1.000];
    owerType.font = [UIFont fontWithName:fontName size:12];
    owerType.textColor = [UIColor whiteColor];
    owerType.textAlignment = NSTextAlignmentCenter;
    owerType.text = [User getAuthenticationOwnerType];
    owerType.layer.masksToBounds = YES;
    owerType.layer.cornerRadius = 10;
    [self addSubview:owerType];
    
    UIButton *addressBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    addressBtn.frame = CGRectMake(0, address.frame.origin.y, self.frame.size.width, 50 );
    [addressBtn addTarget:self action:@selector(userRoomAuthen) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addressBtn];
    topView.frame = CGRectMake(0, 0, self.frame.size.width, 180);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 180;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _functionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SummerUserViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"summercell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.backgroundColor = [UIColor colorWithRed:0.498 green:0.867 blue:0.804 alpha:.9];
    }
    cell.imageView.image = [UIImage imageNamed:_functionImage[indexPath.row]];
    cell.nameLab.text = _functionArray[indexPath.row];
    if (indexPath.row == _functionArray.count - 1) {
        cell.labLine.hidden = YES;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_functionArray.count == 5) {
        switch (indexPath.row) {
            case 0:
                viewType = UserViewTableViewCellTypeMemberManager;
                break;
            case 1:
                viewType = UserViewTableViewCellTypeSalesManagement;
                break;
            case 2:
                viewType = UserViewTableViewCellTypePaymentRecords;
                break;
            case 3:
                viewType = UserViewTableViewCellTypeCollection;
                break;
            case 4:
                viewType = UserViewTableViewCellTypeSeeting;
                break;
            default:

                break;
        }
        [self.delegate userViewDidSelectType:viewType];
    }else{
        switch (indexPath.row) {
            case 0:
                viewType = UserViewTableViewCellTypeSalesManagement;
                break;
            case 1:
                viewType = UserViewTableViewCellTypePaymentRecords;
                break;
            case 2:
                viewType = UserViewTableViewCellTypeCollection;
                break;
            case 3:
                viewType = UserViewTableViewCellTypeSeeting;
            default:
                break;
        }
        [self.delegate userViewDidSelectType:viewType];
    }
}

- (void)userRoomAuthen{
    viewType = UserViewTableViewCellTypeRoomAuthen;
    [self.delegate userViewDidSelectType:viewType];
}

- (void)userHeaderView{
    viewType = UserViewTableViewCellTypeUserInformation;
    [self.delegate userViewDidSelectType:viewType];
}

- (void)dealloc{
    _mTableView.delegate = nil;
}

@end
