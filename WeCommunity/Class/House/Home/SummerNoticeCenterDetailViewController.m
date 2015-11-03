//
//  SummerNoticeCenterDetailViewController.m
//  WeCommunity
//
//  Created by madarax on 15/11/3.
//  Copyright © 2015年 Harry. All rights reserved.
//
#import "NSString+HTML.h"
#import "SummerNoticeCenterDetailViewController.h"
#import "SummerNoticeDetailTableViewCell.h"

@interface SummerNoticeCenterDetailViewController ()
{
    Notice *detailNotice;
}
@property (nonatomic ,strong) NSMutableArray *arraryData;
@end

@implementation SummerNoticeCenterDetailViewController
//@synthesize strNoticeID = _strNoticeID;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getReceveData];
    [self.mTableView registerNib:[UINib nibWithNibName:@"SummerNoticeDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

- (void)getReceveData{
    [Networking retrieveData:getNoticeDetail parameters:@{@"id": self.strNoticeID} success:^(id responseObject) {
        detailNotice = [[Notice alloc] initWithData:responseObject];
        [self.mTableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arraryData.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath == 0) {
        CGRect rectHeight = [[NSString filterHTML:detailNotice.content] boundingRectWithSize:CGSizeMake(SCREENSIZE.width - 40, 200) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13]} context:nil];
        return rectHeight.size.height + 60;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        SummerNoticeDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        [cell.cellTitleImg sd_setImageWithURL:detailNotice.creatorInfo.headPhoto];
        cell.cellLabTitle.text = detailNotice.title;
        cell.cellLabTime.text = detailNotice.createTime;
        
        if (detailNotice.isTop.boolValue) {
            cell.cellLabTop.text = @"置顶公告";
        }
        cell.cellLabReplay.text  = [NSString stringWithFormat:@"%@",detailNotice.replyCount];
        cell.cellLabContent.text = [NSString filterHTML:detailNotice.content];
        
        return cell;
    }
    
    return nil;
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
