//
//  SummerRentAlertView.m
//  WeCommunity
//
//  Created by madarax on 15/11/26.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerRentAlertView.h"

@implementation SummerRentAlertView
@synthesize houseDeal = _houseDeal;

- (instancetype)init{
    if (self == [super init]) {
        
    }
    return self;
}

- (void)setContentTitle{
    [self mScrollView];
    [self topView];
    [self initWithTopViewSubViewsWithDataModel:_houseDeal];
    [self initMiddleViewWithDataModel:_houseDeal];
    [self initWithBotomViewWithDataModel:_houseDeal];
}

- (void)initWithTopViewSubViewsWithDataModel:(HouseDeal *)housePostModel{
    self.selectImagesArrary = [[NSMutableArray alloc] init];
//    __weak typeof(self)weakSelf = self;
    NSArray *nameArrary = @[@"房型",@"户型",@"楼层",@"朝向"];
    for (NSInteger index = 0; index < 4; index ++) {
        __block UILabel *numbersLab = [UILabel new];
        numbersLab.text = nameArrary[index];
        [_topView addSubview:numbersLab];
        [numbersLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(182/4);
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(index * (182/4));
        }];
        
        __block UILabel *verticalLineLayer = [UILabel new];
        verticalLineLayer.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.957 alpha:1.000];
        [_topView addSubview:verticalLineLayer];
        
        [verticalLineLayer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(numbersLab).offset(0);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(1);
            make.top.mas_equalTo(10 + index * (182/4));
        }];
        
        if (index != 3){
            UILabel *horizontalLineLayer = [UILabel new];
            horizontalLineLayer.frame = CGRectMake(10, 182/4*(index + 1), SCREENSIZE.width - 20, 1);
            horizontalLineLayer.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.957 alpha:1.000];
            [_topView addSubview:horizontalLineLayer];
            
        }
        switch (index) {
            case 0:
            {
                UIButton *roomType = [UIButton buttonWithType:UIButtonTypeCustom];
                [roomType setTitle:self.houseDeal.houseType forState:UIControlStateNormal];
                roomType.frame = CGRectMake(SCREENSIZE.width - 90, 0, 80, 182/4);
                roomType.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
                [roomType setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [_topView addSubview:roomType];
            }
                break;
            case 1:
            {
                CGFloat labelWidth = SCREENSIZE.width - 50;
                NSArray *arraryType = @[@"室",@"厅",@"卫"];
                for (NSInteger index = 0; index < 3; index ++) {
                    __block UILabel *typeLab = [UILabel new];
                    typeLab.frame = CGRectMake(40 + (index+1)*labelWidth/3 -20, 182/4, 20, 182/4);
                    typeLab.textAlignment = NSTextAlignmentRight;
                    typeLab.text = arraryType[index];
                    [_topView addSubview:typeLab];
                    
                    UITextField *roomType = [[UITextField alloc] initWithFrame:CGRectMake(50 + labelWidth/3*index, 182/4, labelWidth/3-30, 182/4)];
                    roomType.keyboardType = UIKeyboardTypeNumberPad;
                    roomType.textAlignment = NSTextAlignmentCenter;
                    roomType.tag = 10 + index;
//                    roomType.backgroundColor = [UIColor redColor];
                    [_topView addSubview:roomType];

                    if (index == 0) {
                        roomType.text = self.houseDeal.room;
                    }else if (index == 1){
                        roomType.text = self.houseDeal.sittingRoom;
                    }else{
                        roomType.text = self.houseDeal.bathRoom;
                    }
                }
                
            }
                break;
            case 2:
            {
                for (NSInteger index = 0; index < 2; index ++) {
                    UITextField *floorText = [[UITextField alloc] init];
                    floorText.textAlignment = NSTextAlignmentCenter;
                    floorText.frame = CGRectMake(40 + index*((SCREENSIZE.width - 40)/2), 182/2 + 3, (SCREENSIZE.width - 40)/2, 40);
                    floorText.keyboardType = UIKeyboardTypeNumberPad;
                    floorText.tag = 13 + index;
                    [_topView addSubview:floorText];
                    if (index == 0) {
                        floorText.text = self.houseDeal.floor;
                        UILabel *lineLabe = [UILabel new];
                        lineLabe.text = @"/";
                        lineLabe.frame = CGRectMake(40 + (SCREENSIZE.width - 40)/2, 182/2, 20, 182/4);
                        [_topView addSubview:lineLabe];
                    }else{
                        floorText.text = self.houseDeal.totalFloor;
                    }
                }
            }
                break;
            case 3:
            {
                UIButton *orientationBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
                orientationBtn.frame = CGRectMake(40, 182/2 + 50, SCREENSIZE.width - 50, 40);
                orientationBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
                [orientationBtn setTitle:self.houseDeal.houseOrientation forState:UIControlStateNormal];
                [orientationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [_topView addSubview:orientationBtn];
            }
                break;
                
            default:
                break;
        }
    }
    
    
}

- (UIView *)topView{
    __weak typeof(self)weakSelf = self;
    _topView = [UIView new];
    _topView.backgroundColor = [UIColor whiteColor];
    [_mScrollView addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.width.mas_equalTo(weakSelf);
        make.height.mas_equalTo(182);
    }];
    return _topView;
}

- (void)initMiddleViewWithDataModel:(HouseDeal *)housePostModel{
    __weak typeof(self)weakSelf = self;
    _middleView = [UIView new];
    _middleView.backgroundColor = [UIColor whiteColor];
    [_mScrollView addSubview:_middleView];
    
    [_middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView.mas_bottom).offset(10);
        make.width.equalTo(weakSelf);
        make.height.mas_equalTo(90);
    }];
    
    NSArray *nameArrary = @[@"面积",@"租金"];
    NSArray *priceArrary = @[@"平米",@"元/月"];
    for (NSInteger index = 0; index < 2; index ++) {
        UILabel *nameLab = [UILabel new];
        nameLab.text = nameArrary[index];
//        nameLab.textAlignment = NSTextAlignmentRight;
        [_middleView addSubview:nameLab];
        
        UILabel *verticalLineLayer = [UILabel new];
        verticalLineLayer.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.957 alpha:1.000];
        [_middleView addSubview:verticalLineLayer];
        
        __block UILabel *priceLab = [UILabel new];
        priceLab.textAlignment = NSTextAlignmentRight;
        priceLab.text = priceArrary[index];
        [_middleView addSubview:priceLab];
        
        UITextField *priceText = [UITextField new];
        priceText.textAlignment = NSTextAlignmentRight;
        priceText.keyboardType = UIKeyboardTypeNumberPad;
        priceText.tag = 15 + index;
        [_middleView addSubview:priceText];
        
        [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(50);
            make.height.equalTo(nameLab.mas_height);
            make.top.mas_equalTo(index * 45);
            make.right.equalTo(weakSelf.middleView.mas_right).offset(-10);
        }];
        [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(45);
            make.top.equalTo(weakSelf.middleView.mas_top).offset(index*45);
            make.leading.equalTo(weakSelf.middleView.mas_leading).offset(10);
            make.width.mas_equalTo(40);
        }];
        [verticalLineLayer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(nameLab).offset(0);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(1);
            make.top.mas_equalTo(10 + index * 40);
        }];
        
        [priceText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(nameLab.mas_top).offset(0);
            make.left.equalTo(nameLab.mas_right).offset(0);
            make.right.equalTo(priceLab.mas_left).offset(-10);
            make.height.mas_equalTo(45);
        }];
        
        if (index == 0) {
            priceText.text = self.houseDeal.area;
            UILabel *horizontalLine = [UILabel new];
            horizontalLine.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.957 alpha:1.000];
            [_middleView addSubview:horizontalLine];
            [horizontalLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf.middleView.mas_left).offset(10);
                make.right.equalTo(weakSelf.middleView.mas_right).offset(0);
                make.top.equalTo(priceLab.mas_bottom);
                make.height.mas_equalTo(1);
            }];
        }else{
            priceText.text = self.houseDeal.price;
        }
        
    }
}

- (void)initWithBotomViewWithDataModel:(HouseDeal *)housePostModel{
    __weak typeof(self)weakSelf = self;
    _bootomView = [UIView new];
    _bootomView.clipsToBounds = YES;
    _bootomView.backgroundColor = [UIColor whiteColor];
    [_mScrollView addSubview:_bootomView];
    
    [_bootomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.middleView.mas_bottom).offset(10);
        make.right.equalTo(weakSelf.mas_right).offset(0);
        make.left.equalTo(weakSelf.mas_left).offset(0);
        if (weakSelf.houseDeal.pictures.count > 3) {
            make.height.mas_equalTo(330);
        }else{
            make.height.mas_equalTo(250);
        }
    }];
    NSArray *bootomTitle = @[@"标题",@"描述"];
    for (NSInteger index = 0; index < 2; index ++) {
        UILabel *titleLab = [UILabel new];
        titleLab.text = bootomTitle[index];
        [_bootomView addSubview:titleLab];
        
        UILabel *verticalLineLayer = [UILabel new];
        verticalLineLayer.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.957 alpha:1.000];
        [_bootomView addSubview:verticalLineLayer];
        
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(44);
            make.width.mas_equalTo(40);
            make.left.equalTo(weakSelf.bootomView.mas_left).offset(10);
            make.top.equalTo(weakSelf.bootomView.mas_top).offset(10 + 44*index);
        }];
        
        [verticalLineLayer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(titleLab).offset(0);
            make.width.mas_equalTo(1);
            make.top.equalTo(titleLab.mas_top).offset(10);
            make.bottom.equalTo(titleLab.mas_bottom).offset(-10);
        }];
        
        if (index == 0) {
            UILabel *horizontalLine = [UILabel new];
            horizontalLine.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.957 alpha:1.000];
            [_bootomView addSubview:horizontalLine];
            [horizontalLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf.middleView.mas_left).offset(10);
                make.right.equalTo(weakSelf.middleView.mas_right).offset(0);
                make.top.equalTo(titleLab.mas_bottom);
                make.height.mas_equalTo(1);
            }];
            
            UITextField *nameField = [UITextField new];
            nameField.text = self.houseDeal.title;
            nameField.tag = 17;
            nameField.placeholder = @"1-20个字";
            [_bootomView addSubview:nameField];
            [nameField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(titleLab.mas_top);
                make.bottom.equalTo(titleLab.mas_bottom);
                make.left.equalTo(titleLab.mas_right).offset(10);
                make.right.equalTo(weakSelf.bootomView.mas_right);
            }];
        }else{
            SAMTextView *describeText = [SAMTextView new];
            describeText.tag = 18;
            describeText.text = self.houseDeal.content;
            describeText.placeholder = @"交通配置等";
            describeText.font = [UIFont systemFontOfSize:17];
            [_bootomView addSubview:describeText];
            [describeText mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(titleLab.mas_top).offset(3);
                make.left.equalTo(titleLab.mas_right).offset(0);
                make.right.equalTo(weakSelf.bootomView).offset(-10);
                make.height.mas_equalTo(69);
            }];
            if (_houseDeal.pictures.count < 3) {
                _photoImage = [[CameraImageView alloc] initWithFrame:CGRectMake(20, describeText.frame.origin.y + describeText.frame.size.height + 160, SCREENSIZE.width - 20, 80)];
            }else{
                _photoImage = [[CameraImageView alloc] initWithFrame:CGRectMake(20, describeText.frame.origin.y + describeText.frame.size.height + 160, SCREENSIZE.width, 160)];
            }
//            _photoImage.backgroundColor = [UIColor redColor];
            
            [_bootomView addSubview:_photoImage];
            if ([housePostModel.pictures.firstObject length] > 5) {
                for (NSString *str in housePostModel.pictures) {
                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
                        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:str]];
                        UIImage *imgTemp = [UIImage imageWithData:imgData];
                        [_selectImagesArrary addObject:imgTemp];
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            [_photoImage configureImage:_selectImagesArrary];
                        });
                    });
                }
            }
            
        }
    }
}

- (UIScrollView *)mScrollView{
    __weak typeof(self)weakSelf = self;
    _mScrollView = [UIScrollView new];
    _mScrollView.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.957 alpha:1.000];
    _mScrollView.contentSize = CGSizeMake(SCREENSIZE.width, 1000);
    [self addSubview:_mScrollView];
    
    [_mScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    return _mScrollView;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
