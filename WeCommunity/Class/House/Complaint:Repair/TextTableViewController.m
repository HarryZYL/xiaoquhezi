//
//  TextTableViewController.m
//  WeCommunity
//
//  Created by Harry on 7/21/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//  报修列表

#import "TextTableViewController.h"
#import "UIViewController+HUD.h"
#import "SummerRepairListTableViewCell.h"
#import "SummerComplainViewController.h"
#import "AccreditationTableViewController.h"

@interface TextTableViewController ()<MWPhotoBrowserDelegate ,TextPostViewControllerDelegate ,UIAlertViewDelegate ,SummerRepairListTableViewCellDelegate>
@property (nonatomic ,strong) NSMutableArray *photos;
@end

@implementation TextTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.photos = [[NSMutableArray alloc] init];
    self.page = 1;
    if ([self.function isEqualToString:@"complaint"]) {
        UIBarButtonItem *postBtn = [[UIBarButtonItem alloc] initWithTitle:@"投诉" style:UIBarButtonItemStylePlain target:self action:@selector(post:)];
        self.navigationItem.rightBarButtonItem = postBtn;
    }else if([self.function isEqualToString:@"repair"]){
        [self.tableView registerClass:[BasicTableViewCell class] forCellReuseIdentifier:@"cell"];
        UIBarButtonItem *postBtn = [[UIBarButtonItem alloc] initWithTitle:@"报修" style:UIBarButtonItemStylePlain target:self action:@selector(post:)];
        self.navigationItem.rightBarButtonItem = postBtn;
    }
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];
    
    self.dataArray = [[NSMutableArray alloc] initWithCapacity:10];
    
    self.loadingView = [[LoadingView alloc] initWithFrame:self.view.frame];
    self.loadingView.titleLabel.text = @"正在加载";
    
    if ([User judgeLogin]) {
        [self retrireveData];
    }else{
        [self showHint:@"请先登录"];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SummerRepairListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellItem"];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"SummerRepairListTableViewCell" owner:self options:nil].firstObject;
        cell.delegate = self;
    }
    
    [cell confirmRepairListCellWithData:[[TextDeal alloc] initWithData:self.dataArray[indexPath.section] textType:self.function]];
    return cell;
}

- (void)summerRepairListCellWithData:(UIImageView *)sender{
    if (self.photos.count) {
        [self.photos removeAllObjects];
    }
    NSIndexPath *index = [self.tableView indexPathForCell:(UITableViewCell *)sender.superview.superview.superview];
    
    TextDeal *textDetalMode = [[TextDeal alloc] initWithData:self.dataArray[index.section] textType:self.function];
    if (![textDetalMode.pictures isEqual:[NSNull null]] && [textDetalMode.pictures.firstObject length] > 1) {
        for (int i = 0; i< [textDetalMode.pictures count]; i++) {
            MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:textDetalMode.pictures[i]]];
            [self.photos addObject:photo];
        }
        // Create browser
        MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
        browser = [Util fullImageSetting:browser];
        
        browser.displayActionButton = NO;
        [browser setCurrentPhotoIndex:sender.tag - 1];
        [self.navigationController pushViewController:browser animated:YES];
    }
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    TextDeal *textDeal = [[TextDeal alloc] initWithData:self.dataArray[indexPath.section] textType:self.function];
    if (![textDeal.pictures isEqual:[NSNull null]]) {
        if ([textDeal.pictures[0] length] < 1) {
            return 100;
        }else{
            return 158;
        }
    }else{
        return 100;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 5;
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.0001;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TextDetailTableViewController *textVC = [[TextDetailTableViewController alloc] init];
    textVC.textDeal = [[TextDeal alloc] initWithData:self.dataArray[indexPath.section] textType:self.function];
    
    if ([self.function isEqualToString:@"complaint"]) {
        SummerComplainViewController *complaintVC = [[SummerComplainViewController alloc] init];
        complaintVC.strDetailID = textVC.textDeal.Objectid;
        complaintVC.title = @"投诉详情";
        [self.navigationController pushViewController:complaintVC animated:YES];
    }else if([self.function isEqualToString:@"repair"]){
        SummerRepairListsViewController *listsVC = [[SummerRepairListsViewController alloc]init];
        listsVC.detailTextModel = [[TextDeal alloc] initWithData:self.dataArray[indexPath.section] textType:self.function];
        [self.navigationController pushViewController:listsVC animated:YES];
    }
}

# pragma mark retrieve data

-(void)retrireveData{

    [self.view addSubview:self.loadingView];
    NSDictionary *parameters = @{@"token":[User getUserToken],@"communityId":[Util getCommunityID],@"page":@1,@"row":[NSNumber numberWithInt:row]};
    NSString *url = @"";
    if ([self.function isEqualToString:@"complaint"]) {
        url = getMyComplaintsOfCommunity;
    }else if([self.function isEqualToString:@"repair"]){
        url = getMyRepairsOfCommunity;
    }
    [Networking retrieveData:url parameters:parameters success:^(id responseObject) {
        self.dataArray = responseObject[@"rows"];
        [self.tableView reloadData];
    } addition:^{
        [self.loadingView removeFromSuperview];
    }];
}

-(void)refreshHeader{
    NSDictionary *parameters = @{@"token":[User getUserToken],@"communityId":[Util getCommunityID],@"page":@1,@"row":[NSNumber numberWithInt:row]};
    NSString *url = @"";
    if ([self.function isEqualToString:@"complaint"]) {
        url = getMyComplaintsOfCommunity;
    }else if([self.function isEqualToString:@"repair"]){
        url = getMyRepairsOfCommunity;
    }
    [Networking retrieveData:url parameters:parameters success:^(id responseObject) {
        self.dataArray = responseObject[@"rows"];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer resetNoMoreData];
        self.page = 1;
    }];
}

-(void)refreshFooter{
    self.page ++;
    NSDictionary *parameters = @{@"token":[User getUserToken],@"communityId":[Util getCommunityID],@"page":@1,@"row":[NSNumber numberWithInt:row]};
    NSString *url = @"";
    if ([self.function isEqualToString:@"complaint"]) {
        url = getMyComplaintsOfCommunity;
    }else if([self.function isEqualToString:@"repair"]){
        url = getMyRepairsOfCommunity;
    }
    [Networking retrieveData:url parameters:parameters success:^(id responseObject) {
        self.dataArray = responseObject[@"rows"];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        if (self.dataArray.count < row*self.page) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    }];
}

# pragma mark - function
-(void)post:(id)sender{
    NSString *userAuthType = [User getAuthenticationOwnerType];
    if ([userAuthType isEqualToString:@"未认证"]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"还未认证，是否现在去认证" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag = 1000;
        [alertView show];
    }else if ([userAuthType isEqualToString:@"认证户主"] || [userAuthType isEqualToString:@"认证业主"]){
        TextPostViewController *textPostVC = [[TextPostViewController alloc] init];
        textPostVC.function = self.function;
        textPostVC.delegate = self;
        NSString *firstTitle = self.navigationItem.title;
        NSString *title = [NSString stringWithFormat:@"发布%@",firstTitle];
        textPostVC.navigationItem.title = title;
        [self.navigationController pushViewController:textPostVC animated:YES];
    }else if ([userAuthType isEqualToString:@"认证失败"]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"认证失败，是否再次去认证" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag = 1002;
        [alertView show];
    }else{
        [self showHint:@"还在认证中"];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
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

- (void)pushVC:(UIViewController *)postVC title:(NSString *)strTemp{
    postVC.title = strTemp;
    [self.navigationController pushViewController:postVC animated:YES];
}

- (void)issueInformationSeccess{
    [self refreshHeader];
}

@end
