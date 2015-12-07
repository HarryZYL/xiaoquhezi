//
//  SummerRepairListsViewController.m
//  WeCommunity
//
//  Created by madarax on 15/11/10.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerRepairListsViewController.h"
#import "SummerRepairListsHeaderTableViewCell.h"
#import "SummerRepairListsRepairCellTableViewCell.h"

@interface SummerRepairListsViewController ()<UzysAssetsPickerControllerDelegate ,MWPhotoBrowserDelegate>
{
    NSInteger pageNumber;
}
@property (nonatomic ,strong)NSMutableArray *chosenImages;
@property (nonatomic ,strong)NSMutableArray *arraryData;
@property (nonatomic ,strong)NSMutableArray *photos;

@end

@implementation SummerRepairListsViewController
#define IMPUT_VIEW_HEIGHT 50
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"报修单";
    pageNumber = 1;
    self.photos = [[NSMutableArray alloc] init];
    self.chosenImages = [[NSMutableArray alloc] init];
    
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, SCREENSIZE.height - IMPUT_VIEW_HEIGHT) style:UITableViewStyleGrouped];
    
    _mTableView.dataSource = self;
    _mTableView.delegate   = self;
    
    [self.mTableView registerNib:[UINib nibWithNibName:@"SummerRepairListsRepairCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellItem"];
    _mTableView.tableFooterView = [[UIView alloc] init];
    self.mTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getReceveData)];
    self.mTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];
    [self.view addSubview:_mTableView];
    _summerInputView = [[SummerInputView alloc] initWithFrame:CGRectMake(0, SCREENSIZE.height - IMPUT_VIEW_HEIGHT, SCREENSIZE.width, IMPUT_VIEW_HEIGHT)];
    [self.view addSubview:_summerInputView];
    
    [self.summerInputView.btnSenderMessage addTarget:self action:@selector(btnSenderMessageWithAddImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.summerInputView.btnAddImg addTarget:self action:@selector(btnSelectedImageViews:) forControlEvents:UIControlEventTouchUpInside];
    [self getReceveData];
}

- (void)getReceveData{
    if (_arraryData) {
        _arraryData = nil;
    }
    pageNumber = 1;
    __weak typeof(self)weakSelf = self;
    [Networking retrieveData:GET_REPLISE parameters:@{@"token": [User getUserToken],@"id":_detailTextModel.Objectid,@"page":[NSNumber numberWithInteger:pageNumber],@"row":@"30"} success:^(id responseObject) {
        [weakSelf.mTableView.mj_header endRefreshing];
        weakSelf.arraryData = responseObject[@"rows"];
        [weakSelf.mTableView reloadData];
    }];
}

- (void)refreshFooter{
    pageNumber ++;
    __weak typeof(self)weakSelf = self;
    [Networking retrieveData:GET_REPLISE parameters:@{@"token": [User getUserToken],@"id":_detailTextModel.Objectid,@"page":[NSNumber numberWithInteger:pageNumber],@"row":@"30"} success:^(id responseObject) {
        [weakSelf.mTableView.mj_footer endRefreshing];
        [weakSelf.arraryData addObjectsFromArray:responseObject[@"rows"]];
        [weakSelf.mTableView reloadData];
    }];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat contentHeight = [Util getHeightForString:_detailTextModel.content width:SCREENSIZE.width - 30 font:[UIFont systemFontOfSize:15]] + 60;
    
    if (![_detailTextModel.pictures isEqual:[NSNull null]]) {
        if (_detailTextModel.pictures.count > 0 && [_detailTextModel.pictures.firstObject length] > 5) {
            if (_detailTextModel.pictures.count >= 4) {
                contentHeight += 160;
            }else{
                contentHeight += 100;
            }
        }
        
    }
    
    return contentHeight + 55 + 67 + 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SummerRepairListsHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellnoticecenterdetail"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"SummerRepairListsHeaderTableViewCell" owner:self options:nil].firstObject;
    }
    __weak typeof(self)weakSelf = self;
    cell.tapItem = ^(NSInteger index){
        [weakSelf tableViewHeaderViewTap:index];
    };
    [cell confirmTableViewHeaderViewWithData:_detailTextModel];
    return cell;
}

- (void)tableViewHeaderViewTap:(NSInteger)index{
    if (self.photos) {
        [self.photos removeAllObjects];
    }
    for (int i = 0; i< [_detailTextModel.pictures count]; i++) {
        MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:_detailTextModel.pictures[i]]];
        [self.photos addObject:photo];
    }
    // Create browser
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser = [Util fullImageSetting:browser];
    
    browser.displayActionButton = NO;
    [browser setCurrentPhotoIndex:index - 1];
    [self.navigationController pushViewController:browser animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arraryData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dicTemp = _arraryData[indexPath.row];
    CGFloat heightCell = 40 + [Util getHeightForString:[dicTemp[@"content"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] width:SCREENSIZE.width - 70 font:[UIFont systemFontOfSize:15]];
    if ([dicTemp[@"pictures"] isEqual:[NSNull null]]) {
        return heightCell + 30;
    }else{
        NSArray *arr = dicTemp[@"pictures"];
        if (arr.count) {
            return 165;
        }
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SummerRepairListsRepairCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellItem" forIndexPath:indexPath];
    [cell confirmsCellDataWithData:_arraryData[indexPath.row]];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - 输入框，选择图片资源

- (void)btnSelectedImageViews:(UIButton *)sender{
    UzysAssetsPickerController *picker = [[UzysAssetsPickerController alloc] init];
    picker.delegate = self;
    picker.maximumNumberOfSelectionMedia = 8 - self.chosenImages.count;
    [self presentViewController:picker animated:YES completion:nil];
    
}

- (void)uzysAssetsPickerController:(UzysAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    if([[assets[0] valueForProperty:@"ALAssetPropertyType"] isEqualToString:@"ALAssetTypePhoto"]) //Photo
    {
        [assets enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ALAsset *representation = obj;
            if (self.chosenImages.count >= 8) {
                [self showHint:@"只能选择八张图片"];
            }
            UIImage *img = [UIImage imageWithCGImage:representation.defaultRepresentation.fullResolutionImage
                                               scale:representation.defaultRepresentation.scale
                                         orientation:(UIImageOrientation)representation.defaultRepresentation.orientation];
            
            [self.chosenImages addObject:img];
            
            if (idx==0 && self.chosenImages.count == 1) {
                
            }
            
        }];
        
    }
    //选择图片之后
    [self updatePhotoImages];
}

- (void)updatePhotoImages{
    if (self.chosenImages.count > 0) {
        self.summerInputView.summerInputLabNumbers.hidden = NO;
        self.summerInputView.summerInputLabNumbers.text = [NSString stringWithFormat:@"%ld",self.chosenImages.count];
    }
}

//发送信息
- (void)btnSenderMessageWithAddImage:(UIButton *)sender{
    [self.view endEditing:YES];
    NSLog(@"123---%@",self.summerInputView.summerInputView.text);
    if ([[User getAuthenticationOwnerType] isEqualToString:@"认证户主"] || [[User getAuthenticationOwnerType] isEqualToString:@"认证业主"]) {
        if (self.summerInputView.summerInputView.text.length < 1 && self.chosenImages.count < 1) {
            [self showHint:@"发送内容和图片不能都为空"];
            return;
        }
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"上传中";
        hud.dimBackground = YES;
        [hud hide:YES afterDelay:5];
        [self senderPostNoticeReplayWith:hud];
    }else{
        self.summerInputView.summerInputLabNumbers.text = nil;
        self.summerInputView.summerInputView.text = nil;
        [self.summerInputView.summerInputView resignFirstResponder];
        [self showHint:@"认证后，才能评论"];
    }
}

#pragma mark -

- (void)senderPostNoticeReplayWith:(MBProgressHUD *)hud{
    __weak typeof(self)weakSelf = self;
    if (self.chosenImages.count > 1 && self.summerInputView.summerInputView.text.length < 1) {
        //只发送图片
        [Networking upload:self.chosenImages success:^(id responseObject) {
            [weakSelf.chosenImages removeAllObjects];
            [Networking retrieveData:GET_REPAIR_REPLY parameters:@{@"token": [User getUserToken],@"id":_detailTextModel.Objectid,@"pictures":responseObject} success:^(id responseObject) {
                weakSelf.summerInputView.summerInputLabNumbers.text = 0;
                weakSelf.summerInputView.summerInputLabNumbers.hidden = YES;
                [weakSelf getReceveData];
            }];
        }];
    }else if(self.chosenImages.count < 1 && self.summerInputView.summerInputView.text.length > 1){
        //文字
        [Networking retrieveData:GET_REPAIR_REPLY parameters:@{@"token": [User getUserToken],
                                                               @"id":_detailTextModel.Objectid,
                                                               @"content":self.summerInputView.summerInputView.text} success:^(id responseObject) {
                                                                   //NoticeReply
                                                                   [hud removeFromSuperview];
                                                                   [weakSelf showHint:@"评论成功"];
                                                                   weakSelf.summerInputView.summerInputLabNumbers.text = 0;
                                                                   weakSelf.summerInputView.summerInputView.text = nil;
                                                                   [weakSelf getReceveData];
                                                               }];
    }else{
        //图片，文字
        [Networking upload:self.chosenImages success:^(id responseObject) {
            [Networking retrieveData:GET_REPAIR_REPLY parameters:@{@"token": [User getUserToken],
                                                                   @"id":_detailTextModel.Objectid,
                                                                   @"content":self.summerInputView.summerInputView.text,
                                                                   @"pictures":responseObject} success:^(id responseObject) {
                                                                       // 发送成功NoticeReply
                                                                       [hud removeFromSuperview];
                                                                       
                                                                       [weakSelf showHint:@"评论成功"];
                                                                       [weakSelf.chosenImages removeAllObjects];
                                                                       weakSelf.summerInputView.summerInputLabNumbers.hidden = YES;
                                                                       weakSelf.summerInputView.summerInputLabNumbers.text = 0;
                                                                       weakSelf.summerInputView.summerInputView.text = nil;
                                                                       
                                                                       [weakSelf getReceveData];
                                                                   }];
        }];
    }
}

//- (void)senderPostReplyToReplyWith:(MBProgressHUD *)hud{
//
//}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(summerKeybordViewWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(summerKeybordViewWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)summerKeybordViewWillShow:(NSNotification *)aNotificaiton{
    NSDictionary* info = [aNotificaiton userInfo];
    NSValue  *keybordRect = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect rectKeybord = keybordRect.CGRectValue;
    NSTimeInterval animationDuration = [[[aNotificaiton userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:animationDuration animations:^{
        _summerInputView.frame = CGRectMake(0, SCREENSIZE.height - IMPUT_VIEW_HEIGHT - rectKeybord.size.height, SCREENSIZE.width, IMPUT_VIEW_HEIGHT);
        self.mTableView.frame = CGRectMake(0, 0, SCREENSIZE.width, SCREENSIZE.height - IMPUT_VIEW_HEIGHT - rectKeybord.size.height);
    }];
}

- (void)summerKeybordViewWillHide:(NSNotification *)aNotification{
    NSTimeInterval animationDuration = [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:animationDuration animations:^{
        _summerInputView.frame = CGRectMake(0, SCREENSIZE.height - IMPUT_VIEW_HEIGHT, SCREENSIZE.width, IMPUT_VIEW_HEIGHT);
        
        self.mTableView.frame = CGRectMake(0, 0, SCREENSIZE.width, SCREENSIZE.height - IMPUT_VIEW_HEIGHT);
    }];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

- (void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
