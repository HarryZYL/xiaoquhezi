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

#define IMPUT_VIEW_HEIGHT 50
@interface SummerComplainViewController ()<UzysAssetsPickerControllerDelegate ,SummerComplainDetailHeaderTableViewCellDelegate ,MWPhotoBrowserDelegate>
{
    NSInteger numberPage;
    CGFloat headerViewHeight;
}
@property (nonatomic ,strong) NSMutableArray *chosenImages;
@property (nonatomic ,strong) NSMutableArray *arraryData;
@property (nonatomic ,strong) NSMutableArray *chosenSmallImages;
@property (nonatomic ,strong) NSMutableArray *photos;
@end

@implementation SummerComplainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"投诉详情";
    self.photos       = [[NSMutableArray alloc] init];
    self.arraryData   = [[NSMutableArray alloc] init];
    self.chosenImages = [[NSMutableArray alloc] init];
    self.chosenSmallImages = [[NSMutableArray alloc] init];
    numberPage        = 1;
    _mTableView       = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, SCREENSIZE.height - IMPUT_VIEW_HEIGHT) style:UITableViewStylePlain];
    
    _mTableView.dataSource = self;
    _mTableView.delegate   = self;
    self.mTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getComplaintDetail)];
    self.mTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];
    [self.mTableView registerNib:[UINib nibWithNibName:@"SummerComplainDetailHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellItem"];
    _mTableView.tableFooterView = [[UIView alloc] init];
    
    [self.view addSubview:_mTableView];
    _summerInputView = [[SummerInputView alloc] initWithFrame:CGRectMake(0, SCREENSIZE.height - IMPUT_VIEW_HEIGHT, SCREENSIZE.width, IMPUT_VIEW_HEIGHT)];
    [self.view addSubview:_summerInputView];
    
    [self.summerInputView.btnSenderMessage addTarget:self action:@selector(btnSenderMessageWithAddImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.summerInputView.btnAddImg addTarget:self action:@selector(btnSelectedImageViews:) forControlEvents:UIControlEventTouchUpInside];
    __weak typeof(self)weakSelf = self;
    self.summerInputView.btnAddImageViews = ^{
        [weakSelf btnSelectedImageViews:nil];
    };
    
    [self getReceveData];
    [self getComplaintDetail];
}

- (void)getComplaintDetail{
    __weak typeof(self)weakSelf = self;
    if (_arraryData.count) {
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
            [weakSelf.arraryData addObject:[[TextDeal alloc] initWithData:dicTemp textType:@"complaint"]];
        }
        if (numberPage * 30 > weakSelf.arraryData.count) {
            [weakSelf.mTableView.mj_footer endRefreshingWithNoMoreData];
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
                                                                [weakSelf.mTableView.mj_header endRefreshing];
//                                                                _complainModel = [[TextDeal alloc] initWithData:responseObject textType:@"complaint"];
                                                                [weakSelf.mTableView reloadData];
                                                            }];
}

#pragma mark - UITableViewDelegate

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
        CGFloat rectHeight = [Util getHeightForString:_complainModel.content width:SCREENSIZE.width - 80 font:[UIFont systemFontOfSize:15]];
        if ([_complainModel.pictures isEqual:[NSNull null]] || [_complainModel.pictures.firstObject length] < 5) {
            return 77 + rectHeight;
        }
        headerViewHeight = 70 + (_complainModel.pictures.count/3 + 1) * 80 + rectHeight;
        return headerViewHeight;
    }
    TextDeal *noticModel = _arraryData[indexPath.row];
    CGFloat heightCell = [Util getHeightForString:noticModel.content width:SCREENSIZE.width - 70 font:[UIFont systemFontOfSize:14]];
    
    if ([noticModel.pictures isEqual:[NSNull null]]) {
        return 54 + heightCell;
    }
    if ([noticModel.pictures count] == 0 || [noticModel.pictures.firstObject length] < 5) {
        return 54 + heightCell;
    }else if (noticModel.pictures.count > 1 && noticModel.pictures.count < 5){
        return 54 + heightCell + 90;
    }else if(noticModel.pictures.count > 4){
        return 54 + heightCell + ([noticModel.pictures count]/4) * 70.0 + 30;
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

- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index{
    [self.photos removeObjectAtIndex:index];
    [self.chosenImages removeObjectAtIndex:index];
    [self.chosenSmallImages removeObjectAtIndex:index];
    [self.summerInputView confirmsSelectImage:self.chosenSmallImages];
    if (self.chosenSmallImages.count < 1) {
        self.summerInputView.frame = CGRectMake(0, SCREENSIZE.height - IMPUT_VIEW_HEIGHT, SCREENSIZE.width, IMPUT_VIEW_HEIGHT);
        _mTableView.frame = CGRectMake(0, 0, SCREENSIZE.width, SCREENSIZE.height - IMPUT_VIEW_HEIGHT);
    }
    self.summerInputView.summerInputLabNumbers.text = [NSString stringWithFormat:@"%ld",self.chosenImages.count];
    if (self.chosenImages.count < 1) {
        self.summerInputView.summerInputLabNumbers.hidden = YES;
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    [photoBrowser reloadData];
}

#pragma mark - 输入框，选择图片资源

- (void)btnSelectedImageViews:(UIButton *)sender{
    __weak typeof(self)weakSelf = self;
    if (self.chosenImages.count == 8) {
        [weakSelf showHint:@"只能选择八张"];
        return;
    }
    if (self.chosenImages.count > 0 && sender) {
        return;
    }
    UzysAssetsPickerController *picker = [[UzysAssetsPickerController alloc] init];
    picker.delegate = self;
    picker.maximumNumberOfSelectionMedia = 8 - self.chosenImages.count;
    [self presentViewController:picker animated:YES completion:nil];
    
}

- (void)uzysAssetsPickerController:(UzysAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    __weak typeof(self)weakSelf = self;
    if([[assets[0] valueForProperty:@"ALAssetPropertyType"] isEqualToString:@"ALAssetTypePhoto"]) //Photo
    {
        [assets enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ALAsset *representation = obj;
            if (weakSelf.chosenImages.count >= 8) {
                [weakSelf showHint:@"只能选择八张图片"];
            }
            UIImage *img = [UIImage imageWithCGImage:representation.defaultRepresentation.fullResolutionImage
                                               scale:representation.defaultRepresentation.scale
                                         orientation:(UIImageOrientation)representation.defaultRepresentation.orientation];
            
            [weakSelf.chosenImages addObject:img];
            [weakSelf.chosenSmallImages addObject:[Util scaleToSize:img size:CGSizeMake(70, 70)]];
            if (idx==0 && self.chosenImages.count == 1) {
                
            }
            
        }];
        
    }
    //选择图片之后
    [self updatePhotoImages];
}

- (void)updatePhotoImages{
    if (self.chosenSmallImages.count < 1) {
        self.summerInputView.frame = CGRectMake(0, SCREENSIZE.height - IMPUT_VIEW_HEIGHT, SCREENSIZE.width, IMPUT_VIEW_HEIGHT);
        self.mTableView.frame = CGRectMake(0, 0, SCREENSIZE.width, SCREENSIZE.height - IMPUT_VIEW_HEIGHT);
    }else{
        self.summerInputView.summerInputLabNumbers.hidden = NO;
        self.summerInputView.summerInputLabNumbers.text = [NSString stringWithFormat:@"%ld",self.chosenImages.count];
        
        self.summerInputView.frame = CGRectMake(0, SCREENSIZE.height - IMPUT_VIEW_HEIGHT - 90, SCREENSIZE.width, IMPUT_VIEW_HEIGHT + 90);
        self.mTableView.frame = CGRectMake(0, 0, SCREENSIZE.width, SCREENSIZE.height - IMPUT_VIEW_HEIGHT - 90);
    }
    __weak typeof(self)weakSelf = self;
    [self.summerInputView confirmsSelectImage:self.chosenSmallImages];
    self.summerInputView.tapImageView = ^(NSInteger index){//查看图片
        [weakSelf returnTapImageViewTagIndex:index];
    };
}

- (void)returnTapImageViewTagIndex:(NSInteger)index{
    if (self.photos) {
        [self.photos removeAllObjects];
    }
    for (int i = 0; i<self.chosenImages.count; i++) {
        MWPhoto *photo = [MWPhoto photoWithImage:self.chosenImages[i]];
        [self.photos addObject:photo];
    }
    // Create browser
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser = [Util fullImageSetting:browser];
    browser.displayNavArrows = YES;
    [browser setCurrentPhotoIndex:index - 1];
    [self.navigationController pushViewController:browser animated:YES];
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
    __weak typeof(self)weakSelf = self;
    if (self.summerInputView.summerInputView.text.length > 1 && self.chosenImages.count < 1) {
        //文字
        [Networking retrieveData:get_reply_complaint parameters:@{@"token": [User getUserToken],@"id":_strDetailID,@"content":self.summerInputView.summerInputView.text} success:^(id responseObject) {
            [hud removeFromSuperview];
            [weakSelf showHint:@"评论成功"];
            weakSelf.summerInputView.summerInputView.text = nil;
            [weakSelf getComplaintDetail];
        }];
    }else if(self.summerInputView.summerInputView.text.length < 1 && self.chosenImages.count > 0){
        //图片
        [Networking upload:self.chosenImages success:^(id responseObject) {
            [Networking retrieveData:get_reply_complaint parameters:@{@"token": [User getUserToken],@"id":_strDetailID,@"pictures":responseObject} success:^(id responseObject) {
                [hud removeFromSuperview];
                [weakSelf showHint:@"评论成功"];
                [weakSelf.chosenImages removeAllObjects];
                [weakSelf.chosenSmallImages removeAllObjects];
                weakSelf.summerInputView.summerInputLabNumbers.hidden = YES;
                weakSelf.summerInputView.summerInputView.text = nil;
                [weakSelf summerKeybordViewWillHide:nil];
                [weakSelf getComplaintDetail];
            }];
        }];
    }else{
        //图片，文字
        [Networking upload:self.chosenImages success:^(id responseObject) {
            [weakSelf.chosenImages removeAllObjects];
            [weakSelf.chosenSmallImages removeAllObjects];
            [weakSelf summerKeybordViewWillHide:nil];
            [Networking retrieveData:get_reply_complaint parameters:@{@"token": [User getUserToken],
                                                                      @"id":_strDetailID,
                                                                      @"content":self.summerInputView.summerInputView.text,
                                                                      @"pictures":responseObject} success:^(id responseObject) {
                                                                          [hud removeFromSuperview];
                                                                          [weakSelf showHint:@"评论成功"];
                                                                          weakSelf.summerInputView.summerInputLabNumbers.text = 0;
                                                                          weakSelf.summerInputView.summerInputLabNumbers.hidden = YES;
                                                                          weakSelf.summerInputView.summerInputView.text = nil;
                                                                          [weakSelf getComplaintDetail];
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
    __weak typeof(self)weakSelf = self;
    NSTimeInterval animationDuration = [[[aNotificaiton userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:animationDuration animations:^{
        weakSelf.summerInputView.frame = CGRectMake(0, SCREENSIZE.height - IMPUT_VIEW_HEIGHT - rectKeybord.size.height, SCREENSIZE.width, IMPUT_VIEW_HEIGHT);
        weakSelf.mTableView.frame = CGRectMake(0, 0, SCREENSIZE.width, SCREENSIZE.height - IMPUT_VIEW_HEIGHT - rectKeybord.size.height);
        
    }];
}

- (void)summerKeybordViewWillHide:(NSNotification *)aNotification{
    __weak typeof(self)weakSelf = self;
    NSTimeInterval animationDuration = [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:animationDuration animations:^{
        if (weakSelf.chosenSmallImages.count < 1) {
            weakSelf.summerInputView.frame = CGRectMake(0, SCREENSIZE.height - IMPUT_VIEW_HEIGHT, SCREENSIZE.width, IMPUT_VIEW_HEIGHT);
            weakSelf.mTableView.frame = CGRectMake(0, 0, SCREENSIZE.width, SCREENSIZE.height - IMPUT_VIEW_HEIGHT);
        }else{
            weakSelf.summerInputView.frame = CGRectMake(0, SCREENSIZE.height - IMPUT_VIEW_HEIGHT - 90, SCREENSIZE.width, IMPUT_VIEW_HEIGHT + 90);
            weakSelf.mTableView.frame = CGRectMake(0, 0, SCREENSIZE.width, SCREENSIZE.height - IMPUT_VIEW_HEIGHT - 90);
        }
    }];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
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
