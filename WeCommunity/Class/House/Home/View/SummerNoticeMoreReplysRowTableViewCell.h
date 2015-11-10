//
//  SummerNoticeMoreReplysRowTableViewCell.h
//  WeCommunity
//
//  Created by madarax on 15/11/10.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SummerHomeDetailNoticeModel.h"

@interface SummerNoticeMoreReplysRowTableViewCell : UITableViewCell

@property (nonatomic ,weak)IBOutlet UIImageView *cellUserImageView;
@property (nonatomic ,weak)IBOutlet UILabel *cellTitleName;
@property (nonatomic ,weak)IBOutlet UILabel *cellTimeLab;
@property (nonatomic ,weak)IBOutlet UILabel *cellContentLab;
@property (nonatomic ,weak)IBOutlet UILabel *cellReplyCount;

- (void)confirmCellItemWithData:(SummerHomeDetailNoticeModel *)dictemp;

@end
