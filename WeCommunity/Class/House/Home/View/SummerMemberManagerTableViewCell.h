//
//  SummerMemberManagerTableViewCell.h
//  WeCommunity
//
//  Created by madarax on 15/10/26.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SummerMemberManagerTableViewCell : UITableViewCell

@property (nonatomic ,weak) IBOutlet UIImageView *cellUserImg;
@property (nonatomic ,weak) IBOutlet UILabel *cellTitleName;
@property (nonatomic ,weak) IBOutlet UILabel *cellIDCard;
@property (nonatomic ,weak) IBOutlet UILabel *cellTime;

- (void)confirmMemberManagerCellWithData:(NSDictionary *)tempDic withIndexPath:(NSIndexPath *)indexPath;

@end
