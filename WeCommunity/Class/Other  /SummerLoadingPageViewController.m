//
//  SummerLoadingPageViewController.m
//  WeCommunity
//
//  Created by madarax on 15/11/19.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerLoadingPageViewController.h"

@interface SummerLoadingPageViewController ()

@end

@implementation SummerLoadingPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIScrollView *loadingScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    loadingScrollView.contentSize = CGSizeMake(SCREENSIZE.width * 4, SCREENSIZE.height);
    loadingScrollView.showsHorizontalScrollIndicator = NO;
    loadingScrollView.delegate = self;
    loadingScrollView.pagingEnabled = YES;
    [self.view addSubview:loadingScrollView];
    
    for (NSInteger index = 0; index < 4; index ++) {
        UIImageView *scrollImagView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENSIZE.width * index, 0, SCREENSIZE.width, SCREENSIZE.height)];
        scrollImagView.userInteractionEnabled = YES;
        scrollImagView.contentMode = UIViewContentModeScaleAspectFit;
        scrollImagView.image = [UIImage imageNamed:[NSString stringWithFormat:@"summer_loading_%d.jpg",index+1]];
        [loadingScrollView addSubview:scrollImagView];
        
        UITapGestureRecognizer *tapImgView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nextViewController)];
        [scrollImagView addGestureRecognizer:tapImgView];
    }
}

- (void)nextViewController{
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:YES] forKey:@"FIRST_LOGING"];
    if (_returnViewController) {
        _returnViewController();
    }
    [self removeFromParentViewController];
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
