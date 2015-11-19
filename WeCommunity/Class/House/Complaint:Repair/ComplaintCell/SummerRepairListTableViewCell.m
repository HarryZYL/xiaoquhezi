//
//  SummerRepairListTableViewCell.m
//  WeCommunity
//
//  Created by madarax on 15/11/11.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerRepairListTableViewCell.h"
#import "UITapGestureRecognizer+Data.h"

@implementation SummerRepairListTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.cellLineSingleLayout.constant = .5;
    for (NSInteger index = 0; index < 3; index ++) {
        UIImageView *img = (UIImageView *)[self viewWithTag:index + 1];
        
        UITapGestureRecognizer_Data *tapImg = [[UITapGestureRecognizer_Data alloc] initWithTarget:self action:@selector(imgTapViewWithTag:)];
        tapImg.tapTagImg = img.tag;
        [img addGestureRecognizer:tapImg];
    }
}

- (void)confirmRepairListCellWithData:(TextDeal *)textModel{
    [self.cellImageViewTitle sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",textModel.textType[@"logo"]]] placeholderImage:[UIImage imageNamed:@"advise"]];
    
    self.cellTitleLab.text = [textModel.content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    self.cellLabTime.text = textModel.createTime;
    
    [self.cellBtnCount setTitle:[NSString stringWithFormat:@"%@",textModel.replyCount] forState:UIControlStateNormal];
    
    if ([textModel.status isEqualToString:@"Pending"]) {
        self.cellStyle.image = [UIImage imageNamed:@"home_accepted"];
    }else if([textModel.status isEqualToString:@"Handling"]){
        self.cellStyle.image = [UIImage imageNamed:@"home_repairing"];
    }else if ([textModel.status isEqualToString:@"Success"]){
        self.cellStyle.image = [UIImage imageNamed:@"home_repaired"];
    }

    for (NSInteger index = 0; index < 3; index ++) {
        UIImageView *img = (UIImageView *)[self viewWithTag:index + 1];
        img.hidden = YES;
    }
    if (textModel.pictures.count > 0 && [textModel.pictures.firstObject length] > 1) {
        for (NSInteger index = 0; index < textModel.pictures.count; index ++) {
            UIImageView *img = (UIImageView *)[self viewWithTag:index + 1];
            img.hidden = NO;
            [img sd_setImageWithURL:[NSURL URLWithString:textModel.pictures[index]] placeholderImage:[UIImage imageNamed:@"loadingLogo"]];
        }
    }
}

- (void)imgTapViewWithTag:(UITapGestureRecognizer_Data *)sender{
    UIImageView *imgView = (UIImageView *)[self viewWithTag:sender.tapTagImg];
    [self.delegate summerRepairListCellWithData:imgView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
