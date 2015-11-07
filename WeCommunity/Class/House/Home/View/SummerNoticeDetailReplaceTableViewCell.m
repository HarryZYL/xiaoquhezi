//
//  SummerNoticeDetailReplaceTableViewCell.m
//  WeCommunity
//
//  Created by madarax on 15/11/6.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerNoticeDetailReplaceTableViewCell.h"

@implementation SummerNoticeDetailReplaceTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self addSubview:self.cellTitleImg];
    [self addSubview:self.cellNameLab];
    [self addSubview:self.cellContenLab];
    [self addSubview:self.cellReplayBtn];
}

- (void)confirmCellInformationWithData:(NSDictionary *)dicTemp{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIImageView *)cellTitleImg{
    self.cellTitleImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 44, 44)];
    return self.cellTitleImg;
}

- (UILabel *)cellNameLab{
    self.cellNameLab = [[UILabel alloc] initWithFrame:CGRectMake(self.cellTitleImg.frame.origin.x + self.cellTitleImg.frame.size.width + 8, 10, 100, 15)];
    return self.cellNameLab;
}

- (UILabel *)cellTimeLab{
    self.cellTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(self.cellTitleImg.frame.origin.x + self.cellTitleImg.frame.size.width + 8, self.cellNameLab.frame.origin.y + self.cellNameLab.frame.size.height + 3, 200, 15)];
    return self.cellTimeLab;
}

- (UILabel *)cellContenLab{
    self.cellContenLab = [[UILabel alloc] init];
    return self.cellContenLab;
}

- (UIButton *)cellReplayBtn{
    self.cellReplayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cellReplayBtn.frame = CGRectMake(SCREENSIZE.width - 100, 0, 100, 50);
    [self.cellReplayBtn setTitleColor:[UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1] forState:UIControlStateNormal];
    return self.cellReplayBtn;
}

@end














