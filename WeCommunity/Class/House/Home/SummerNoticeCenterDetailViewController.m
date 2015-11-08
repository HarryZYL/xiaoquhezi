//
//  SummerNoticeCenterDetailViewController.m
//  WeCommunity
//
//  Created by madarax on 15/11/3.
//  Copyright © 2015年 Harry. All rights reserved.
//
#import "NSString+HTML.h"

#import "UIViewController+HUD.h"
#import "SummerHomeDetailNoticeModel.h"
#import "SummerNoticeCenterDetailViewController.h"
#import "SummerNoticeDetailReplaceTableViewCell.h"
#import "SummerNoticeDetailTableViewCell.h"

#define IMPUT_VIEW_HEIGHT 40
@interface SummerNoticeCenterDetailViewController ()<UzysAssetsPickerControllerDelegate>
{
    NSInteger numberPage;
    NSMutableDictionary *dicNotice;
}
@property (nonatomic ,strong) NSMutableArray *chosenImages;
@property (nonatomic ,strong) NSMutableArray *arraryData;
@end

@implementation SummerNoticeCenterDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"公告详情";
    numberPage = 1;
    dicNotice = [[NSMutableDictionary alloc] init];
    self.arraryData = [[NSMutableArray alloc] init];
    self.chosenImages = [[NSMutableArray alloc] init];
    
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, SCREENSIZE.height - IMPUT_VIEW_HEIGHT) style:UITableViewStyleGrouped];
    
    _mTableView.dataSource = self;
    _mTableView.delegate   = self;
    
    [self.mTableView registerNib:[UINib nibWithNibName:@"SummerNoticeDetailReplaceTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellItem"];
    _mTableView.tableFooterView = [[UIView alloc] init];
    
    [self.view addSubview:_mTableView];
    _summerInputView = [[SummerInputView alloc] initWithFrame:CGRectMake(0, SCREENSIZE.height - IMPUT_VIEW_HEIGHT, SCREENSIZE.width, IMPUT_VIEW_HEIGHT)];
    [self.view addSubview:_summerInputView];
    
    [self.summerInputView.btnSenderMessage addTarget:self action:@selector(btnSenderMessageWithAddImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.summerInputView.btnAddImg addTarget:self action:@selector(btnSelectedImageViews:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self getReceveData];
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
    [Networking retrieveData:GET_NOTICE_REPLIS parameters:@{@"id": self.strNoticeID,
                                                            @"page":[NSNumber numberWithInteger:numberPage],
                                                            @"row":@"30"}success:^(id responseObject) {
                                                                [hud removeFromSuperview];
                                                                for (NSDictionary *dicTemp in responseObject[@"rows"]) {
                                                                    [_arraryData addObject:[[SummerHomeDetailNoticeModel alloc] initWithData:dicTemp]];
                                                                }
        [weakSelf.mTableView reloadData];
    }];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat rectHeight = [Util getHeightForString:_detailNotice.contentTxt width:SCREENSIZE.width - 50 font:[UIFont systemFontOfSize:13]];
    return rectHeight + 61;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SummerNoticeDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellnoticecenterdetail"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"SummerNoticeDetailTableViewCell" owner:self options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.cellTitleImg sd_setImageWithURL:self.detailNotice.creatorInfo.headPhoto placeholderImage:[UIImage imageNamed:@"loadingLogo"]];
    cell.cellLabTitle.text = self.detailNotice.title;
    cell.cellLabTime.text = self.detailNotice.createTime;
    
    if (self.detailNotice.isTop.boolValue) {
        cell.cellLabTop.text = @"置顶公告";
    }else{
        cell.cellLabTop.text = nil;
    }
    if (self.detailNotice.replyCount.intValue == 0) {
        cell.cellLabReplay.text = @"暂无评论";
    }else{
        cell.cellLabReplay.text  = [NSString stringWithFormat:@"%@",self.detailNotice.replyCount];
    }
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithData:[self.detailNotice.contentTxt dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    
    cell.cellLabContent.attributedText = attrStr;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger integerRow = _arraryData.count;
    return integerRow;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SummerHomeDetailNoticeModel *noticModel = _arraryData[indexPath.row];
    CGFloat heightCell = [noticModel.content boundingRectWithSize:CGSizeMake(SCREENSIZE.width - 50, 2000) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]} context:nil].size.height;
    if ([noticModel.pictures isEqual:[NSNull null]]) {
        return 64 + heightCell;
    }
    if ([noticModel.pictures count] == 0) {
        return 64 + heightCell;
    }else{
        return 64 + heightCell + ([noticModel.pictures count]/4 + 1) * 45.0;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SummerNoticeDetailReplaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellItem" forIndexPath:indexPath];
    [cell confirmCellInformationWithData:_arraryData[indexPath.row]];
    return cell;
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
    NSLog(@"123---%@",self.summerInputView.summerInputView.text);
//    self.summerInputView.btnSenderMessage.user
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"上传中";
    hud.dimBackground = YES;
    [hud hide:YES afterDelay:5];
    
    if (self.chosenImages.count < 1) {
        [Networking retrieveData:get_reply_notice parameters:@{@"token": [User getUserToken],
                                                               @"id":_detailNotice.Objectid,
                                                               @"content":self.summerInputView.summerInputView.text} success:^(id responseObject) {
//                                                                   返回NoticeReply
                                                                   [hud removeFromSuperview];
                                                                   [self showHint:@"评论成功"];
                                                                   self.summerInputView.summerInputLabNumbers.text = 0;
                                                                   
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
                                                                       
                                                                       [self showHint:@"评论成功"];
                                                                       [self.chosenImages removeAllObjects];
                                                                       self.summerInputView.summerInputLabNumbers.hidden = YES;
                                                                       self.summerInputView.summerInputLabNumbers.text = 0;
                                                                       self.summerInputView.summerInputView.text = nil;
                                                                       
                                                                       [self getReceveData];
                                                                   }];
        }];
    }
    
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

//- (UITableView *)mTableView{
//    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, SCREENSIZE.height - IMPUT_VIEW_HEIGHT - 64) style:UITableViewStylePlain];
//    _mTableView.dataSource = self;
//    _mTableView.delegate   = self;
//   [self.mTableView registerClass:[SummerNoticeDetailReplaceTableViewCell class] forCellReuseIdentifier:@"cellItem"];
//    _mTableView.tableFooterView = [[UIView alloc] init];
//    return _mTableView;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
