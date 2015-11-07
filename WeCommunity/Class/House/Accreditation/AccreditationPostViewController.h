//
//  AccreditationPostViewController.h
//  WeCommunity
//
//  Created by Harry on 8/31/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AccreditationPostViewControllerDelegate <NSObject>

- (void)issueCertifySeccessful;

@end

@interface AccreditationPostViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,weak) id delegate;

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSArray *titleArray;
@property (nonatomic,strong) UITextField *nameField;
@property (nonatomic,strong) UIButton *cardTypeBtn;
@property (nonatomic,strong) UITextField *cardNumberField;
@property (nonatomic,strong) UIButton *communityName;
@property (nonatomic,strong) UIButton *buildingIDBtn;
@property (nonatomic,strong) NSString *buildingId;
@property (nonatomic,strong) UIButton *houseIDBtn;
@property (nonatomic,strong) NSString *houseId;
@property (nonatomic,strong) UIButton *owerTypeBtn;
@property (nonatomic,strong) NSString *owerType;
@property (nonatomic,strong) UIButton *submitBtn;
@property (nonatomic,strong) LoadingView *loadingView;

@property (nonatomic ,strong) NSMutableArray *arraryUnit;
@property (nonatomic ,copy) NSString *strUnit;
@property (nonatomic ,copy) NSString *strCommunityName;
@property (nonatomic ,copy) NSString *strCommunityID;

//picker
@property (nonatomic,strong) PickerView *pickerView;
@property (nonatomic,strong) NSString *pickerTag;
@property (nonatomic,strong) NSString *pickerStr;
@property (nonatomic,strong) NSArray *owerTypeArr;
@property (nonatomic,strong) NSArray *owerTypeArrEn;
@property (nonatomic,strong) NSArray *buildingArr;
@property (nonatomic,strong) NSArray *houseArr;
@end
