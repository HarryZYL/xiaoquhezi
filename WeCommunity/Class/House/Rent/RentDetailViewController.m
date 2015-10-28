//
//  RentDetailViewController.m
//  WeCommunity
//
//  Created by Harry on 7/29/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "RentDetailViewController.h"

@interface RentDetailViewController ()

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
    
}

-(void)setupFuncitonView{
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(previewFullImage:)];
    tapGesture.numberOfTouchesRequired = 1;
    CGRect viewFrame = CGRectMake(0, 64, self.scollView.frame.size.width, 800);
    
    if ([self.function isEqualToString:@"rent"]) {
        
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
    
    self.functionBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.functionBtn.frame = CGRectMake(0, self.view.frame.size.height-40, self.view.frame.size.width, 40);
    if ([self.function isEqualToString:@"rent"]) {
        [self.functionBtn configureButtonTitle:@"预约看房" backgroundColor:THEMECOLOR];
    }else if([self.function isEqualToString:@"activity"]) {
        [self.functionBtn configureButtonTitle:@"参加活动" backgroundColor:THEMECOLOR];
    }else if([self.function isEqualToString:@"secondHand"]) {
        [self.functionBtn configureButtonTitle:@"购买" backgroundColor:THEMECOLOR];
    }
    
    [self.functionBtn addTarget:self action:@selector(order:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.functionBtn];

}

-(void)getBookingList{
    NSDictionary *parameters = @{
                                 @"token":[User getUserToken],
                                 @"id":self.houseDeal.objectId,
                                 @"page":@1,
                                 @"row":@10
                                 };
    [Networking retrieveData:getBooking parameters:parameters success:^(id responseObject) {
       
        
        
    }];
}


#pragma mark action
-(void)order:(id)sender{
    OrderHouseViewController *orderVC = [[OrderHouseViewController alloc] init];
    orderVC.houseID = self.houseDeal.objectId;
    [self pushVC:orderVC title:@"预约看房"];
    
}

-(void)pushVC:(UIViewController*)vc title:(NSString*)title{
    vc.navigationItem.title = title;
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark preview photos

-(void)previewFullImage:(id)sender{
    
    self.photos = [[NSMutableArray alloc] initWithCapacity:0];

    for (int i = 0; i<self.houseDeal.pictures.count; i++) {
        MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:self.houseDeal.pictures[i]]];
        [self.photos addObject:photo];
    }
    // Create browser
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = NO;
    browser = [Util fullImageSetting:browser];
    [browser setCurrentPhotoIndex:self.rentView.headImg.adPageControl.currentPage];
    [self.navigationController pushViewController:browser animated:YES];
    
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

@end
