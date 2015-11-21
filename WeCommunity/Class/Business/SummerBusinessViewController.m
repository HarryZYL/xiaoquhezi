//
//  SummerBusinessViewController.m
//  WeCommunity
//
//  Created by madarax on 15/11/20.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerBusinessViewController.h"
#import "SummerBusinessTableViewCell.h"

@interface SummerBusinessViewController ()<UITableViewDataSource ,UITableViewDelegate>
@property (nonatomic, strong)IBOutlet UITableView *mTableView;
@end

@implementation SummerBusinessViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if ([super initWithCoder:aDecoder]) {
        self.title = @"商家";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SummerBusinessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellItem" forIndexPath:indexPath];
    cell.cellImgView.image = [UIImage imageNamed:@"house1"];
    cell.cellTitleLab.text = @"上海之夜";
    cell.cellContentLab.text = @"开张大优惠";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"kBusinessID" sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//    
//}


@end
