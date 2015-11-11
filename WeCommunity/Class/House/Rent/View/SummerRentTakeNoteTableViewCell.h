//
//  SummerRentTakeNoteTableViewCell.h
//  WeCommunity
//
//  Created by madarax on 15/11/9.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SummerRentTakeNoteTableViewCell : UITableViewCell

@property (nonatomic ,weak) IBOutlet UIView *bgView;
@property (nonatomic ,weak) IBOutlet UILabel *cellTimeLab;
@property (nonatomic ,weak) IBOutlet UILabel *cellNameLab;
@property (nonatomic ,weak) IBOutlet UILabel *cellPhoneNumber;
@property (nonatomic ,weak) IBOutlet UIButton *cellBtnPhone;

@end
