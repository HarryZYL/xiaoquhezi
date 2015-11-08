//
//  SummerPostRentViewController.h
//  WeCommunity
//
//  Created by madarax on 15/11/8.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "RentPostViewController.h"
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, SummerPostRentType) {
    SummerPostRentTypeSale,//出售
    SummerPostRentTypeBuy,
    SummerPostRentTypeRent,//出租
    SummerPostRentTypeHire,//求租
};
@interface SummerPostRentViewController : UIViewController<UIScrollViewDelegate,UzysAssetsPickerControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource ,RentPostViewDelegate>

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
@property (nonatomic ,assign)SummerPostRentType houseDealType;

@property(nonatomic ,copy)NSString *strHouseDeailID;

@end
