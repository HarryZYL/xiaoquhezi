//
//  SummerLikeTableViewCell.h
//  WeCommunity
//
//  Created by madarax on 15/11/11.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Like.h"

@interface SummerLikeTableViewCell : UITableViewCell

@property (nonatomic ,weak) IBOutlet UIImageView *cellTitleImg;
@property (nonatomic ,weak) IBOutlet UILabel *cellTitleName;
@property (nonatomic ,weak) IBOutlet UILabel *cellContentLab;
@property (nonatomic ,weak) IBOutlet UILabel *cellTime;

- (void)confirmsSummerLikeTableViewData:(Like *)likeModel;

@end
