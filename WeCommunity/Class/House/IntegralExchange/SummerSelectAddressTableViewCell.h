//
//  SummerSelectAddressTableViewCell.h
//  WeCommunity
//
//  Created by madarax on 15/12/10.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SummerSelectAddressTableViewCell : UITableViewCell

@property(nonatomic ,weak)IBOutlet UILabel *cellNameContent;
@property(nonatomic ,weak)IBOutlet UILabel *cellAddressLab;
@property(nonatomic ,weak)IBOutlet NSLayoutConstraint *bootomLayout;

- (void)confirmCellContentWithData:(NSDictionary *)dic;

@end
