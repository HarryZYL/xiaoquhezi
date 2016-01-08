//
//  HouseViewController.m
//  WeCommunity
//
//  Created by Harry on 7/20/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//
#import "HouseViewController.h"
#import "UIButton+WebCache.h"
#import "SummerRentMyViewController.h"
#import "SummerUserHeaderView.h"
#import "UIViewController+HUD.h"
#import "SummerQRCodeViewController.h"
#import "SummerCommunityBrowserViewController.h"
#import "SummerCollectViewController.h"
#import "SummerBillRoomViewController.h"
#import "SummerLoadingPageViewController.h"
#import "SummerMessageCenterTableViewController.h"
#import "SummerPaymentRecordsTableViewController.h"
#import "SummerMemberManagerTableViewController.h"
#import "SummerIntegralExchangeViewController.h"
#import "SummerNoticeCenterDetailViewController.h"

@interface HouseViewController ()<UserViewDelegate ,UIAlertViewDelegate>
{
    SummerUserHeaderView *barButtonItemView;
    UIButton *titleViewItem;
}
@end

@implementation HouseViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    barButtonItemView = [[SummerUserHeaderView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    User *userInfo = [User shareUserDefult];
    [barButtonItemView.btnUserImageView sd_setImageWithURL:userInfo.headPhoto forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"管家2"]];
    UITapGestureRecognizer *titleView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userOption:)];
    [barButtonItemView.touchViews addGestureRecognizer:titleView];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:barButtonItemView];
    
    titleViewItem = [UIButton buttonWithType:UIButtonTypeCustom];
    titleViewItem.frame = self.navigationItem.titleView.frame;
    
    [titleViewItem addTarget:self action:@selector(titleNavigationTap) forControlEvents:UIControlEventTouchUpInside];
    [titleViewItem setTitleColor:[UIColor colorWithRed:61/255.0 green:204/255.0 blue:180/255.0 alpha:1] forState:UIControlStateNormal];
    [titleViewItem setTitle:[Util getCommunityName] forState:UIControlStateNormal];
    self.navigationItem.titleView = titleViewItem;
    [self setupAppearance];
}

-(void)viewWillAppear:(BOOL)animated{
    if (![User judgeLogin]) {
        UserLoginViewController *loginVC = [[UserLoginViewController alloc] init];
        loginVC.function = @"login";
        loginVC.title = NSLocalizedString(@"Login_Title", nil);
        UINavigationController *nav =[[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }else{
        if (![Util judgeChooseCommunity]) {
            LocationTableViewController *locationVC = [[LocationTableViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:locationVC];
            [self.navigationController presentViewController:nav animated:YES completion:nil];
        }else{
            [titleViewItem setTitle:[Util getCommunityName] forState:UIControlStateNormal];
            [self retrireveData];
        }
        
    }
    User *userInfo = [User shareUserDefult];
    [barButtonItemView.btnUserImageView sd_setImageWithURL:userInfo.headPhoto forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"管家2"]];

}


-(void)setupAppearance{
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];

    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.showsVerticalScrollIndicator = NO;
//    if (is_IOS_8_Later) { 2015.10.26
        self.scrollView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
//    }
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.scrollView.frame.size.height+70);
        if (self.view.frame.size.height<650) {
            self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 700);
            NSLog(@"height%f",self.view.frame.size.height);
        }
    [self.view addSubview:self.scrollView];
    
    UIImageView *bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 200)];
    bgImg.image = [UIImage imageNamed:@"背景.png"];
    [self.scrollView addSubview:bgImg];
    
    self.headView = [[HousePostView alloc] initWithFrame:CGRectMake(10, 70, self.view.frame.size.width-20, 190)];
    self.headView.pageView.isTimeUp = YES;
    [self.headView.moreButton addTarget:self action:@selector(moreNotice:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.headView];
    
    self.functionView = [[FunctionView alloc] initWithFrame:CGRectMake(30, 290, self.view.frame.size.width-60, 230)];
    [self.functionView setupFunctionViewFirst:@"rent" title1:NSLocalizedString(@"Home_Rent", nil) Second:@"bill" title2:NSLocalizedString(@"Home_Pay", nil) Third:@"repair" title3:NSLocalizedString(@"Home_Repair", nil) Fourth:@"快递" title4:NSLocalizedString(@"Home_Express", nil) Fifth:@"金融理财" title5:NSLocalizedString(@"Home_Integral",nil) Sixth:@"其他Home" title6:NSLocalizedString(@"Home_More",nil)];
//    [self.functionView setupFunctionViewFirst:@"rent" title1:@"租售" Second:@"bill" title2:@"缴费" Third:@"repair" title3:@"维修" Fourth:@"快递" title4:@"快递" Fifth:@"其他Home" title5:@"更多" Sixth:nil title6:nil];
    [self.functionView.firstItem.functionButton addTarget:self action:@selector(rent:) forControlEvents:UIControlEventTouchUpInside];
    [self.functionView.secondItem.functionButton addTarget:self action:@selector(bill:) forControlEvents:UIControlEventTouchUpInside];
    [self.functionView.thirdItem.functionButton addTarget:self action:@selector(repair:) forControlEvents:UIControlEventTouchUpInside];
    [self.functionView.fourthItem.functionButton addTarget:self action:@selector(noFunction) forControlEvents:UIControlEventTouchUpInside];
    [self.functionView.fifthItem.functionButton addTarget:self action:@selector(integralExchange) forControlEvents:UIControlEventTouchUpInside];
    [self.functionView.sixthItem.functionButton addTarget:self action:@selector(houseKeeper:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.functionView];
    
    //line
    GrayLine *footLine = [[GrayLine alloc] initWithFrame:CGRectMake(20, self.functionView.frame.size.height+self.functionView.frame.origin.y+15, self.view.frame.size.width-40, .5)];
    [self.scrollView addSubview:footLine];
    
    self.footerView = [[HouseFooterView alloc] initWithFrame:CGRectMake(0, footLine.frame.origin.y+20, self.view.frame.size.width, 150)];
    
    [self.footerView.firstItem.footerBtn addTarget:self action:@selector(like:) forControlEvents:UIControlEventTouchUpInside];
    [self.footerView.secondItem.footerBtn addTarget:self action:@selector(advise:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.scrollView addSubview:self.footerView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)noFunction{
    [self showHint:@"功能暂未开放"];
}

/**
 *  投诉
 */
-(void)advise:(id)sender{
    if ([Util judgeAuthentication]) {
        TextTableViewController *textPostVC = [[TextTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        textPostVC.function = @"complaint";
        [self pushVC:textPostVC title:@"投诉"];
    }else{
        [self authentication];
    }
}


-(void)repair:(id)sender{
    if ([Util judgeAuthentication]) {
        TextTableViewController *textPostVC = [[TextTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        textPostVC.function = @"repair";
        [self pushVC:textPostVC title:@"报修"];
    }else{
        [self authentication];
    }
}

-(void)like:(id)sender{
    LikeTableViewController *likeVC = [[LikeTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self pushVC:likeVC title:@"表扬"];
}

-(void)rent:(id)sender{
    RentViewController *rentVC = [[RentViewController alloc] init];
    rentVC.playAdvertise = YES;
    rentVC.function = @"rent";
    [self pushVC:rentVC title:@"租售"];
}

-(void)bill:(id)sender{
    NSString *userAuthType = [User getAuthenticationOwnerType];
    if ([userAuthType isEqualToString:@"未认证"]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"还未认证，是否现在去认证" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag = 1000;
        [alertView show];
    }else if ([userAuthType isEqualToString:@"户主"] || [userAuthType isEqualToString:@"业主"]){
        BillViewController *billVC = [[BillViewController alloc] init];
        [self pushVC:billVC title:@"账单"];
    }else if ([userAuthType isEqualToString:@"认证失败"]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"认证失败，是否再次去认证" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag = 1002;
        [alertView show];
    }else{
        [self showHint:@"还在认证中"];
    }
}

-(void)houseKeeper:(id)sender{
    HouseKeeperViewController *houseKeeperVC = [[HouseKeeperViewController alloc] init];
    [self pushVC:houseKeeperVC title:@"管家"];
}

-(void)signin:(id)sender{
    SigninViewController *signinVC = [[SigninViewController alloc] init];
    [self pushVC:signinVC title:@"每日签到"];
}

-(void)reward:(id)sender{
    WebViewController *webVC = [[WebViewController alloc] init];
    webVC.webURL = @"http://wshequ.net/lottery";
    [self pushVC:webVC title:@"积分抽奖"];
}
-(void)overView:(id)sender{
    OverViewViewController *overViewVC = [[OverViewViewController alloc] init];
    [self pushVC:overViewVC title:@"小区一览"];
}

- (void)integralExchange{
    SummerIntegralExchangeViewController *integralExchangeVC = [[SummerIntegralExchangeViewController alloc] init];
    [self pushVC:integralExchangeVC title:@"积分兑换"];
}

-(void)pushVC:(UIViewController*)vc title:(NSString*)title{
    vc.navigationItem.title = title;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)moreNotice:(id)sender{
    NoticeTableViewController *noticeVC = [[NoticeTableViewController alloc] init];
    [self pushVC:noticeVC title:@"更多公告"];
}

#pragma mark user option

-(void)userOption:(id)sender{
    [self configurationSlider];
}

- (void)configurationSlider{
    self.userBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+60)];
    self.userBgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [self.view.window addSubview:self.userBgView];
    
    self.userView = [[UserView alloc] initWithFrame:CGRectMake(-self.view.frame.size.width*0.7, 0, self.view.frame.size.width*0.7, self.view.frame.size.height+60)];
    self.userView.delegate = self;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.userView.center = CGPointMake(self.userView.center.x + self.userView.frame.size.width , self.userView.center.y);
    }];
    
    [self.navigationController.view.window addSubview:self.userView];
    
//    [self hideTabBar];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeUserview)];
    tapGesture.numberOfTouchesRequired = 1;
    [self.userBgView addGestureRecognizer:tapGesture];
}


-(void)removeUserview{
    [UIView animateWithDuration:0.25 animations:^{
        [self.userBgView removeFromSuperview];
        self.userView.center = CGPointMake(self.userView.center.x - self.userView.frame.size.width, self.userView.center.y);
    } completion:^(BOOL finished) {
        [self.userView removeFromSuperview];
//        [self showTabBar];
    }];
}

- (void)userViewDidSelectType:(UserViewTableViewCellType)viewType{
    [self removeUserview];
    switch (viewType) {
        case 0:
        {
            NSString *userAuthType = [User getAuthenticationOwnerType];
            if ([userAuthType isEqualToString:@"未认证"]) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"还未认证，是否现在去认证" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alertView.tag = 1000;
                [alertView show];
            }else if ([userAuthType isEqualToString:@"户主"] || [userAuthType isEqualToString:@"业主"]){
                [self userRent];//租售管理
            }else if ([userAuthType isEqualToString:@"认证失败"]){
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"认证失败，是否再次去认证" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alertView.tag = 1002;
                [alertView show];
            }else{
                [self showHint:@"还在认证中"];
            }

        }
            break;
        case 1:
        {
//            @"消息中心",@"缴费记录",@"设置"
            NSString *userAuthType = [User getAuthenticationOwnerType];
            if ([userAuthType isEqualToString:@"未认证"]) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"还未认证，是否现在去认证" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alertView.tag = 1000;
                [alertView show];
            }else if ([userAuthType isEqualToString:@"户主"] || [userAuthType isEqualToString:@"业主"]){
                SummerPaymentRecordsTableViewController *paymentRecordsVC = [[SummerPaymentRecordsTableViewController alloc] init];
                paymentRecordsVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:paymentRecordsVC animated:YES];
            }else if ([userAuthType isEqualToString:@"认证失败"]){
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"认证失败，是否再次去认证" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alertView.tag = 1002;
                [alertView show];
            }else{
                [self showHint:@"还在认证中"];
            }
            
        }
            break;
        case 2:
        {
            NSString *userAuthType = [User getAuthenticationOwnerType];
            if ([userAuthType isEqualToString:@"未认证"]) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"还未认证，是否现在去认证" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alertView.tag = 1000;
                [alertView show];
            }else if ([userAuthType isEqualToString:@"户主"] || [userAuthType isEqualToString:@"业主"]){
                SummerMessageCenterTableViewController*messageCenterVC = [[SummerMessageCenterTableViewController alloc] init];
                messageCenterVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:messageCenterVC animated:YES];
            }else if ([userAuthType isEqualToString:@"认证失败"]){
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"认证失败，是否再次去认证" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alertView.tag = 1002;
                [alertView show];
            }else{
                [self showHint:@"还在认证中"];
            }
            
        }
            break;
        case 3:
        {
            [self userSetting];
        }
            break;
        case 4:
        {//成员管理
            NSString *userAuthType = [User getAuthenticationOwnerType];
            if ([userAuthType isEqualToString:@"未认证"]) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"还未认证，是否现在去认证" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alertView.tag = 1000;
                [alertView show];
            }else if ([userAuthType isEqualToString:@"户主"] || [userAuthType isEqualToString:@"业主"]){
                SummerMemberManagerTableViewController *memberVC = [[SummerMemberManagerTableViewController alloc] init];
                [self pushVC:memberVC title:nil];
            }else if ([userAuthType isEqualToString:@"认证失败"]){
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"认证失败，是否再次去认证" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alertView.tag = 1002;
                [alertView show];
            }else{
                [self showHint:@"还在认证中"];
            }
            
        }
            break;
        case 5:
        {
            [self userDetail];
        }
            break;
        case 6:
        {//认证信息
            [self userAccreditation];
        }
            break;
        case 7:
        {//我的收藏
            SummerCollectViewController *collectionVC = [[SummerCollectViewController alloc] init];
            collectionVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:collectionVC animated:YES];
        }
            break;
        case 8:
        {
            SummerQRCodeViewController *qrCodeVC = [[SummerQRCodeViewController alloc] init];
            qrCodeVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:qrCodeVC animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark networking

-(void)retrireveData{
    [Networking retrieveData:getNoticesOfCommunity parameters:@{ @"communityId":[Util getCommunityID],@"page":@"1",@"row":@3} success:^(id responseObject) {
        self.noticeData = responseObject[@"rows"];
        [self.headView.pageView removeFromSuperview];
        [self.headView configurePageViewData:self.noticeData];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(noticeDetail)];
        tapGesture.numberOfTouchesRequired = 1;
        [self.headView.pageView addGestureRecognizer:tapGesture];

    }];
}

-(void)noticeDetail{
    NSDictionary *dicTemp = self.noticeData[self.headView.pageView.adPageControl.currentPage];
    SummerNoticeCenterDetailViewController *noticeVC = [[SummerNoticeCenterDetailViewController alloc] init];
    noticeVC.strNoticeID = dicTemp[@"id"];
    noticeVC.detailNotice = [[Notice alloc] initWithData:self.noticeData[self.headView.pageView.adPageControl.currentPage]];
    [self pushVC:noticeVC title:nil];
}

#pragma mark user action

-(void)userSetting{
    SettingTableViewController *setting = [[SettingTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self pushVC:setting title:@"设置"];
    [self removeUserview];
}

-(void)userSecondHand:(id)sender{
    RentViewController *secondHandVC = [[RentViewController alloc] init];
    secondHandVC.function = @"secondHand";
    secondHandVC.playAdvertise = NO;
    [self pushVC:secondHandVC title:@"我的二手"];
    [self removeUserview];
}

-(void)userActivity:(id)sender{
    RentViewController *activityVC = [[RentViewController alloc] init];
    activityVC.function = @"activity";
    [self pushVC:activityVC title:@"我的活动"];
    [self removeUserview];
}
//租售管理
-(void)userRent{
    SummerRentMyViewController *rentVC = [[SummerRentMyViewController alloc] init];
    rentVC.function = @"rent";
    rentVC.playAdvertise = NO;
    [self pushVC:rentVC title:@"我的租售"];
}

-(void)userAccreditation{
    AccreditationTableViewController *accreditation = [[AccreditationTableViewController alloc] init];
    [self pushVC:accreditation title:@"认证信息"];
    [self removeUserview];
}

-(void)userDetail{
    UserDetailTableViewController *userDetailVC = [[UserDetailTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self pushVC:userDetailVC title:@"个人信息"];
    [self removeUserview];
}

-(void)authentication{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"还未认证，是否现在认证？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alertView show];

}

- (void)titleNavigationTap{
    SummerCommunityBrowserViewController *communitVC = [[SummerCommunityBrowserViewController alloc] init];
    [self pushVC:communitVC title:@"小区一览"];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (alertView.tag) {
        case 1000:
        {//认证
            if (buttonIndex == 1) {
                AccreditationTableViewController *accreditation = [[AccreditationTableViewController alloc] init];
                [self pushVC:accreditation title:@"认证信息"];
            }
        }
            break;
        case 1001:
            break;
        case 1002:
        {
            if (buttonIndex == 1) {
                AccreditationTableViewController *accreditation = [[AccreditationTableViewController alloc] init];
                [self pushVC:accreditation title:@"认证信息"];
            }
        }
            break;
            
        default:
        {
            if (buttonIndex == 1) {
                AccreditationPostViewController *postView = [[AccreditationPostViewController alloc] init];
                [self pushVC:postView title:@"发布认证"];
            }
        }
            break;
    }
    
}

- (void)dealloc{
    
}

@end
