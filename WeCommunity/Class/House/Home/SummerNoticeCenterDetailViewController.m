//
//  SummerNoticeCenterDetailViewController.m
//  WeCommunity
//
//  Created by madarax on 15/11/3.
//  Copyright © 2015年 Harry. All rights reserved.
//
#import "NSString+HTML.h"
#import "SummerMoreReplayViewController.h"
#import "UIViewController+HUD.h"
#import "SummerHomeDetailNoticeModel.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "SummerNoticeCenterDetailViewController.h"
#import "SummerNoticeDetailReplaceTableViewCell.h"
#import "SummerNoticeDetailTableViewCell.h"

#define IMPUT_VIEW_HEIGHT 50
@interface SummerNoticeCenterDetailViewController ()<UzysAssetsPickerControllerDelegate,SummerNoticeDetailReplaceTableViewCellDelegate ,MWPhotoBrowserDelegate>
{
    NSInteger numberPage;
    NSMutableDictionary *dicNotice;
    
}
@property (nonatomic ,strong) NSMutableArray *chosenImages;     /**<选择的图片*/
@property (nonatomic ,strong) NSMutableArray *chosenSmallImages;/**<选择的小图*/
@property (nonatomic ,strong) NSMutableArray *arraryData;       /**<返回的评论数据*/
@property (nonatomic ,strong) NSMutableArray *photos;
@property (nonatomic ,strong) NSMutableArray *needLoadArr;

@end

@implementation SummerNoticeCenterDetailViewController

- (instancetype)init{
    if (self = [super init]) {
        _needLoadArr = [[NSMutableArray alloc] init];
        
        numberPage = 1;
        _photos = [[NSMutableArray alloc] init];
        dicNotice = [[NSMutableDictionary alloc] init];
        _arraryData = [[NSMutableArray alloc] init];
        self.chosenImages = [[NSMutableArray alloc] init];
        self.chosenSmallImages = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"公告详情";
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, SCREENSIZE.height - IMPUT_VIEW_HEIGHT) style:UITableViewStyleGrouped];
    self.mTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getReceveData)];
    self.mTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];

    _mTableView.dataSource = self;
    _mTableView.delegate   = self;
    
    [self.mTableView registerNib:[UINib nibWithNibName:@"SummerNoticeDetailReplaceTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellItem"];
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
    [self getTableViewHeaderData];
    
    [self getReceveData];
}

- (void)getTableViewHeaderData{
    __weak typeof(self)weakSelf = self;
    [Networking retrieveData:getNoticeDetail parameters:@{@"id": self.strNoticeID} success:^(id responseObject) {
        NSLog(@"----->%@",responseObject);
        dicNotice = responseObject;
        [weakSelf.mTableView reloadData];
    }];
}

- (void)refreshFooter{
    numberPage ++;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"加载中";
    [hud hide:YES afterDelay:5];
    __weak typeof(self) weakSelf = self;
    [Networking retrieveData:GET_NOTICE_REPLIS parameters:@{@"id": self.strNoticeID,
                                                            @"page":[NSNumber numberWithInteger:numberPage],
                                                            @"row":@"30"}success:^(id responseObject) {
                                                                [hud removeFromSuperview];
                                                                [weakSelf.mTableView.mj_footer endRefreshing];
                                                                NSMutableArray *arraryTemp = [[NSMutableArray alloc] init];
                                                                
                                                                for (NSDictionary *dicTemp in responseObject[@"rows"]) {
                                                                    if ([dicTemp[@"parentId"] isEqual:[NSNull null]]) {
                                                                        SummerNoticeCenterDetailModel *detail = [[SummerNoticeCenterDetailModel alloc] init];
                                                                        detail.detailNoticeModel = [[SummerHomeDetailNoticeModel alloc] initWithData:dicTemp];
                                                                        [weakSelf.arraryData addObject:detail];
                                                                    }else{
                                                                        SummerHomeDetailNoticeModel *detail = [[SummerHomeDetailNoticeModel alloc] init];
                                                                        detail = [[SummerHomeDetailNoticeModel alloc] initWithData:dicTemp];
                                                                        [arraryTemp addObject:detail];
                                                                    }
                                                                }
                                                                if (weakSelf.arraryData.count < numberPage * 30) {
                                                                    [weakSelf.mTableView.mj_footer endRefreshingWithNoMoreData];
                                                                }
                                                                for (int index = 0; index < [arraryTemp count]; index ++) {
                                                                    SummerHomeDetailNoticeModel *dicTemp = arraryTemp[index];
                                                                    
                                                                    if (![dicTemp.objectID isEqual:[NSNull null]]) {
                                                                        
                                                                        for (SummerNoticeCenterDetailModel *detailModel in _arraryData) {
                                                                            if ([detailModel.detailNoticeModel.objectID isEqualToString:dicTemp.parentId]) {
                                                                                [detailModel.detailReplyArrary addObject:dicTemp];
                                                                            }
                                                                        }
                                                                        
                                                                    }
                                                                    
                                                                }
                                                                
                                                                [self.summerInputView.summerInputView resignFirstResponder];
                                                                self.summerInputView.summerInputView.text = @"";
                                                                self.summerInputView.btnAddImg.hidden = NO;
//                                                                self.summerInputView.summerInputView.frame = CGRectMake(44, 5, SCREENSIZE.width - 88, 30);
                                                                _identifyNotice = nil;
                                                                [weakSelf.mTableView reloadData];
                                                            }];
}

- (void)getReceveData{
//    if (_arraryData.count) {
//        [_arraryData removeAllObjects];
//    }
    numberPage = 1;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"加载中";
    [hud hide:YES afterDelay:5];
    __weak typeof(self) weakSelf = self;
    [Networking retrieveData:GET_NOTICE_REPLIS parameters:@{@"id": self.strNoticeID,
                                                            @"page":[NSNumber numberWithInteger:numberPage],
                                                            @"row":@"30"}success:^(id responseObject) {
        [weakSelf.mTableView.mj_header endRefreshing];
        [hud removeFromSuperview];
        [weakSelf.arraryData removeAllObjects];
                                                                
        NSMutableArray *arraryTemp = [[NSMutableArray alloc] init];
        for (NSDictionary *dicTemp in responseObject[@"rows"]) {
            if ([dicTemp[@"parentId"] isEqual:[NSNull null]]) {
                SummerNoticeCenterDetailModel *detail = [[SummerNoticeCenterDetailModel alloc] init];
                detail.detailNoticeModel = [[SummerHomeDetailNoticeModel alloc] initWithData:dicTemp];
                [weakSelf.arraryData addObject:detail];
            }else{
                SummerHomeDetailNoticeModel *detail = [[SummerHomeDetailNoticeModel alloc] init];
                detail = [[SummerHomeDetailNoticeModel alloc] initWithData:dicTemp];
                [arraryTemp addObject:detail];
            }
        }
                    
        for (int index = 0; index < [arraryTemp count]; index ++) {
            SummerHomeDetailNoticeModel *dicTemp = arraryTemp[index];
            
            if (![dicTemp.objectID isEqual:[NSNull null]]) {
                
                for (SummerNoticeCenterDetailModel *detailModel in _arraryData) {
                    if ([detailModel.detailNoticeModel.objectID isEqualToString:dicTemp.parentId]) {
                        [detailModel.detailReplyArrary addObject:dicTemp];
                    }
                }
                
            }
            
        }
        
        [self.summerInputView.summerInputView resignFirstResponder];
        self.summerInputView.summerInputView.text = @"";
        self.summerInputView.btnAddImg.hidden = NO;
//        self.summerInputView.summerInputView.frame = CGRectMake(44, 5, SCREENSIZE.width - 88, 30);
        _identifyNotice = nil;
        [weakSelf.mTableView reloadData];
    }];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat rectHeight = [Util getHeightForString:_detailNotice.contentTxt width:SCREENSIZE.width - 50 font:[UIFont systemFontOfSize:15]];
    return rectHeight + 450;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SummerNoticeDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellnoticecenterdetail"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"SummerNoticeDetailTableViewCell" owner:self options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.cellTitleImg sd_setImageWithURL:self.detailNotice.creatorInfo.headPhoto placeholderImage:[UIImage imageNamed:@"loadingLogo"]];
    cell.cellLabTitle.text = self.detailNotice.title;
    cell.cellLabTime.text  = self.detailNotice.createTime;
    
    if ([self.detailNotice.isTop boolValue]) {
        cell.cellLabTop.text = @"置顶公告";
    }else{
        cell.cellLabTop.text = nil;
    }
    if (self.detailNotice.replyCount.intValue == 0) {
        cell.cellLabReplay.text = @"暂无评论";
    }else{
        cell.cellLabReplay.text  = [NSString stringWithFormat:@"评论 %@",self.detailNotice.replyCount];
    }
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithData:[dicNotice[@"content"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    [attrStr addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} range:NSMakeRange(0, attrStr.length - 1)];
    cell.cellLabContent.attributedText = attrStr;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arraryData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!_arraryData) {
        return 0;
    }
    SummerNoticeCenterDetailModel *noticModel = _arraryData[indexPath.row];
    CGFloat heightCell = [Util getHeightForString:noticModel.detailNoticeModel.content width:SCREENSIZE.width - 80 font:[UIFont systemFontOfSize:15]] + 17 + 10;
    if (noticModel.detailNoticeModel.childrenCount.integerValue <= 0) {
        heightCell -= 9;
    }
    if (noticModel.detailNoticeModel.childrenCount.integerValue <= 2) {
        for(NSInteger index = 0;index < noticModel.detailReplyArrary.count;index ++){
            SummerHomeDetailNoticeModel *noticeDetail = noticModel.detailReplyArrary[index];
            NSString *strTemp;
            if (![noticeDetail.creatorInFo.nickName isEqual:[NSNull null]]) {
                strTemp = [NSString stringWithFormat:@"%@：%@  %@",noticeDetail.creatorInFo.nickName,noticeDetail.content,[Util formattedDate:noticeDetail.createTime type:5]];
            }else{
                strTemp = [NSString stringWithFormat:@"%@：%@  %@",noticeDetail.creatorInFo.userName,noticeDetail.content,[Util formattedDate:noticeDetail.createTime type:5]];
            }
            heightCell += [Util getHeightForString:strTemp width:SCREENSIZE.width - 80 font:[UIFont systemFontOfSize:15]] + 8;
        }

    }else{
        for(NSInteger index = 0;index < 2;index ++){
            SummerHomeDetailNoticeModel *noticeDetail = noticModel.detailReplyArrary[index];
            NSString *strTemp;
            if (![noticeDetail.creatorInFo.nickName isEqual:[NSNull null]]) {
                strTemp = [NSString stringWithFormat:@"%@：%@  %@",noticeDetail.creatorInFo.nickName,noticeDetail.content,[Util formattedDate:noticeDetail.createTime type:5]];
            }else{
                strTemp = [NSString stringWithFormat:@"%@：%@  %@",noticeDetail.creatorInFo.userName,noticeDetail.content,[Util formattedDate:noticeDetail.createTime type:5]];
            }
            heightCell += [Util getHeightForString:strTemp width:SCREENSIZE.width - 70 font:[UIFont systemFontOfSize:15]] + 4;
        }
        heightCell += 25 + 10;
    }
    if (![noticModel.detailNoticeModel.pictures isEqual:[NSNull null]]) {
        if ([noticModel.detailNoticeModel.pictures.firstObject length] > 0) {
            heightCell += 70 + 8;
        }
    }
    return heightCell + 33;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SummerNoticeDetailReplaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellItem" forIndexPath:indexPath];
    cell.delegate = self;

    [cell confirmCellInformationWithData:_arraryData[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SummerNoticeCenterDetailModel *detailNotice = _arraryData[indexPath.row];
    _identifyNotice = detailNotice.detailNoticeModel;
    if ([[User getAuthenticationOwnerType] isEqualToString:@"认证户主"] || [[User getAuthenticationOwnerType] isEqualToString:@"认证业主"]) {
        self.summerInputView.summerInputView.text = [NSString stringWithFormat:@"回复 %@",_identifyNotice.creatorInFo.nickName];
        self.summerInputView.btnAddImg.hidden = YES;
//        self.summerInputView.summerInputView.frame = CGRectMake(10, 5, SCREENSIZE.width - 88, 30);
        [self.summerInputView.summerInputView becomeFirstResponder];
    }else{
        [self showHint:@"认证后，才能评论"];
    }
    
    
}

- (void)summerNoticeDetailMoreClickWithData:(id)viewModel{
    UIView *viewDetailModel = (UIView *)viewModel;
    if (viewDetailModel.tag == 12) {
        //更多回复
        
       NSIndexPath *index = [_mTableView indexPathForCell:(SummerNoticeDetailReplaceTableViewCell *)[[viewDetailModel superview] superview]];
//        NSLog(@"------>%d",index.row);
        SummerNoticeCenterDetailModel *detailModel = _arraryData[index.row];
        SummerMoreReplayViewController *replyMoreVC = [[SummerMoreReplayViewController alloc] init];
        replyMoreVC.strNoticeID = self.strNoticeID;
        replyMoreVC.strID = detailModel.detailNoticeModel.objectID;
        replyMoreVC.detailNoticeModel = detailModel.detailNoticeModel;
        [self.navigationController pushViewController:replyMoreVC animated:YES];
    }else{
        //子回复
        
    }
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
    if([[assets[0] valueForProperty:@"ALAssetPropertyType"] isEqualToString:@"ALAssetTypePhoto"]) //Photo
    {
        [assets enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ALAsset *representation = obj;
            UIImage *img = [UIImage imageWithCGImage:representation.defaultRepresentation.fullResolutionImage
                                               scale:representation.defaultRepresentation.scale
                                         orientation:(UIImageOrientation)representation.defaultRepresentation.orientation];
            
            [self.chosenImages addObject:[Util scaleToSize:img size:CGSizeMake(800, 800)]];
            [self.chosenSmallImages addObject:[Util scaleToSize:img size:CGSizeMake(70, 70)]];
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

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count)
        return [self.photos objectAtIndex:index];
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

//发送信息
- (void)btnSenderMessageWithAddImage:(UIButton *)sender{
    NSLog(@"123---%@",self.summerInputView.summerInputView.text);
    if ([[User getAuthenticationOwnerType] isEqualToString:@"认证户主"] || [[User getAuthenticationOwnerType] isEqualToString:@"认证业主"]) {
//        self.summerInputView.btnSenderMessage.enabled = NO;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"上传中";
        hud.dimBackground = YES;
        [hud hide:YES afterDelay:5];
        if (!_identifyNotice) {
            [self senderPostNoticeReplayWith:hud];
        }else{
            [self senderPostReplyToReplyWith:hud];
        }
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
    if (self.chosenImages.count < 1) {
        [Networking retrieveData:get_reply_notice parameters:@{@"token": [User getUserToken],
                                                               @"id":_detailNotice.Objectid,
                                                               @"content":self.summerInputView.summerInputView.text} success:^(id responseObject) {
                                                                   //                                                                   返回NoticeReply
                                                                   [hud removeFromSuperview];
                                                                   [self showHint:@"评论成功"];
                                                                   self.summerInputView.summerInputLabNumbers.text = 0;
//                                                                   self.summerInputView.btnSenderMessage.enabled = NO;
                                                                   self.summerInputView.summerInputView.text = nil;
                                                                   [self getReceveData];
                                                               }];
    }else{
        
        [Networking upload:self.chosenImages success:^(id responseObject) {
            [Networking retrieveData:get_reply_notice parameters:@{@"token": [User getUserToken],
                                                                   @"id":_detailNotice.Objectid,
                                                                   @"content":self.summerInputView.summerInputView.text,
                                                                   @"pictures":responseObject} success:^(id responseObject) {
                                                                       // 发送成功NoticeReply
                                                                       [hud removeFromSuperview];
                                                                       
                                                                       [weakSelf showHint:@"评论成功"];
                                                                       [weakSelf.chosenImages removeAllObjects];
                                                                       [weakSelf.chosenSmallImages removeAllObjects];
                                                                       [weakSelf.photos removeAllObjects];
                                                                       weakSelf.summerInputView.summerInputLabNumbers.hidden = YES;
                                                                       weakSelf.summerInputView.summerInputLabNumbers.text = 0;
                                                                       weakSelf.summerInputView.summerInputView.text = nil;
                                                                       [weakSelf summerKeybordViewWillHide:nil];
                                                                       [weakSelf getReceveData];
                                                                   }];
        }];
    }

}

- (void)senderPostReplyToReplyWith:(MBProgressHUD *)hud{
    [Networking retrieveData:GET_REPLY_TO_REPLY parameters:@{@"token": [User getUserToken],
                                                             @"noticeId":_strNoticeID,
                                                             @"content":self.summerInputView.summerInputView.text,
                                                             @"parentId":_identifyNotice.objectID,
                                                             } success:^(id responseObject) {
                                                                 [self getReceveData];
                                                             }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    __weak typeof(self)weakSelf = self;
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
