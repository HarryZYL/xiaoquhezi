//
//  SummerNoticeCenterDetailViewController.m
//  WeCommunity
//
//  Created by madarax on 15/11/3.
//  Copyright © 2015年 Harry. All rights reserved.
//
#import "NSString+HTML.h"
#import "UIViewController+HUD.h"
#import "SummerNoticeCenterDetailViewController.h"
#import "SummerNoticeDetailReplaceTableViewCell.h"
#import "SummerNoticeDetailTableViewCell.h"

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
    numberPage = 1;
    dicNotice = [[NSMutableDictionary alloc] init];
    self.arraryData = [[NSMutableArray alloc] init];
    self.chosenImages = [[NSMutableArray alloc] init];
    [self.summerInputView.btnSenderMessage addTarget:self action:@selector(btnSenderMessageWithAddImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.summerInputView.btnAddImg addTarget:self action:@selector(btnSelectedImageViews:) forControlEvents:UIControlEventTouchUpInside];
    [self.mTableView registerNib:[UINib nibWithNibName:@"SummerNoticeDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellnoticecenterdetail"];
    [self.mTableView reloadData];
    [self getReceveData];
}

- (void)getReceveData{
    [_arraryData removeAllObjects];
    __weak typeof(self) weakSelf = self;
    [Networking retrieveData:GET_NOTICE_REPLIS parameters:@{@"id": self.strNoticeID,
                                                            @"page":[NSNumber numberWithInteger:numberPage],
                                                            @"row":@"30"}success:^(id responseObject) {
        _arraryData = responseObject[@"rows"];
        [weakSelf.mTableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arraryData.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        CGRect rectHeight = [_detailNotice.contentTxt boundingRectWithSize:CGSizeMake(SCREENSIZE.width - 50, 2000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading |NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13]} context:nil];
        return ceilf(rectHeight.size.height) + 61;
    }else{
        NSDictionary *dicTemp = _arraryData[indexPath.row - 1];
        CGFloat heightCell = [dicTemp[@"content"] boundingRectWithSize:CGSizeMake(SCREENSIZE.width - 50, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]} context:nil].size.height;
        if ([dicTemp[@"pictures"] isEqual:[NSNull null]]) {
            return 64 + heightCell;
        }
        if ([dicTemp[@"pictures"] count] == 0) {
            return 64 + heightCell;
        }else{
            return heightCell + ([dicTemp[@"pictures"] count]/4 + 1) * 40.0;
        }
        
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        SummerNoticeDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellnoticecenterdetail"];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"SummerNoticeDetailTableViewCell" owner:self options:nil].firstObject;
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
    }else{
        SummerNoticeDetailReplaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellItem"];
        if (!cell) {
            cell = [[SummerNoticeDetailReplaceTableViewCell alloc] init];
        }
        [cell confirmCellInformationWithData:_arraryData[indexPath.row - 1]];
        return cell;
    }
    
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
        self.summerInputView.summerInputLabNumbers.text = [NSString stringWithFormat:@"%d",self.chosenImages.count];
    }
}

//发送信息
- (void)btnSenderMessageWithAddImage:(UIButton *)sender{
    NSLog(@"123---%@",self.summerInputView.summerInputView.text);
    if (self.chosenImages.count < 1) {
        [Networking retrieveData:get_reply_notice parameters:@{@"token": [User getUserToken],
                                                               @"id":_detailNotice.Objectid,
                                                               @"content":self.summerInputView.summerInputView.text} success:^(id responseObject) {
//                                                                   返回NoticeReply
                                                               }];
    }else{
        [Networking upload:self.chosenImages success:^(id responseObject) {
            [Networking retrieveData:get_reply_notice parameters:@{@"token": [User getUserToken],
                                                                   @"id":_detailNotice.Objectid,
                                                                   @"content":self.summerInputView.summerInputView.text,
                                                                   @"pictures":responseObject} success:^(id responseObject) {
                                                                       // 发送成功NoticeReply
                                                                       
                                                                   }];
        }];
    }
    
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
