//
//  TextDetailTableViewController.m
//  WeCommunity
//
//  Created by Harry on 10/3/15.
//  Copyright © 2015 Harry. All rights reserved.
//

#import "TextDetailTableViewController.h"

@interface TextDetailTableViewController ()<UzysAssetsPickerControllerDelegate>
@property (nonatomic ,strong) NSMutableArray *chosenImages;
@property (nonatomic ,strong) NSMutableArray *textArrary;
@end

@implementation TextDetailTableViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.notice   = [[Notice alloc] init];
        self.textDeal = [[TextDeal alloc] init];
        self.textArrary = [[NSMutableArray alloc] init];
        self.chosenImages = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Setup wrapper
    [self.view addSubview:self.contentWrapper];
    [self tableView];
}
//发送
- (void)didTapSend:(id)sender{
    NSString *urlStr;
    switch (_noticeStyle) {
        case SettingTableViewControllerStyleNotice:
        {//回复公告
            urlStr = get_reply_notice;
            NSLog(@"--->%@",self.contentWrapper.inputView.textView.text);
            NSString *comment = [self.contentWrapper.inputView.textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if ([comment length]!= 0){
                [self.contentWrapper hideKeyboard];
                [Networking retrieveData:urlStr parameters:@{@"token": [User getUserToken],
                                                             @"id":_notice.Objectid} success:^(id responseObject) {
                                                                 NSLog(@"123456");
                                                             }];
                self.contentWrapper.inputView.textView.text=nil;
                
            }
        }
            break;
        case SettingTableViewControllerStyleRepair:
        {//回复报修
            
        }
            break;
        case SettingTableViewControllerStyleComplain:
        {//投诉
            
        }
            break;
            
        default:
            break;
    }

    
    
}
//选择图片
- (void)senderImageView:(UIButton *)sender{
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
            
            [self.chosenImages addObject:img];
            
            if (idx==0 && self.chosenImages.count == 1) {
                
            }
            
        }];
        
    }
    //上传图片
    [self updatePhotoImages];
}

- (void)updatePhotoImages{
    switch (_noticeStyle) {
        case SettingTableViewControllerStyleNotice:
        {
            [Networking retrieveData:get_reply_notice parameters:@{@"token": [User getUserToken],
                                                                 @"id":_notice.Objectid,
                                                                   @"pictures":@[]} success:^(id responseObject) {
                                                                       
                                                             NSLog(@"123456");
                                                         }];
        }
            break;
        case SettingTableViewControllerStyleRepair:
        {
            
        }
            break;
        case SettingTableViewControllerStyleComplain:
        {
            
        }
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BasicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
            if (self.noticeStyle == SettingTableViewControllerStyleNotice) {
                [cell configureNoticeCellTitle:self.notice.title detail:self.notice.contentTxt date:self.notice.createTime top:self.notice.isTop detail:YES withReplyCount:self.notice.replyCount];
                
            }else{
                [cell configureTextCellImage:[NSURL URLWithString:self.textDeal.textType[@"logo"]] title:self.textDeal.content date:self.textDeal.createTime deal:self.textDeal.status pictures:self.textDeal.pictures detail:YES withCount:self.textDeal.replyCount];
            }
            
            break;
        case 1:
            
            cell.selectionStyle = NO;
            
            break;
            
        default:
            break;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.function isEqualToString:@"text"]) {
       
        return [BasicTableViewCell getTextDetailHeight:self.textDeal.content picture:self.textDeal.pictures];

    }else if ([self.function isEqualToString:@"notice"]){
        return [BasicTableViewCell getNoticeDetailHeight:self.notice.contentTxt];
        
    }else {
        return 200;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 10;
    }else{
        return 0;
    }
    
}

#pragma mark - init View

- (UITableView *)tableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                  style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate   = self;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth
    |UIViewAutoresizingFlexibleHeight;
    [_tableView registerClass:[BasicTableViewCell class] forCellReuseIdentifier:@"cell"];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    return _tableView;
}

- (RDRStickyKeyboardView *)contentWrapper{
    _contentWrapper = [[RDRStickyKeyboardView alloc] initWithScrollView:self.tableView];
    _contentWrapper.frame = self.view.bounds;
    _contentWrapper.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _contentWrapper.inputView.textView.placeholder = @"发表评论";
    [_contentWrapper.inputView.rightButton addTarget:self action:@selector(didTapSend:) forControlEvents:UIControlEventTouchUpInside];
    [_contentWrapper.inputView.leftButton addTarget:self action:@selector(senderImageView:) forControlEvents:UIControlEventTouchUpInside];
    return _contentWrapper;
}

@end















