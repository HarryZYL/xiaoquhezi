//
//  SettingTableViewController.m
//  WeCommunity
//
//  Created by Harry on 8/6/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "SettingTableViewController.h"

@interface SettingTableViewController ()

@end

@implementation SettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.functionArr = @[@"关于我们",@"退出"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return self.functionArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // (加载到cell上)Configure the cell...
    cell.textLabel.text = self.functionArr[indexPath.row];
    
    return cell;
}

//用户退出，把储存在用户的信息的用户名设置为0
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
       
        AboutViewController *aboutVC = [[AboutViewController alloc] init];
        aboutVC.title = @"关于我们";
        [self.navigationController pushViewController:aboutVC animated:YES];
        
    }else if (indexPath.row == 1) {
        NSDictionary *data = @{@"userName":@"0"};
        [FileManager saveDataToFile:data filePath:@"MyAppCache"];
        [self.navigationController popToRootViewControllerAnimated:NO];

    }
  
}


@end
