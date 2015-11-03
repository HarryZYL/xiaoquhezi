//
//  BasicTableViewCell.h
//  WeCommunity
//
//  Created by Harry on 7/26/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Accreditation.h"
#import "GrayLine.h"

@interface BasicTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *iconImage;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *priceUnitLabel;
@property (nonatomic,strong) UILabel *dateLabel;
@property (nonatomic,strong) GrayLine *grayLine;
@property (nonatomic,strong) GrayLine *grayLine2;
@property (nonatomic,strong) UIImageView *dealImage;
@property (nonatomic,strong) UIImageView *commentImage;
@property (nonatomic,strong) UILabel *commentLabel;
@property (nonatomic,strong) UILabel *userLabel;
@property (nonatomic,strong) UIButton *funcitonBtn;
@property (nonatomic,strong) UIView *backgroundImg;
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UIImageView *picture1;
@property (nonatomic,strong) UIImageView *picture2;
@property (nonatomic,strong) UIImageView *picture3;

@property (nonatomic,strong) UIButton *btnReAuth;

-(void)setCellStyle;
-(void)clearCellStyle;
-(void)configureLikeCellImage:(NSString*)image title:(NSString *)title userName:(NSString *)username date:(NSString*)date pictures:(NSArray*)pictures;
-(void)configureLikeCell:(NSString*)likeCount;
-(void)configureAccreditationCell:(NSDictionary*)data;
-(void)configureBillCellTitle:(NSString*)title price:(NSString*)price image:(UIImage*)image;
-(void) configureTextCellImage:(NSURL*)image title:(NSString *)title date:(NSString*)date deal:(NSString*)deal pictures:(NSArray*)pictures detail:(BOOL)detailDisplay;
+(CGFloat)getTextDetailHeight:(NSString*)title picture:(NSArray*)pictures;
-(void)configureNoticeCellTitle:(NSString *)title detail:(NSString *)detail date:(NSString *)date top:(NSString*)top detail:(BOOL)detailDisplay  withReplyCount:(NSString *)replyCount;
+(CGFloat)getNoticeDetailHeight:(NSString*)detail;
-(void) configureRentCellImage:(NSString *)image title:(NSString *)title detail:(NSString*)detail price:(NSString*)price priceUnit:(NSString*)priceUnit date:(NSString*)date;
-(void)configureActivityCellImage:(NSURL *)image title:(NSString *)title detail:(NSString *)detail address:(NSString *)address date:(NSString *)date attends:(NSString*)attends;
-(void)configureUserDetailCell:(NSString*)title detail:(NSString*)detail;
@end
