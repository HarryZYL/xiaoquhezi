//
//  SigninViewController.m
//  WeCommunity
//
//  Created by Harry on 7/27/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "SigninViewController.h"

@interface SigninViewController ()

@end

@implementation SigninViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupAppearance];
    [self setupTableView];
}


-(void)setupAppearance{
    
    self.headerView = [[SigninHeader alloc] initWithFrame:CGRectMake(0, 84, self.view.frame.size.width, 150)];
    [self.view addSubview:self.headerView];
    
    self.dateView = [[SigninDate alloc] initWithFrame:
                     CGRectMake(0, self.headerView.frame.origin.y+self.headerView.frame.size.height, self.view.frame.size.width, 210)];
    [self.view addSubview:self.dateView];
    
}


-(void)setupTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.dateView.frame.origin.y+self.dateView.frame.size.height+30, self.view.frame.size.width, self.view.frame.size.height-280) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[BasicTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    
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
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BasicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.dateLabel.frame = CGRectMake(20, 10, cell.frame.size.width-20, cell.frame.size.height-20);
    cell.dateLabel.text = @"2015-07-17 15:45 2分 （签到）";

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}


@end
