//
//  SummerRePostMyRentViewController.m
//  WeCommunity
//
//  Created by madarax on 15/11/21.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerRePostMyRentViewController.h"

@interface SummerRePostMyRentViewController ()
@property (nonatomic ,strong)UIScrollView *mScrollView;
@end

@implementation SummerRePostMyRentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (UIScrollView *)mScrollView{
    _mScrollView = [UIScrollView new];
    _mScrollView.backgroundColor = [UIColor redColor];
    _mScrollView.contentSize = CGSizeMake(SCREENSIZE.width, 500);
    [self.view addSubview:_mScrollView];
    __weak typeof(self)weakSelf = self;
    [_mScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    return _mScrollView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
