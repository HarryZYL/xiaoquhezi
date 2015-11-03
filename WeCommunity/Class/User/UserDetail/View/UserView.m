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
        /*
        self.backgroundColor = [UIColor colorWithRed:29.0/255.0 green:165.0/255.0 blue:146.0/255.0 alpha:0.9];
//        上半部分颜色初始化
        UIView *topView = [[UIView alloc] init];
        topView.backgroundColor = [UIColor colorWithRed:29.0/255.0 green:185.0/255.0 blue:146.0/255.0 alpha:1];
        [self addSubview:topView];
        
//        设置头像
        self.userHeadImg = [[UIImageView alloc] init];
        self.userHeadImg.frame = CGRectMake(20, 50, 65, 65);
        self.userHeadImg.layer.masksToBounds = YES;
        self.userHeadImg.layer.cornerRadius = self.userHeadImg.frame.size.width/2;
        self.userHeadImg.image = [UIImage imageNamed:@"smile"];
        [self addSubview:self.userHeadImg];
//        设置用户名
        self.title = [[UILabel alloc] init];
        self.title.frame = CGRectMake(self.userHeadImg.frame.origin.x+self.userHeadImg.frame.size.width+10, self.userHeadImg.frame.origin.y+self.userHeadImg.frame.size.height/2 - 15, 100, 30);
        self.title.text = @"芝麻烧饼";
        self.title.textColor = [UIColor whiteColor];
        [self addSubview:self.title];

        self.topBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.topBtn.frame = CGRectMake(0, self.userHeadImg.frame.origin.y, frame.size.width, self.userHeadImg.frame.size.height);
        [self addSubview:self.topBtn];
        
        UIImageView *iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.userHeadImg.frame.origin.x, self.userHeadImg.frame.origin.y +self.userHeadImg.frame.size.height +40 , 20, 20)];
        iconImg.image = [UIImage imageNamed:@"认证"];
        [self addSubview:iconImg];
        
        UIImageView *selectImg = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width-30, iconImg.frame.origin.y+5, 20, 20)];
        selectImg.image = [UIImage imageNamed:@"箭头"];
        [self addSubview:selectImg];
//      设置地址
        self.address = [[UILabel alloc] init];
        self.address.frame = CGRectMake(50, 140, 150, 30);
        self.address.text = [Util getCommunityName];
        self.address.textColor = [UIColor whiteColor];
        [self addSubview:self.address];
        
        self.detail = [[UILabel alloc] init];
        self.detail.frame = CGRectMake(self.address.frame.origin.x, self.address.frame.origin.y+self.address.frame.size.height, 150, 20);
        self.detail.text = [User getAuthenticationAddress];
        self.detail.textColor = [UIColor whiteColor];
        [self addSubview:self.detail];
        
        self.owerType = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-95, self.address.frame.origin.y+15, 60, 25)];
        self.owerType.backgroundColor = [UIColor redColor];
        self.owerType.font = [UIFont fontWithName:fontName size:12];
        self.owerType.textColor = [UIColor whiteColor];
        self.owerType.textAlignment = NSTextAlignmentCenter;
        self.owerType.text = [User getAuthenticationOwnerType];
        self.owerType.layer.masksToBounds = YES;
        self.owerType.layer.cornerRadius = 10;
        [self addSubview:self.owerType];
        
        self.addressBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.addressBtn.frame = CGRectMake(0, self.address.frame.origin.y, frame.size.width, 50 );
        [self addSubview:self.addressBtn];
        
        topView.frame = CGRectMake(0, 0, frame.size.width, self.addressBtn.frame.origin.y+self.addressBtn.frame.size.height+20);
        
        
        CGFloat functionHeight = 50;
        
        NSArray *functionArray = @[@"租售管理",@"设置"];
        NSArray *functionImage = @[@"我的活动",@"设置"];
        self.firstBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.firstBtn.frame = CGRectMake(0, self.detail.frame.origin.y + 37 + 0*functionHeight, frame.size.width, functionHeight);
        [self addSubview:self.firstBtn];
        self.secondBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.secondBtn.frame = CGRectMake(0, self.detail.frame.origin.y + 37 + 1*functionHeight, frame.size.width, functionHeight);
        [self addSubview:self.secondBtn];
        
        self.thirdBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.thirdBtn.frame = CGRectMake(0, self.detail.frame.origin.y + 37 + 2*functionHeight, frame.size.width, functionHeight);
        [self addSubview:self.thirdBtn];
        
        self.fourthBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.fourthBtn.frame = CGRectMake(0, self.detail.frame.origin.y + 37 + 3*functionHeight, frame.size.width, functionHeight);
        [self addSubview:self.fourthBtn];
        
        self.fifthBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.fifthBtn.frame = CGRectMake(0, self.detail.frame.origin.y + 37 + 4*functionHeight, frame.size.width, functionHeight);
        [self addSubview:self.fifthBtn];
        
        self.sixthBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.sixthBtn.frame = CGRectMake(0, self.detail.frame.origin.y + 37 + 5*functionHeight, frame.size.width, functionHeight);
        [self addSubview:self.sixthBtn];
        
        
//        依次设置功能cell
        for (int i = 0; i<2; i++) {
            UIImageView *iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.userHeadImg.frame.origin.x, self.detail.frame.origin.y + 52.5 + i*functionHeight, 20, 20)];
            iconImg.image = [UIImage imageNamed:functionImage[i]];
            [self addSubview:iconImg];
            
            GrayLine *line = [[GrayLine alloc] initWithFrame:CGRectMake(iconImg.frame.origin.x, iconImg.frame.origin.y+iconImg.frame.size.height+15.5 -functionHeight, frame.size.width-iconImg.frame.origin.x, 1)];
            [self addSubview:line];
            
            UILabel *functionLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconImg.frame.origin.x+iconImg.frame.size.width+10, iconImg.frame.origin.y-2.5, 200, 27)];
            functionLabel.text = functionArray[i];
            functionLabel.textColor = [UIColor whiteColor];
            [self addSubview:functionLabel];

            
            UIImageView *selectImg = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width-30, iconImg.frame.origin.y+5, 20, 20)];
            selectImg.image = [UIImage imageNamed:@"箭头"];
            [self addSubview:selectImg];

        }
*/
        user = [[User alloc] initWithData];
        authenType = [User getAuthenticationOwnerType];
        if ([authenType isEqualToString:@"认证户主"]) {
            _functionArray = @[@"成员管理",@"租售管理",@"缴费记录",@"设置"];
            _functionImage = @[@"我的房屋",@"我的活动",@"缴费记录",@"设置"];
        }else{
            _functionArray = @[@"租售管理",@"缴费记录",@"设置"];
            _functionImage = @[@"我的活动",@"缴费记录",@"设置"];
        }
        _mTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _mTableView.backgroundColor = [UIColor colorWithRed:61/255.0 green:204/255.0 blue:180/255.0 alpha:1];
        _mTableView.scrollEnabled   = NO;
        [_mTableView registerNib:[UINib nibWithNibName:@"SummerUserViewTableViewCell" bundle:nil] forCellReuseIdentifier:@"summercell"];
        _mTableView.backgroundColor = [UIColor colorWithRed:61.0/255.0 green:204.0/255.0 blue:180.0/255.0 alpha:0.9];
        _mTableView.delegate = self;
        _mTableView.dataSource = self;
        [self addSubview:_mTableView];
        [self setTableViewHeaderView];
        [_mTableView setTableFooterView:[[UIView alloc] init]];
    }
    return self;
}

- (void)setTableViewHeaderView{
    self.backgroundColor = [UIColor colorWithRed:29.0/255.0 green:165.0/255.0 blue:146.0/255.0 alpha:0.9];
    //        上半部分颜色初始化
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor colorWithRed:21.0/255.0 green:186.0/255.0 blue:154.0/255.0 alpha:1];
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
    title.text = user.userName;
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
    selectImg.image = [UIImage imageNamed:@"箭头"];
    [self addSubview:selectImg];
    //      设置地址
    UILabel *address = [[UILabel alloc] init];
    address.frame = CGRectMake(60, 140, 150, 30);
    address.text = [Util getCommunityName];
    address.textColor = [UIColor whiteColor];
    [self addSubview:address];
    
    UILabel *owerType = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-95, address.frame.origin.y + 2, 60, 25)];
    owerType.backgroundColor = [UIColor redColor];
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
//    if ((_functionArray.count == 5 && indexPath.row == 3) || (_functionArray.count == 4 && indexPath.row == 2)) {
//        return 0;
//    }
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _functionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SummerUserViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"summercell" forIndexPath:indexPath];
    
    cell.imageView.image = [UIImage imageNamed:_functionImage[indexPath.row]];
    cell.nameLab.text = _functionArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_functionArray.count == 4) {
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
                viewType = UserViewTableViewCellTypeSeeting;
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
                viewType = UserViewTableViewCellTypeSeeting;
                break;
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
    _mTableView = nil;
    _functionImage = nil;
    _functionArray = nil;
}

@end
