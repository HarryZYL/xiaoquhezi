//
//  ActivityPostViewController.h
//  WeCommunity
//
//  Created by Harry on 8/15/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityPostView.h"
@interface ActivityPostViewController : UIViewController<UzysAssetsPickerControllerDelegate>


@property (nonatomic,strong) UIScrollView *scollView;
@property (nonatomic,strong) ActivityPostView *postView;
@property (nonatomic) NSString *dateType;
@property (nonatomic, strong) NSMutableArray *chosenImages;
@property (nonatomic, strong) NSMutableArray *chosenImagesSmall;
@end
//活动发布页面