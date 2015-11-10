//
//  SummerNoticeMoreReplysRowTableViewCell.m
//  WeCommunity
//
//  Created by madarax on 15/11/10.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerNoticeMoreReplysRowTableViewCell.h"

@implementation SummerNoticeMoreReplysRowTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _cellUserImageView.layer.cornerRadius = _cellUserImageView.frame.size.width/2;
    _cellUserImageView.layer.masksToBounds = YES;
}

- (void)confirmCellItemWithData:(SummerHomeDetailNoticeModel *)dictemp{
    [self.cellUserImageView sd_setImageWithURL:dictemp.creatorInFo.headPhoto placeholderImage:[UIImage imageNamed:@"loadingLogo"]];
    self.cellTitleName.text = dictemp.creatorInFo.nickName;
    self.cellTimeLab.text = [Util formattedDate:dictemp.createTime type:1];
    self.cellContentLab.text = dictemp.content;
    self.cellReplyCount.text = [NSString stringWithFormat:@"%@楼",dictemp.replyIndex];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
