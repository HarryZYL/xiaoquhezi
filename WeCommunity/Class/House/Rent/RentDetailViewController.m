//
//  RentDetailViewController.m
//  WeCommunity
//
//  Created by Harry on 7/29/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//
#define BOOTOM_HEIGHT 45
#import "SummerRePostMyRentViewController.h"
#import "RentDetailViewController.h"
#import "RentPostViewController.h"
#import "UIViewController+HUD.h"

@interface RentDetailViewController ()<OrderHouseViewControllerDelegate>
@property (nonatomic ,strong)NSMutableDictionary *dicRoomData;
@property (nonatomic ,copy)NSString *strUserBookingCount;/**<自己发布的房屋，预约人数*/
//@property (nonatomic ,strong)NSMutableArray *roomArrary;/**<传人下一级的房屋图片*/
@property (assign) BOOL isBooking;/**<不是自己发布的，是否预约过*/
@end

@implementation RentDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupScrollView];
    
    // modify the data
    [self setupModel];
    //初始化页面
    
    [self setupFuncitonView];
    //设置底部功能界面
    [self setupBottomButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupScrollView{
    self.view.backgroundColor = [UIColor whiteColor];
    self.scollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scollView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    self.scollView.contentSize = CGSizeMake(self.view.frame.size.width, 800);
    [self.view addSubview:self.scollView];
}

-(void)setupModel{
    self.houseDeal = [[HouseDeal alloc] initWithData:self.detailData];
    self.activity = [[Activity alloc] initWithData:self.detailData];
    self.secondHand = [[SecondHand alloc] initWithData:self.detailData];
    User *user = [User shareUserDefult];
    if ([self.function isEqualToString:@"rent"]) {
        if (user.Userid.intValue != [self.houseDeal.creatorInfo[@"id"] intValue]) {
            [self setupLoadRoomData];//不是自己发布的,是否预约
        }else{
            //自己发布的,预约人数
            NSDictionary *pararma = @{@"id":self.houseDeal.objectId};
            [Networking retrieveData:get_HOUSE_DETAIL parameters:pararma success:^(id responseObject) {
                _strUserBookingCount = responseObject[@"bookingCount"];
                [self setupBottomButton];
//                self.functionBtn.btnLeft
            }];
        }
        
    }
}

- (void)setupLoadRoomData{
    __weak typeof(self)weakSelf = self;
    NSDictionary *parama = @{@"token": [User getUserToken],
                             @"houseDealId":self.houseDeal.objectId};
    [Networking retrieveData:GET_USER_BOOK parameters:parama roomSuccess:^(id responseObject) {
        _isBooking = [responseObject[@"msg"] boolValue];//是否当前用户租售过
        [weakSelf confirmBootomButtonTitle];
    }];
}

-(void)setupFuncitonView{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(previewFullImage:)];
    tapGesture.numberOfTouchesRequired = 1;
    CGRect viewFrame = CGRectMake(0, 64, self.scollView.frame.size.width, 800);
    if ([self.function isEqualToString:@"rent"]) {//租售
        self.rentView = [[RentDetailView alloc] initWithFrame:viewFrame andDataArray:self.detailData ];
        [self.rentView.headImg addGestureRecognizer:tapGesture];
        [self.scollView addSubview:self.rentView];
    }else if ([self.function isEqualToString:@"activity"]){
        self.activityView = [[ActivityDetailView alloc] initWithFrame:viewFrame data:self.detailData];
        [self.activityView.headImg addGestureRecognizer:tapGesture];
        [self.scollView addSubview:self.activityView];
    }else if ([self.function isEqualToString:@"secondHand"]){
        self.secondHandView = [[SecondHandView alloc] initWithFrame:viewFrame withData:self.detailData];
        [self.secondHandView.headImg addGestureRecognizer:tapGesture];
        [self.scollView addSubview:self.secondHandView];
    }
}

-(void)setupBottomButton{
    User *user = [User shareUserDefult];
    if (user.Userid.intValue == [self.houseDeal.creatorInfo[@"id"] intValue]) {
        self.functionBtn = [[SummerRentDetailBootomView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-BOOTOM_HEIGHT, self.view.frame.size.width, BOOTOM_HEIGHT) withItem:2];
        [self.functionBtn.btnRight addTarget:self action:@selector(rentDetailRePaier) forControlEvents:UIControlEventTouchUpInside];
    }else{
        self.functionBtn = [[SummerRentDetailBootomView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-BOOTOM_HEIGHT, SCREENSIZE.width, BOOTOM_HEIGHT) withItem:1];
    }
    [self confirmBootomButtonTitle];
    [self.functionBtn.btnLeft addTarget:self action:@selector(order:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.functionBtn];

}

- (void)confirmBootomButtonTitle{
    User *user = [User shareUserDefult];
    if ([self.function isEqualToString:@"rent"]) {
        
        if (user.Userid.intValue == [self.houseDeal.creatorInfo[@"id"] intValue]) {
            [self.functionBtn.btnRight configureButtonTitle:@"修改" backgroundColor:THEMECOLOR];
            if (_strUserBookingCount.intValue > 0) {
                //有无预约人数
                [self.functionBtn.btnLeft configureButtonTitle:[NSString stringWithFormat:@"已有%@人预约",_strUserBookingCount] backgroundColor:THEMECOLOR];
            }else{
                [self.functionBtn.btnLeft configureButtonTitle:@"暂无预约" backgroundColor:THEMECOLOR];
            }
            
        }else if (_isBooking){
            [self.functionBtn.btnLeft configureButtonTitle:@"取消预约" backgroundColor:THEMECOLOR];
        }else{
            [self.functionBtn.btnLeft configureButtonTitle:@"预约看房" backgroundColor:THEMECOLOR];
        }
        
    }else if([self.function isEqualToString:@"activity"]) {
        [self.functionBtn.btnLeft configureButtonTitle:@"参加活动" backgroundColor:THEMECOLOR];
    }else if([self.function isEqualToString:@"secondHand"]) {
        [self.functionBtn.btnLeft configureButtonTitle:@"购买" backgroundColor:THEMECOLOR];
    }
}

#pragma mark action
-(void)order:(id)sender{
    if ([self.functionBtn.btnLeft.currentTitle isEqualToString:@"预约看房"]) {
        OrderHouseViewController *orderVC = [[OrderHouseViewController alloc] init];
        orderVC.houseID = self.houseDeal.objectId;
        orderVC.delegate = self;
        [self pushVC:orderVC title:@"预约看房"];
    }else if([self.functionBtn.btnLeft.currentTitle isEqualToString:@"暂无预约"]){
        
    }else if([self.functionBtn.btnLeft.currentTitle isEqualToString:@"取消预约"]){
        //取消预约
        [self cansoleBooking];
    }else{
        SummerRentTakeNoteViewController *takeNoteVC = [[SummerRentTakeNoteViewController alloc] init];
        takeNoteVC.strRentID = self.houseDeal.objectId;
        [self.navigationController pushViewController:takeNoteVC animated:YES];
    }
    
}

-(void)pushVC:(UIViewController*)vc title:(NSString*)title{
    vc.navigationItem.title = title;
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)cansoleBooking{
    __weak typeof(self)weakSelf = self;
    NSDictionary *parama = @{@"token":[User getUserToken],
                             @"houseDealId":[NSNumber numberWithLong:self.houseDeal.objectId.integerValue]};
    [Networking retrieveData:POST_CANCELL_BOOKING parameters:parama roomSuccess:^(id responseObject) {
        if ([responseObject[@"state"] intValue] == 0) {
            [weakSelf showHint:@"取消预约成功"];
            [weakSelf.functionBtn.btnLeft configureButtonTitle:@"预约看房" backgroundColor:THEMECOLOR];
        }
    }];
    
}

#pragma mark preview photos

-(void)previewFullImage:(id)sender{
    if (!self.photos) {
        self.photos = [[NSMutableArray alloc] initWithCapacity:0];
    }else{
        [self.photos removeAllObjects];
    }
    for (int i = 0; i<self.houseDeal.pictures.count; i++) {
        MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:self.houseDeal.pictures[i]]];
        [self.photos addObject:photo];
    }
    // Create browser
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    
    browser = [Util fullImageSetting:browser];
//    [browser setCurrentPhotoIndex:self.rentView.headImg.adPageControl.currentPage];
    browser.displayActionButton = NO;
    [self.navigationController pushViewController:browser animated:YES];
    
}

- (void)rentDetailRePaier{
    //修改,房屋信息
//    SummerPostRentViewController *postVC = [[SummerPostRentViewController alloc] init];
//    postVC.houseDeal = self.houseDeal;
//    if ([self.houseDeal.dealType isEqualToString:@"Rent"]) {
//        postVC.houseDealType = SummerPostRentTypeRent;
//    }else{
//        postVC.houseDealType = SummerPostRentTypeSale;
//    }
//    postVC.strHouseDeailID = self.houseDeal.objectId;
//    [self.navigationController pushViewController:postVC animated:YES];
    
    SummerRePostMyRentViewController *postVC = [[SummerRePostMyRentViewController alloc] init];
    postVC.houseDeal = self.houseDeal;
    if ([self.houseDeal.dealType isEqualToString:@"Rent"]) {
        postVC.houseDealType = SummerPostRentTypeRent;
    }else{
        postVC.houseDealType = SummerPostRentTypeSale;
    }
    postVC.strHouseDeailID = self.houseDeal.objectId;
    [self.navigationController pushViewController:postVC animated:YES];
}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    // If we subscribe to this method we must dismiss the view controller ourselves
    NSLog(@"Did finish modal presentation");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)orderHouseRentSeccess{
    [self.functionBtn.btnLeft configureButtonTitle:@"取消预约" backgroundColor:THEMECOLOR];
}

@end
