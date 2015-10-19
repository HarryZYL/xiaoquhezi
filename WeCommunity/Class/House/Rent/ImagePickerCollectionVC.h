//
//  ImagePickerCollectionVC.h
//  WeCommunity
//
//  Created by Harry on 8/26/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagePickerCollectionViewCell.h"
#import "ImagePickerLayout.h"

@interface ImagePickerCollectionVC : UICollectionViewController

@property (nonatomic,strong) NSMutableArray *chosenImages;
@property (nonatomic,strong) NSMutableArray *chosenImagesSmall;
@property (nonatomic,strong) UIButton *bottomBtn;

@end
