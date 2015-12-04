//
//  SummerBusinessViewController.m
//  WeCommunity
//
//  Created by madarax on 15/11/20.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerBusinessViewController.h"
#import "SummerBusinessTableViewCell.h"
#import "SummerBusinessHeaderTableViewCell.h"
#import "SummerRunloopView.h"

@interface SummerBusinessViewController ()<UITableViewDataSource ,UITableViewDelegate ,DOPDropDownMenuDataSource ,DOPDropDownMenuDelegate>
@property (nonatomic, strong)IBOutlet UITableView *mTableView;
@property (nonatomic, strong) DOPDropDownMenu*businessMenu;
@property (nonatomic, strong) SummerRunloopView *headerRunloopView;

@property (nonatomic, strong) NSArray *classifyArrary;
@property (nonatomic, strong) NSArray *siftArrary;

@end

@implementation SummerBusinessViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if ([super initWithCoder:aDecoder]) {
        self.title = @"周边";
        _classifyArrary = @[@"分类",@"全部",@"美食",@"休闲娱乐",@"运动健身",@"足疗按摩"];
        _siftArrary = @[@"筛选",@"全部",@"可配送",@"有优惠",@"小区盒子-金马会.专属特惠"];
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
            return _classifyArrary.count;
            break;
        case 1:
            return _siftArrary.count;
            break;
        default:
            break;
    }
    return 0;
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath {
    menu.textColor = [UIColor colorWithWhite:0.259 alpha:1.000];
    switch (indexPath.column) {
        case 0:
            return _classifyArrary[indexPath.row];
            break;
        case 1:
            return _siftArrary[indexPath.row];
            break;
        default:
            return nil;
            break;
    }
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 160;
    }
    return 80;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        SummerBusinessHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sectioncell" forIndexPath:indexPath];
        __weak typeof(self)weakSelf = self;
        cell.summerScrollView.loopImgArrary = @[@"http://img1.imgtn.bdimg.com/it/u=2282547951,3816622274&fm=21&gp=0.jpg",@"http://c.hiphotos.baidu.com/image/h%3D200/sign=869f1fd9329b033b3388fbda25cc3620/a6efce1b9d16fdfafde4c433b28f8c5495ee7b66.jpg",@"http://pic38.nipic.com/20140215/12359647_224249271130_2.jpg"];
        [cell.summerScrollView confirmSubViews];
        cell.summerScrollView.backgroundColor = [UIColor orangeColor];
        cell.summerScrollView.tapIndex = ^(NSInteger index){
            [weakSelf headerViewTapViewIndex:index];
        };
        return cell;
    }
    SummerBusinessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellItem" forIndexPath:indexPath];
    cell.cellImgView.image = [UIImage imageNamed:@"house1"];
    cell.cellTitleLab.text = @"上海之夜";
    cell.cellContentLab.text = @"开张大优惠";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"kBusinessID" sender:nil];
}

- (void)headerViewTapViewIndex:(NSInteger)index{
    NSLog(@"---->%ld",index);
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
