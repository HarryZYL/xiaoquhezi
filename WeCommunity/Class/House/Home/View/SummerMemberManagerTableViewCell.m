//
//  SummerMemberManagerTableViewCell.m
//  WeCommunity
//
//  Created by madarax on 15/10/26.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerMemberManagerTableViewCell.h"

@interface SummerMemberManagerTableViewCell()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellTitleLayoutConstraint;

@end

@implementation SummerMemberManagerTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.cellUserImg.layer.cornerRadius = 18;
    self.cellUserImg.layer.masksToBounds = YES;
}

- (void)confirmMemberManagerCellWithData:(NSDictionary *)tempDic withIndexPath:(NSIndexPath *)indexPath{
    NSMutableAttributedString *tempTitleName = [[NSMutableAttributedString alloc]initWithString:@"小五 业主"];
    [tempTitleName addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16],
                                   NSForegroundColorAttributeName:[UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:1]} range:NSMakeRange(0, 2)];
    [tempTitleName addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14],
                                   NSForegroundColorAttributeName:[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1]} range:NSMakeRange(tempTitleName.length - 2, 2)];
    if (indexPath.row == 0) {
        self.cellTitleLayoutConstraint.constant = 16;
        self.cellTitleName.attributedText = tempTitleName;
    }else{
        
        self.cellTitleName.attributedText = tempTitleName;
        self.cellIDCard.text = @"身份证号:878395793275131";
        self.cellTime.text = @"2015-01-02 18:19 认证成功";
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
