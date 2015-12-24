//
//  EditDetailTableViewController.m
//  WeCommunity
//
//  Created by Harry on 9/2/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "EditDetailTableViewController.h"

@interface EditDetailTableViewController ()

@end

@implementation EditDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       
    [self.tableView registerClass:[BasicTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self setupButton];
    
    self.loadingView = [[LoadingView alloc] initWithFrame:self.view.frame];
    self.loadingView.titleLabel.text = @"正在更新";

}

//设置导航器的button
-(void)setupButton{
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelEdit:)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStylePlain target:self action:@selector(confirmEdit:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    
}

//取消修改
-(void)cancelEdit:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//确定修改
-(void)confirmEdit:(id)sender{
    
    [self.view endEditing:YES];
    [self retrireveData];
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
    return 1;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BasicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
        cell.textField.frame = CGRectMake(10, 0, self.view.frame.size.width-20, 50);
        cell.textField.placeholder = self.titleMessage;
        cell.textField.clearButtonMode = UITextFieldViewModeAlways;
        cell.textField.text = self.message;
        cell.textField.delegate = self;
        [cell.textField becomeFirstResponder];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
#pragma mark textField

-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.changedMessage = textField.text;
}


#pragma mark networking

-(void)retrireveData{
    
    [self.view addSubview:self.loadingView];
    NSDictionary *parameters = @{@"token":[User getUserToken],self.updateMessage:self.changedMessage};
    [Networking retrieveData:updateBasicInfo parameters:parameters success:^(id responseObject) {
        [self login];
    }];

}

-(void)login{
    User *userModel = [User shareUserDefult];
    NSDictionary *parameters = @{@"phoneNumber":userModel.userName,@"password":userModel.loginPassword};
    
    [Networking retrieveData:phoneLogin parameters:parameters success:^(id responseObject) {
        NSDictionary *userData = [Util removeNullInDictionary:responseObject[@"user"]];
        NSDictionary *data = @{@"token":responseObject[@"token"],@"user":userData};
        [FileManager saveDataToFile:data filePath:@"MyAppCache"];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } addition:^{
        [self.loadingView removeFromSuperview];
    }];
    

}



@end
