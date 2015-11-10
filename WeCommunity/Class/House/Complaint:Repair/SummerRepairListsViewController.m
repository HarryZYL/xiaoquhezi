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

@interface SummerRepairListsViewController ()<UzysAssetsPickerControllerDelegate>
{
    NSInteger pageNumber;
}
@property (nonatomic ,strong)NSMutableArray *chosenImages;
@property (nonatomic ,strong)NSMutableArray *arraryData;

@end

@implementation SummerRepairListsViewController
#define IMPUT_VIEW_HEIGHT 40
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"报修单";
    pageNumber = 1;
    self.chosenImages = [[NSMutableArray alloc] init];
    
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, SCREENSIZE.height - IMPUT_VIEW_HEIGHT) style:UITableViewStyleGrouped];
    
    _mTableView.dataSource = self;
    _mTableView.delegate   = self;
    
    [self.mTableView registerNib:[UINib nibWithNibName:@"SummerRepairListsRepairCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellItem"];
    _mTableView.tableFooterView = [[UIView alloc] init];
    
    [self.view addSubview:_mTableView];
    _summerInputView = [[SummerInputView alloc] initWithFrame:CGRectMake(0, SCREENSIZE.height - IMPUT_VIEW_HEIGHT, SCREENSIZE.width, IMPUT_VIEW_HEIGHT)];
    [self.view addSubview:_summerInputView];
    
    [self.summerInputView.btnSenderMessage addTarget:self action:@selector(btnSenderMessageWithAddImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.summerInputView.btnAddImg addTarget:self action:@selector(btnSelectedImageViews:) forControlEvents:UIControlEventTouchUpInside];
    [self getReceveData];
}

- (void)getReceveData{
    __weak typeof(self)weakSelf = self;
    [Networking retrieveData:GET_REPLISE parameters:@{@"token": [User getUserToken],@"id":_detailTextModel.Objectid,@"page":[NSNumber numberWithInteger:pageNumber],@"row":@"30"} success:^(id responseObject) {
        weakSelf.arraryData = responseObject[@"rows"];
        [weakSelf.mTableView reloadData];
        NSLog(@"---->%@",responseObject);
    }];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat contentHeight = [Util getHeightForString:[_detailTextModel.content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] width:SCREENSIZE.width - 20 font:[UIFont systemFontOfSize:15]];
    
    if (![_detailTextModel.pictures isEqual:[NSNull null]]) {
        if (_detailTextModel.pictures.count > 0) {
            if (_detailTextModel.pictures.count > 4) {
                contentHeight = 100 + 60;
            }else{
                contentHeight = 120;
            }
        }
    }
    
    return contentHeight + 200;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SummerRepairListsHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellnoticecenterdetail"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"SummerRepairListsHeaderTableViewCell" owner:self options:nil].firstObject;
    }
    [cell confirmTableViewHeaderViewWithData:_detailTextModel];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arraryData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dicTemp = _arraryData[indexPath.row];
    CGFloat heightCell = 40 + [Util getHeightForString:dicTemp[@"content"] width:SCREENSIZE.width - 70 font:[UIFont systemFontOfSize:14]];
    if ([dicTemp[@"pictures"] isEqual:[NSNull null]]) {
        return heightCell + 10;
    }else{
        NSArray *arr = dicTemp[@"pictures"];
        if (arr.count) {
            return heightCell + 60;
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
    if ([[User getAuthenticationOwnerType] isEqualToString:@"认证户主"] || [[User getAuthenticationOwnerType] isEqualToString:@"认证业主"]) {
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
    if (self.chosenImages.count < 1) {
        [Networking retrieveData:GET_REPAIR_REPLY parameters:@{@"token": [User getUserToken],
                                                               @"id":_detailTextModel.Objectid,
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
            [Networking retrieveData:GET_REPAIR_REPLY parameters:@{@"token": [User getUserToken],
                                                                   @"id":_detailTextModel.Objectid,
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
