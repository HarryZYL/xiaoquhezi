//
//  SettingTableViewController.m
//  WeCommunity
//
//  Created by Harry on 8/6/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "SettingTableViewController.h"
#import "UIViewController+HUD.h"

@interface SettingTableViewController ()

@end

@implementation SettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.functionArr = @[@"推送提醒",@"关于我们",@"退出"];
    
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
    if (indexPath.row == 0) {
        UISwitch *pushDownOrOn = [[UISwitch alloc] initWithFrame:CGRectMake(cell.frame.size.width - 100, 0, 60, 44)];
        pushDownOrOn.center = CGPointMake(cell.frame.size.width - 50, cell.frame.size.height/2.0);
        [pushDownOrOn addTarget:self action:@selector(pushNotificatinSeetingView) forControlEvents:UIControlEventValueChanged];
        [cell addSubview:pushDownOrOn];
        UIUserNotificationSettings *notificationSettings = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (notificationSettings.types == UIUserNotificationTypeNone) {
            pushDownOrOn.on = NO;
        }else{
            pushDownOrOn.on = YES;
        }
    }
    // (加载到cell上)Configure the cell...
    cell.textLabel.text = self.functionArr[indexPath.row];
    
    return cell;
}

//用户退出，把储存在用户的信息的用户名设置为0
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        
    }else if (indexPath.row == 1) {
        AboutViewController *aboutVC = [[AboutViewController alloc] init];
        aboutVC.title = @"关于我们";
        [self.navigationController pushViewController:aboutVC animated:YES];
    }else{
        NSDictionary *data = @{@"userName":@"0"};
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"WX_ID"];
        [FileManager saveDataToFile:data filePath:@"MyAppCache"];
        NSDictionary *password = @{@"password":@"0"};
        [FileManager saveDataToFile:password filePath:@"Password"];
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
  
}

- (void)pushNotificatinSeetingView{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }else{
        [self showHint:@"需要设置授权小区盒子接收通知"];
    }
}

@end
