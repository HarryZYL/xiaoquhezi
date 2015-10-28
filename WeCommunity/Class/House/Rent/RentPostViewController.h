//
//  RentPostViewController.h
//  WeCommunity
//
//  Created by Harry on 8/5/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RentPostView.h"
#import "AvoidKeyboardVC.h"
#import "ImagePickerCollectionVC.h"
#import "ImagePickerLayout.h"
#import "HouseDeal.h"
#import "RentViewController.h"

typedef NS_ENUM(NSUInteger, SummerHouseDealType) {
    SummerHouseDealTypeSale,
    SummerHouseDealTypeBuy,
    SummerHouseDealTypeRent,//出租
    SummerHouseDealTypeHire,//求租
};

@interface RentPostViewController : UIViewController <UIScrollViewDelegate,UzysAssetsPickerControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource ,RentPostViewDelegate>

@property (nonatomic,strong) RentPostView *postView;
@property (nonatomic,strong) UIScrollView *scollView;
@property (nonatomic, strong) NSMutableArray *chosenImages;
@property (nonatomic, strong) NSMutableArray *chosenImagesSmall;
@property (nonatomic,strong) UIButton *imageBtn;
@property (nonatomic,strong) NSArray *houseTypeArr;
@property (nonatomic,strong) NSString *houseType;
@property (nonatomic,strong) NSArray *houseOrientationArr;
@property (nonatomic,strong) NSString *houseOrientation;
@property (nonatomic,strong) NSString *pickerTag;
@property (nonatomic,strong) NSString *pickerStr;
@property (nonatomic,strong) UIButton *submitBtn;
@property (nonatomic,strong) NSArray *stepArray;
@property (nonatomic) int step;
@property (nonatomic,strong) HouseDeal *houseDeal;
@property (nonatomic,strong) HouseDeal *houseData;
@property (nonatomic,strong) LoadingView *loadingView;
@property (nonatomic,strong) PickerView *pickerView;

@property (nonatomic ,assign)SummerHouseDealType houseDealType;

@end
