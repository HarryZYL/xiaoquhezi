//
//  TextPostViewController.h
//  WeCommunity
//
//  Created by Harry on 7/21/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FunctionView.h"
#import "SAMTextView.h"
#import "User.h"
#import "LoadingView.h"
#import "Util.h"
#import "CameraImageView.h"
@interface TextPostViewController : UIViewController<UzysAssetsPickerControllerDelegate>
@property (nonatomic ,strong) FunctionView *functionView;
@property (nonatomic, strong) SAMTextView  *describleView;
@property (nonatomic,strong) NSString *function;
@property (nonatomic,strong) NSString *postType;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UITextField *nickNameField;
@property (nonatomic,strong) UITextField *phoneField;
@property (nonatomic,strong) User *user;
@property (nonatomic,strong) LoadingView *loadingView;
@property (nonatomic,strong) NSNumber *postID;
@property (nonatomic,strong) CameraImageView *cameraView;
@property (nonatomic, strong) NSMutableArray *chosenImages;
@property (nonatomic, strong) NSMutableArray *chosenImagesSmall;
@end
