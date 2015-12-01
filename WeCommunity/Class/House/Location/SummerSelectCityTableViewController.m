//
//  SummerSelectCityTableViewController.m
//  WeCommunity
//
//  Created by madarax on 15/11/30.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerSelectCityTableViewController.h"
#import "MBProgressHUD.h"
#import "SummerSelectCityView.h"
@interface SummerSelectCityTableViewController ()<UITableViewDataSource ,UITableViewDelegate>

@property (nonatomic ,strong)MBProgressHUD *mProgressHUD;
@property (nonatomic ,strong)UITableView *cityTableView;
@property (nonatomic ,strong)NSMutableArray *cityArrary;

@end

@implementation SummerSelectCityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"城市切换";
    _cityArrary = [[NSMutableArray alloc] init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.cityTableView];
    _mProgressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    
    [_mProgressHUD show:YES];
    
    [self initOfData];
}

- (UITableView *)cityTableView{
    _cityTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, SCREENSIZE.height) style:UITableViewStylePlain];
    [_cityTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _cityTableView.sectionIndexColor = THEMECOLOR;
    _cityTableView.tableFooterView = [[UIView alloc] init];
    _cityTableView.delegate   = self;
    _cityTableView.dataSource = self;
    return _cityTableView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _cityArrary.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_cityArrary.count) {
        return [_cityArrary[section][@"cityNames"] count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    NSDictionary *dicTemp = _cityArrary[indexPath.section][@"cityNames"][indexPath.row];
    cell.textLabel.text = dicTemp[@"name"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dicAddress = _cityArrary[indexPath.section][@"cityNames"][indexPath.row];
    [FileManager saveDataToFile:dicAddress filePath:@"selectCity"];
    if (self.cityBlock) {
        _cityBlock(dicAddress);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [_cityArrary[section][@"citykeys"] uppercaseString];
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSMutableArray *titleArrary = [[NSMutableArray alloc]init];
    for (NSDictionary *strDic in _cityArrary) {
        if (![titleArrary containsObject:strDic[@"citykeys"]]) {
            [titleArrary addObject:[strDic[@"citykeys"] uppercaseString]];
        }
        
    }
    return titleArrary;
}

- (void)initOfData{
    __weak typeof(self)weakSelf = self;
    if ([CLLocationManager locationServicesEnabled]) {
        [Networking retrieveData:get_ONLY_CITY parameters:nil success:^(id responseObject) {
            NSArray *sortedArrary = [responseObject sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *obj1, NSDictionary *obj2) {
                return [obj1[@"pinyin"] compare:obj2[@"pinyin"]];
            }];
            NSLog(@"---->%@",sortedArrary);
            for (int i = 0; i < sortedArrary.count; i ++) {
                NSDictionary *dic1 = sortedArrary[i];
                NSMutableArray *dataTemp = [[NSMutableArray alloc] init];
                if (i == 0) {
                    [dataTemp addObject:dic1];
                }
                for (int j = 0; j < sortedArrary.count; j ++) {
                    NSDictionary *dic2 = sortedArrary[j];
                    if ([dic1[@"id"] integerValue] != [dic2[@"id"] integerValue] && [[dic1[@"pinyin"] substringToIndex:1] isEqualToString:[dic2[@"pinyin"] substringToIndex:1]]) {
                        [dataTemp addObject:dic2];
                    }
                }
                if (_cityArrary.count) {
                    BOOL iscontent = NO;
                    for (NSDictionary *dicKeyModel in _cityArrary) {
                        if ([dicKeyModel[@"citykeys"] isEqualToString:[dic1[@"pinyin"] substringToIndex:1]]) {
                            iscontent = YES;
                        }
                    }
                    if (!iscontent) {
                        NSDictionary *dicTemp = @{@"cityNames": dataTemp,@"citykeys":[dic1[@"pinyin"] substringToIndex:1]};
                        [_cityArrary addObject:dicTemp];
                    }
                    
                }else{
                    NSDictionary *dicTemp = @{@"cityNames": dataTemp,@"citykeys":[dic1[@"pinyin"] substringToIndex:1]};
                    [_cityArrary addObject:dicTemp];
                }
                
            }
            [weakSelf.mProgressHUD removeFromSuperview];
            [_cityTableView reloadData];
        }];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
