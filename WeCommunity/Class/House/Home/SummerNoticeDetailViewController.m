//
//  SummerNoticeDetailViewController.m
//  WeCommunity
//
//  Created by madarax on 15/11/3.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerNoticeDetailViewController.h"
#define IMPUT_VIEW_HEIGHT 40

@interface SummerNoticeDetailViewController ()
@property (nonatomic ,strong) RDRStickyKeyboardView *contentWrapper;

@end

@implementation SummerNoticeDetailViewController
@synthesize strNoticeID;
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(summerKeybordViewWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(summerKeybordViewWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"公告详情";
    [self.view addSubview:self.mTableView];
    
    _summerInputView = [[SummerInputView alloc] initWithFrame:CGRectMake(0, SCREENSIZE.height - IMPUT_VIEW_HEIGHT, SCREENSIZE.width, IMPUT_VIEW_HEIGHT)];
    [self.view addSubview:_summerInputView];
    
}

- (void)didTapSend:(id)sender
{
    
    //    [self.contentWrapper hideKeyboard];
}

#pragma mark - UITableViewDelegate/UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"
                                                            forIndexPath:indexPath];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
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
    [UIView animateWithDuration:animationDuration animations:^{
        _summerInputView.frame = CGRectMake(0, SCREENSIZE.height - IMPUT_VIEW_HEIGHT - rectKeybord.size.height, SCREENSIZE.width, IMPUT_VIEW_HEIGHT);
        self.mTableView.frame = CGRectMake(0, 0, SCREENSIZE.width, SCREENSIZE.height - IMPUT_VIEW_HEIGHT - rectKeybord.size.height);
    }];
}

- (void)summerKeybordViewWillHide:(NSNotification *)aNotification{
    NSTimeInterval animationDuration = [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:animationDuration animations:^{
        _summerInputView.frame = CGRectMake(0, SCREENSIZE.height - IMPUT_VIEW_HEIGHT, SCREENSIZE.width, IMPUT_VIEW_HEIGHT);
        
        self.mTableView.frame = CGRectMake(0, 0, SCREENSIZE.width, SCREENSIZE.height - IMPUT_VIEW_HEIGHT);
    }];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

- (void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UITableView *)mTableView{
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, SCREENSIZE.height - IMPUT_VIEW_HEIGHT)
                                                  style:UITableViewStyleGrouped];
    _mTableView.dataSource = self;
    _mTableView.delegate = self;
//    [_mTableView registerClass:[UITableViewCell class]
//           forCellReuseIdentifier:@"cell"];
    _mTableView.tableFooterView = [[UIView alloc] init];
    return _mTableView;
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
