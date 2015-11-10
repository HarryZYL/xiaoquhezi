//
//  SummerMoreReplayViewController.m
//  WeCommunity
//
//  Created by madarax on 15/11/9.
//  Copyright © 2015年 Harry. All rights reserved.
//
#import "UIViewController+HUD.h"
#import "SummerNoticeDetailTableViewCell.h"
#import "SummerMoreReplayViewController.h"
#import "SummerNoticeMoreReplysTableViewCell.h"
#import "SummerNoticeMoreReplysRowTableViewCell.h"

@interface SummerMoreReplayViewController ()
{
    NSInteger pageNumber;
}
@property (nonatomic ,strong)NSMutableArray *arraryData;
@end

@implementation SummerMoreReplayViewController
#define IMPUT_VIEW_HEIGHT 40
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"更多回复";
    pageNumber = 1;
    _arraryData = [[NSMutableArray alloc] init];
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, SCREENSIZE.height - IMPUT_VIEW_HEIGHT) style:UITableViewStyleGrouped];
    
    _mTableView.dataSource = self;
    _mTableView.delegate   = self;
    self.summerInputView.summerInputView.delegate = self;
    [self.mTableView registerNib:[UINib nibWithNibName:@"SummerNoticeMoreReplysRowTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellItem"];
    _mTableView.tableFooterView = [[UIView alloc] init];
    
    [self.view addSubview:_mTableView];
    _summerInputView = [[SummerInputView alloc] initWithFrame:CGRectMake(0, SCREENSIZE.height - IMPUT_VIEW_HEIGHT, SCREENSIZE.width, IMPUT_VIEW_HEIGHT)];
    [self.view addSubview:_summerInputView];
    self.summerInputView.btnAddImg.hidden = YES;
    self.summerInputView.summerInputView.frame = CGRectMake(10, 5, SCREENSIZE.width - 88, 30);
    [self.summerInputView.btnSenderMessage addTarget:self action:@selector(btnSenderMessageWithAddImage:) forControlEvents:UIControlEventTouchUpInside];
    [self getReceveData];
}

- (void)getReceveData{
    if (_arraryData.count) {
        [_arraryData removeAllObjects];
    }
    
    __weak typeof(self)weakSelf = self;
    [Networking retrieveData:get_Reply_Replies parameters:@{@"replyId": _strID,@"page":[NSNumber numberWithInteger:pageNumber],@"row":@(30)} success:^(id responseObject) {
        
        for (NSDictionary *dic in responseObject[@"rows"]) {
            [weakSelf.arraryData addObject:[[SummerHomeDetailNoticeModel alloc] initWithData:dic]];
        }
        [weakSelf.mTableView reloadData];
    }];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat rectHeight = [Util getHeightForString:_detailNoticeModel.content width:SCREENSIZE.width - 50 font:[UIFont systemFontOfSize:15]];
    return 91 + rectHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SummerNoticeMoreReplysTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellHeaderView"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"SummerNoticeMoreReplysTableViewCell" owner:self options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.cellUserImage sd_setImageWithURL:_detailNoticeModel.creatorInFo.headPhoto placeholderImage:[UIImage imageNamed:@"loadingLogo"]];
    cell.cellTitleName.text = _detailNoticeModel.creatorInFo.nickName;
    cell.cellTimeLabe.text = [Util formattedDate:_detailNoticeModel.createTime type:1];
    cell.cellContenLab.text = _detailNoticeModel.content;
    [cell.cellCountNumber setTitle:[NSString stringWithFormat:@"%@",_detailNoticeModel.childrenCount] forState:UIControlStateNormal];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arraryData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SummerHomeDetailNoticeModel *dicTemp = _arraryData[indexPath.row];
    CGFloat heightCell = [Util getHeightForString:dicTemp.content width:SCREENSIZE.width - 70 font:[UIFont systemFontOfSize:15]];
    
    return 70 + heightCell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SummerNoticeMoreReplysRowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellItem" forIndexPath:indexPath];
    
    [cell confirmCellItemWithData:_arraryData[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _defaultNoticeModel = _arraryData[indexPath.row];
    if ([[User getAuthenticationOwnerType] isEqualToString:@"认证户主"] || [[User getAuthenticationOwnerType] isEqualToString:@"认证业主"]) {
    
        self.summerInputView.summerInputView.text = [NSString stringWithFormat:@"回复 %@",_defaultNoticeModel.creatorInFo.nickName];
        
        [self.summerInputView.summerInputView becomeFirstResponder];
    }else{
        [self showHint:@"认证后，才能评论"];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if (textView == self.summerInputView.summerInputView) {
        if (![[User getAuthenticationOwnerType] isEqualToString:@"认证户主"] && ![[User getAuthenticationOwnerType] isEqualToString:@"认证业主"]){
            [self showHint:@"认证后，才能评论"];
            [textView resignFirstResponder];
        }
    }
}

//发送信息
- (void)btnSenderMessageWithAddImage:(UIButton *)sender{
    [self.summerInputView.summerInputView resignFirstResponder];
    if ([[User getAuthenticationOwnerType] isEqualToString:@"认证户主"] || [[User getAuthenticationOwnerType] isEqualToString:@"认证业主"]) {
        if (_summerInputView.summerInputView.text.length < 1) {
            [self showHint:@"内容不能为空"];
            return;
        }else{
            [self senderRepalyNotices];
        }
    }else{
        self.summerInputView.summerInputLabNumbers.text = nil;
        self.summerInputView.summerInputView.text = nil;
        [self showHint:@"认证后，才能评论"];
    }
}

- (void)senderRepalyNotices{
    NSMutableDictionary *paramaga = [[NSMutableDictionary alloc] init];
    if (_defaultNoticeModel) {
        //发给section
        paramaga = (NSMutableDictionary *)@{@"token": [User getUserToken],@"noticeId":_strNoticeID,@"content":self.summerInputView.summerInputView.text,@"parentId":_defaultNoticeModel.objectID};
    }else{
        //发给cell
        paramaga = (NSMutableDictionary *)@{@"token": [User getUserToken],@"noticeId":_strNoticeID,@"content":self.summerInputView.summerInputView.text,@"parentId":_defaultNoticeModel.objectID};
    }
    [Networking retrieveData:GET_REPLY_TO_REPLY parameters:paramaga success:^(id responseObject) {
        _defaultNoticeModel = nil;
        self.summerInputView.summerInputView.text = nil;
        NSLog(@"--->%@",responseObject);
    }];
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
