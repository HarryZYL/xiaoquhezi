//
//  ImagePickerCollectionViewCell.h
//  WeCommunity
//
//  Created by Harry on 8/26/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImagePickerCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIButton *deleteBtn;
@property (nonatomic) int step;

@end
