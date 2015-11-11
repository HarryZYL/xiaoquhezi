//
//  SummerLikeTableViewCell.m
//  WeCommunity
//
//  Created by madarax on 15/11/11.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerLikeTableViewCell.h"

@implementation SummerLikeTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
}
//[cell configureLikeCellImage:like.praiseType[@"logo"] title:like.content userName:like.creatorInfo[@"nickName"] date:like.createTime pictures:like.pictures];
- (void)confirmsSummerLikeTableViewData:(Like *)likeModel{
    [self.cellTitleImg sd_setImageWithURL:[NSURL URLWithString:likeModel.praiseType[@"logo"]] placeholderImage:[UIImage imageNamed:@"loadingLogo"]];
    self.cellTitleName.text = likeModel.creatorInfo[@"nickName"];
    self.cellTime.text = likeModel.createTime;
    self.cellContentLab.text = likeModel.content;
    for (NSInteger index = 0; index < 3; index ++) {
        UIImageView *img = (UIImageView *)[self viewWithTag:index + 1];
        img.hidden = YES;
    }
    if (![likeModel.pictures isEqual:[NSNull null]]) {
        if ([likeModel.pictures.firstObject length] > 1) {
            for (NSInteger index = 0; index < likeModel.pictures.count; index ++) {
                UIImageView *img = (UIImageView *)[self viewWithTag:index + 1];
                img.hidden = NO;
                [img sd_setImageWithURL:[NSURL URLWithString:likeModel.pictures[index]] placeholderImage:[UIImage imageNamed:@"loadingLogo"]];
            }
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
