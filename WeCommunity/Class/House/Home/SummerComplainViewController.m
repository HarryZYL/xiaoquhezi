//
//  SummerComplainViewController.m
//  WeCommunity
//
//  Created by madarax on 15/11/8.
//  Copyright © 2015年 Harry. All rights reserved.
//  投诉详情

#import "SummerComplainViewController.h"
#import "SummerComplainDetailHeaderTableViewCell.h"
#import "SummerNoticeDetailTableViewCell.h"
#import "TextDeal.h"

#define IMPUT_VIEW_HEIGHT 40
@interface SummerComplainViewController ()<UzysAssetsPickerControllerDelegate ,SummerComplainDetailHeaderTableViewCellDelegate ,MWPhotoBrowserDelegate>
{
    NSInteger numberPage;
    CGFloat headerViewHeight;
}
@property (nonatomic ,strong) NSMutableArray *chosenImages;
@property (nonatomic ,strong) NSMutableArray *arraryData;
@property (nonatomic ,strong) TextDeal *complainModel;
@property (nonatomic ,strong) NSMutableArray *photos;
@end

@implementation SummerComplainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"投诉详情";
    self.photos = [[NSMutableArray alloc] init];
    self.arraryData = [[NSMutableArray alloc] init];
    self.chosenImages = [[NSMutableArray alloc] init];
    numberPage = 1;
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, SCREENSIZE.height - IMPUT_VIEW_HEIGHT) style:UITableViewStyleGrouped];
    
    _mTableView.dataSource = self;
    _mTableView.delegate   = self;
    self.mTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getReceveData)];
    self.mTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];
    [self.mTableView registerNib:[UINib nibWithNibName:@"SummerComplainDetailHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellItem"];
    _mTableView.tableFooterView = [[UIView alloc] init];
    
    [self.view addSubview:_mTableView];
    _summerInputView = [[SummerInputView alloc] initWithFrame:CGRectMake(0, SCREENSIZE.height - IMPUT_VIEW_HEIGHT, SCREENSIZE.width, IMPUT_VIEW_HEIGHT)];
    [self.view addSubview:_summerInputView];
    
    [self.summerInputView.btnSenderMessage addTarget:self action:@selector(btnSenderMessageWithAddImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.summerInputView.btnAddImg addTarget:self action:@selector(btnSelectedImageViews:) forControlEvents:UIControlEventTouchUpInside];
    [self getReceveData];
    [self getComplaintDetail];
}

- (void)getComplaintDetail{
    __weak typeof(self)weakSelf = self;
    if (_arraryData) {
        [_arraryData removeAllObjects];
    }
    NSDictionary *parama = @{@"id": self.strDetailID,
                             @"page":[NSNumber numberWithInteger:numberPage],
                             @"row":@"30",
                             @"token":[User getUserToken]};
    [Networking retrieveData:get_REPLIES_DETAIL parameters:parama success:^(id responseObject) {
        NSLog(@"---->%@",responseObject);
        [weakSelf.mTableView.mj_header endRefreshing];
        for (NSDictionary *dicTemp in responseObject[@"rows"]) {
            [_arraryData addObject:[[TextDeal alloc] initWithData:dicTemp textType:@"complaint"]];
        }
        [weakSelf.mTableView reloadData];
    }];
}

- (void)refreshFooter{
    __weak typeof(self)weakSelf = self;
    numberPage ++;
    NSDictionary *parama = @{@"id": self.strDetailID,
                             @"page":[NSNumber numberWithInteger:numberPage],
                             @"row":@"30",
                             @"token":[User getUserToken]};
    [Networking retrieveData:get_REPLIES_DETAIL parameters:parama success:^(id responseObject) {
        NSLog(@"---->%@",responseObject);
        [weakSelf.mTableView.mj_footer endRefreshing];
        for (NSDictionary *dicTemp in responseObject[@"rows"]) {
            [weakSelf.arraryData addObject:[[TextDeal alloc] initWithData:dicTemp textType:@"complaint"]];
        }
        if (numberPage * 30 > weakSelf.arraryData.count) {
            [weakSelf.mTableView.mj_footer endRefreshingWithNoMoreData];
        }
        [weakSelf.mTableView reloadData];
    }];
}

- (void)getReceveData{
    if (_arraryData.count) {
        [_arraryData removeAllObjects];
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"加载中";
    //    hud.dimBackground = YES;
    [hud hide:YES afterDelay:5];
    __weak typeof(self) weakSelf = self;
    [Networking retrieveData:get_COMPLAINTS_DETAIL parameters:@{@"id": self.strDetailID,
                                                            @"token":[User getUserToken],}success:^(id responseObject) {
                                                                [hud removeFromSuperview];
                                                                _complainModel = [[TextDeal alloc] initWithData:responseObject textType:@"complaint"];
                                                                [weakSelf.mTableView reloadData];
                                                            }];
}

#pragma mark - UITableViewDelegate

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    CGFloat rectHeight = [Util getHeightForString:_complainModel.content width:SCREENSIZE.width - 50 font:[UIFont systemFontOfSize:13]];
//    if ([_complainModel.pictures isEqual:[NSNull null]]) {
//        return 61 + rectHeight;
//    }
//    headerViewHeight = 80 + (_complainModel.pictures.count/4 + 1) * (40 + 5) + rectHeight;
//    return headerViewHeight;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    SummerComplainDetailHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellheaderdetail"];
//    if (!cell) {
//        cell = [[NSBundle mainBundle] loadNibNamed:@"SummerComplainDetailHeaderTableViewCell" owner:self options:nil].firstObject;
//        cell.delegate = self;
//    }
//    [cell confirmCellInformationWithData:self.complainModel withHeightHeaderView:headerViewHeight];
//
//    return cell;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    NSInteger integerRow = _arraryData.count;
    return integerRow;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CGFloat rectHeight = [Util getHeightForString:_complainModel.content width:SCREENSIZE.width - 50 font:[UIFont systemFontOfSize:13]];
        if ([_complainModel.pictures isEqual:[NSNull null]]) {
            return 61 + rectHeight;
        }
        headerViewHeight = 80 + (_complainModel.pictures.count/4 + 1) * (40 + 5) + rectHeight;
        return headerViewHeight;
    }
    TextDeal *noticModel = _arraryData[indexPath.row];
    CGFloat heightCell = [Util getHeightForString:noticModel.content width:SCREENSIZE.width - 70 font:[UIFont systemFontOfSize:13]];
    
    if ([noticModel.pictures isEqual:[NSNull null]]) {
        return 54 + heightCell;
    }
    if ([noticModel.pictures count] == 0) {
        return 54 + heightCell;
    }else{
        return 54 + heightCell + ([noticModel.pictures count]/4 + 1) * 45.0;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        SummerComplainDetailHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellheaderdetail"];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"SummerComplainDetailHeaderTableViewCell" owner:self options:nil].firstObject;
            cell.delegate = self;
        }
        [cell confirmCellInformationWithData:self.complainModel withHeightHeaderView:headerViewHeight];
        
        return cell;
    }
    SummerComplainDetailHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellItem" forIndexPath:indexPath];
    cell.delegate = self;
    [cell confirmCellCompliteDetailWithData:_arraryData[indexPath.row]];
    
    return cell;
}

- (void)selectDetailHeaderCellImageView:(id)sender{
    [self.photos removeAllObjects];
    UIImageView *imgView = (UIImageView *)sender;
    NSIndexPath *index = [_mTableView indexPathForCell:(UITableViewCell *)[[sender superview] superview]];
    TextDeal *detailModel;
    if (index.section == 0) {
        detailModel = _complainModel;
    }else{
        detailModel = _arraryData[index.row];
    }
    if (!self.photos) {
        [self.photos removeAllObjects];
    }
    for (int i = 0; i< [detailModel.pictures count]; i++) {
        MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:detailModel.pictures[i]]];
        [self.photos addObject:photo];
    }
    // Create browser
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser = [Util fullImageSetting:browser];
    
    browser.displayActionButton = NO;
    [browser setCurrentPhotoIndex:imgView.tag - 1];
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
    if (self.summerInputView.summerInputView.text.length < 1 && self.chosenImages.count < 1) {
        [self showHint:@"发送内容或者图片，不能都为空"];
        return;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"上传中";
    hud.dimBackground = YES;
    [hud hide:YES afterDelay:50];
    
    if (self.summerInputView.summerInputView.text.length > 1 && self.chosenImages.count < 1) {
        //文字
        [Networking retrieveData:get_reply_complaint parameters:@{@"token": [User getUserToken],@"id":_strDetailID,@"content":self.summerInputView.summerInputView.text} success:^(id responseObject) {
            [hud removeFromSuperview];
            [self showHint:@"评论成功"];
            self.summerInputView.summerInputView.text = nil;
            [self getComplaintDetail];
        }];
    }else if(self.summerInputView.summerInputView.text.length < 1 && self.chosenImages.count > 0){
        //图片
        [Networking upload:self.chosenImages success:^(id responseObject) {
            [Networking retrieveData:get_reply_complaint parameters:@{@"token": [User getUserToken],@"id":_strDetailID,@"pictures":responseObject} success:^(id responseObject) {
                [hud removeFromSuperview];
                [self showHint:@"评论成功"];
                self.summerInputView.summerInputLabNumbers.hidden = YES;
                self.summerInputView.summerInputView.text = nil;
                [self getComplaintDetail];
            }];
        }];
    }else{
        //图片，文字
        [Networking upload:self.chosenImages success:^(id responseObject) {
            [Networking retrieveData:get_reply_complaint parameters:@{@"token": [User getUserToken],
                                                                      @"id":_strDetailID,
                                                                      @"content":self.summerInputView.summerInputView.text,
                                                                      @"pictures":responseObject} success:^(id responseObject) {
                                                                          [hud removeFromSuperview];
                                                                          [self showHint:@"评论成功"];
                                                                          self.summerInputView.summerInputLabNumbers.text = 0;
                                                                          self.summerInputView.summerInputLabNumbers.hidden = YES;
                                                                          self.summerInputView.summerInputView.text = nil;
                                                                          [self getComplaintDetail];
                                                                      }];
        }];
    }
    
}

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
