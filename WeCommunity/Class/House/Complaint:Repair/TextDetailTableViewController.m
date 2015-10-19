//
//  TextDetailTableViewController.m
//  WeCommunity
//
//  Created by Harry on 10/3/15.
//  Copyright © 2015 Harry. All rights reserved.
//

#import "TextDetailTableViewController.h"

@interface TextDetailTableViewController ()

@end

@implementation TextDetailTableViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.textDeal = [[TextDeal alloc] init];
        self.notice = [[Notice alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                       style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth
    |UIViewAutoresizingFlexibleHeight;

    [self.tableView registerClass:[BasicTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    // Setup wrapper
    self.contentWrapper = [[RDRStickyKeyboardView alloc] initWithScrollView:self.tableView];
    self.contentWrapper.frame = self.view.bounds;
    self.contentWrapper.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.contentWrapper.placeholder = @"发表评论";

    [self.contentWrapper.inputView.rightButton addTarget:self action:@selector(didTapSend:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.contentWrapper];
}

- (void)didTapSend:(id)sender{
    NSString *comment = [self.contentWrapper.inputView.textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([comment length]!=0){
       
        [self.contentWrapper hideKeyboard];
        self.contentWrapper.inputView.textView.text=nil;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BasicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
            if ([self.function isEqualToString:@"text"]) {
                [cell configureTextCellImage:[NSURL URLWithString:self.textDeal.textType[@"logo"]] title:self.textDeal.content date:self.textDeal.createTime deal:self.textDeal.status pictures:self.textDeal.pictures detail:YES];
            }else if ([self.function isEqualToString:@"notice"]){
                [cell configureNoticeCellTitle:self.notice.title detail:self.notice.contentTxt date:self.notice.createTime top:self.notice.isTop detail:YES];
            }
            
            break;
        case 1:
            
            cell.selectionStyle = NO;
            
            break;
            
        default:
            break;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.function isEqualToString:@"text"]) {
       
        return [BasicTableViewCell getTextDetailHeight:self.textDeal.content picture:self.textDeal.pictures];

    }else if ([self.function isEqualToString:@"notice"]){
        
        return [BasicTableViewCell getNoticeDetailHeight:self.notice.contentTxt];
        
    }else {
        return 200;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 10;
    }else{
        return 0;
    }
    
}




@end
