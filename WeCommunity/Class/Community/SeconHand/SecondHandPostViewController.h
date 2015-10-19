//
//  SecondHandPostViewController.h
//  WeCommunity
//
//  Created by Harry on 8/16/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondHandPostView.h"
#import "AvoidKeyboardVC.h"
#import "ActivityPostView.h"
@interface SecondHandPostViewController : UIViewController<UzysAssetsPickerControllerDelegate>
@property (nonatomic,strong) UIScrollView *scollView;
@property (nonatomic,strong) SecondHandPostView *postView;
@property (nonatomic, strong) NSMutableArray *chosenImages;
@property (nonatomic, strong) NSMutableArray *chosenImagesSmall;

//发布二手的页面
@end
