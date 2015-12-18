//
//  SummerBusinessDetailViewController.m
//  WeCommunity
//
//  Created by madarax on 15/11/20.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerBusinessDetailViewController.h"
#import "SummerBusinessDetailTableViewCell.h"

@interface SummerBusinessDetailViewController ()<UITableViewDataSource ,UITableViewDelegate>
@property(nonatomic,weak) IBOutlet UITableView *mTableView;
@end

@implementation SummerBusinessDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 280;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SummerBusinessDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellHeader" forIndexPath:indexPath];
    
    return cell;
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
