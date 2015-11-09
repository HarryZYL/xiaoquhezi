//
//  SummerMoreReplayViewController.m
//  WeCommunity
//
//  Created by madarax on 15/11/9.
//  Copyright © 2015年 Harry. All rights reserved.
//
#import "SummerNoticeDetailTableViewCell.h"
#import "SummerMoreReplayViewController.h"

@interface SummerMoreReplayViewController ()

@end

@implementation SummerMoreReplayViewController
#define IMPUT_VIEW_HEIGHT 40
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"更多回复";
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, SCREENSIZE.height - IMPUT_VIEW_HEIGHT) style:UITableViewStyleGrouped];
    
    _mTableView.dataSource = self;
    _mTableView.delegate   = self;
    
    [self.mTableView registerNib:[UINib nibWithNibName:@"SummerNoticeDetailReplaceTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellItem"];
    _mTableView.tableFooterView = [[UIView alloc] init];
    
    [self.view addSubview:_mTableView];
    _summerInputView = [[SummerInputView alloc] initWithFrame:CGRectMake(0, SCREENSIZE.height - IMPUT_VIEW_HEIGHT, SCREENSIZE.width, IMPUT_VIEW_HEIGHT)];
    [self.view addSubview:_summerInputView];
    
    [self.summerInputView.btnSenderMessage addTarget:self action:@selector(btnSenderMessageWithAddImage:) forControlEvents:UIControlEventTouchUpInside];
//    [self.summerInputView.btnAddImg addTarget:self action:@selector(btnSelectedImageViews:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    CGFloat rectHeight = [Util getHeightForString:dicNotice[@"content"] width:SCREENSIZE.width - 50 font:[UIFont systemFontOfSize:15]];
    return 61;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SummerNoticeDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellnoticecenterdetail"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"SummerNoticeDetailTableViewCell" owner:self options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
//    [cell.cellTitleImg sd_setImageWithURL:self.detailNotice.creatorInfo.headPhoto placeholderImage:[UIImage imageNamed:@"loadingLogo"]];
//    cell.cellLabTitle.text = self.detailNotice.title;
//    cell.cellLabTime.text  = self.detailNotice.createTime;
//    
//    if ([self.detailNotice.isTop boolValue]) {
//        cell.cellLabTop.text = @"置顶公告";
//    }else{
//        cell.cellLabTop.text = nil;
//    }
//    if (self.detailNotice.replyCount.intValue == 0) {
//        cell.cellLabReplay.text = @"暂无评论";
//    }else{
//        cell.cellLabReplay.text  = [NSString stringWithFormat:@"%@",self.detailNotice.replyCount];
//    }
//    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithData:[dicNotice[@"content"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
//    cell.cellLabContent.attributedText = attrStr;
    return cell;
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return _arraryData.count;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    SummerNoticeCenterDetailModel *noticModel = _arraryData[indexPath.row];
//    CGFloat heightCell = [noticModel.detailNoticeModel.content boundingRectWithSize:CGSizeMake(SCREENSIZE.width - 50, 2000) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]} context:nil].size.height;
//    
//    if (noticModel.detailNoticeModel.childrenCount.intValue > 0 && noticModel.detailNoticeModel.childrenCount.intValue < 3) {
//        heightCell += 15 * (noticModel.detailNoticeModel.childrenCount.intValue + 1);
//    }else if(noticModel.detailNoticeModel.childrenCount.intValue > 3){
//        heightCell += 50;
//    }
//    
//    if ([noticModel.detailNoticeModel.pictures isEqual:[NSNull null]]) {
//        return 90 + heightCell;
//    }
//    if ([noticModel.detailNoticeModel.pictures count] == 0) {
//        return 90 + heightCell;
//    }else{
//        return 90 + heightCell + ([noticModel.detailNoticeModel.pictures count]/4 + 1) * 45.0;
//    }
//    return 0;
//}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    SummerNoticeDetailReplaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellItem" forIndexPath:indexPath];
//    cell.delegate = self;
//    [cell confirmCellInformationWithData:_arraryData[indexPath.row]];
//    return cell;
//}

//发送信息
- (void)btnSenderMessageWithAddImage:(UIButton *)sender{
    
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
