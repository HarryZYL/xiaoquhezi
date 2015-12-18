//
//  SummerBusinessSearchViewController.m
//  WeCommunity
//
//  Created by madarax on 15/12/9.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import "SummerBusinessSearchViewController.h"
#import "SummerCollectionTableViewCell.h"

@interface SummerBusinessSearchViewController ()<UITextFieldDelegate>
@property(nonatomic,weak)IBOutlet UITextField *searchText;
@property(nonatomic,weak)IBOutlet UITableView *historyTableView;
@property(nonatomic,weak)IBOutlet NSLayoutConstraint *historyLayoutBootom;
@end

@implementation SummerBusinessSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_mTableView registerNib:[UINib nibWithNibName:@"SummerCollectionTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellItem"];
    _historyTableView.tableFooterView = [UIView new];
    _mTableView.tableFooterView = [UIView new];
    [self setHistoryTableViewHeaderView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(summerKeybordViewWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(summerKeybordViewWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)setHistoryTableViewHeaderView{
    UIView *headerViewBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, 45)];
    headerViewBg.backgroundColor = self.view.backgroundColor;
    
    UILabel *headerView = [[UILabel alloc] initWithFrame:CGRectMake(0,10, SCREENSIZE.width, 15)];
    headerView.backgroundColor = self.view.backgroundColor;
    headerView.textColor = [UIColor colorWithWhite:0.533 alpha:1.000];
    headerView.text = @"    最近搜索";
    headerView.font = [UIFont systemFontOfSize:14];
    
    [headerViewBg addSubview:headerView];
    
    _historyTableView.tableHeaderView = headerViewBg;
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _mTableView) {
        return 8;
    }
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _historyTableView) {
        static NSString *cellIdenty = @"cellHistory";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdenty];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdenty];
            cell.textLabel.font = [UIFont systemFontOfSize:16];
            cell.textLabel.textColor = [UIColor colorWithWhite:0.259 alpha:1.000];
        }
        cell.textLabel.text = @"123";
        return cell;
    }
    SummerCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellItem" forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _historyTableView) {
        
    }else{
        
    }
}

- (IBAction)btnSearchDefulte:(id)sender{
    [_searchText endEditing:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    _historyTableView.hidden = NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    _historyTableView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)summerKeybordViewWillShow:(NSNotification *)aNotificaiton{
    NSDictionary* info = [aNotificaiton userInfo];
    NSValue  *keybordRect = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect rectKeybord = keybordRect.CGRectValue;
    NSTimeInterval animationDuration = [[[aNotificaiton userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:animationDuration animations:^{
        weakSelf.historyLayoutBootom.constant = rectKeybord.size.height;
    }];
}

- (void)summerKeybordViewWillHide:(NSNotification *)aNotification{
    NSTimeInterval animationDuration = [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:animationDuration animations:^{
        weakSelf.historyLayoutBootom.constant = 0;
    }];
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
