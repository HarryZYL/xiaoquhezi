//
//  SummerBusinessViewController.m
//  WeCommunity
//
//  Created by madarax on 15/11/20.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerBusinessViewController.h"
#import "SummerBusinessTableViewCell.h"
#import "SummerRunloopView.h"

@interface SummerBusinessViewController ()<UITableViewDataSource ,UITableViewDelegate ,DOPDropDownMenuDataSource ,DOPDropDownMenuDelegate>
@property (nonatomic, strong)IBOutlet UITableView *mTableView;
@property (nonatomic, strong) DOPDropDownMenu*businessMenu;
@property (nonatomic, strong) SummerRunloopView *headerRunloopView;

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
    _businessMenu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:50];
    _businessMenu.delegate   = self;
    _businessMenu.dataSource = self;
    [self.view addSubview:_businessMenu];
}

#pragma mark - DOPDropDownMenuDataSource

- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu {
    return 2;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column {
    switch (column) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        default:
            return 1;
            break;
    }
    
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath {
    menu.textColor = [UIColor colorWithWhite:0.259 alpha:1.000];
    switch (indexPath.column) {
        case 0:
            return @"分类";
            break;
        case 1:
            return @"筛选";
            break;
        default:
            return nil;
            break;
    }
    return @"123";
}

- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath {
    
    switch (indexPath.column) {
            
        case 0:
            switch (indexPath.row) {
                case 0:
//                    self.communityAll = NO;
//                    [self retrireveData];
                    break;
                case 1:
//                    self.communityAll = YES;
//                    [self retrireveData];
                    break;
                    
                default:
                    break;
            }
            
            break;
        case 1:
//            switch (indexPath.row) {
//                case 0:
//                    self.houseTypeArr = @[@"Sale",@"Rent"];
//                    [self retrireveData];
//                    break;
//                case 1:
//                    self.houseTypeArr = @[@"Sale"];
//                    [self retrireveData];
//                    break;
//                case 2:
//                    self.houseTypeArr = @[@"Rent"];
//                    [self retrireveData];
//                    break;
//                    
//                default:
//                    break;
//            }
            
            
            break;
        default:
            
            break;
    }
    
    
}

#pragma mark - UITableViewDelegate

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
