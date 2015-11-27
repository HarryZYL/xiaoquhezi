//
//  BasicTableViewCell.m
//  WeCommunity
//
//  Created by Harry on 7/26/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "BasicTableViewCell.h"
#import "NSString+HTML.h"

@implementation BasicTableViewCell

#pragma mark lazy loading

-(UIView*)backgroundImg{
    if (!_backgroundImg) {
        _backgroundImg = [[UIView alloc] init];
        [self.contentView addSubview:_backgroundImg];
        [self.contentView sendSubviewToBack:_backgroundImg];
    }
    return _backgroundImg;
}

-(UIImageView*)iconImage{
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] init];
        _iconImage.contentMode = UIViewContentModeScaleAspectFill;
        _iconImage.clipsToBounds = YES;
        [self.contentView addSubview:_iconImage];
    }
    return _iconImage;
}

-(UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UILabel*) detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_detailLabel];
    }
    return _detailLabel;
}

-(UILabel*) priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_priceLabel];
    }
    return _priceLabel;
}

-(UILabel*) priceUnitLabel{
    if (!_priceUnitLabel) {
        _priceUnitLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_priceUnitLabel];
    }
    return _priceUnitLabel;
}

-(UILabel*)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.0];
        [self.contentView addSubview:_dateLabel];
    }
    return _dateLabel;
}

-(GrayLine*)grayLine{
    if (!_grayLine) {
        _grayLine = [[GrayLine alloc] init];
        [self.contentView addSubview:_grayLine];
    }
    return _grayLine;
}

-(GrayLine*)grayLine2{
    if (!_grayLine2) {
        _grayLine2 = [[GrayLine alloc] init];
        [self.contentView addSubview:_grayLine2];
    }
    return _grayLine2;
}

- (UIButton *)btnReAuth{
    if (_btnReAuth) {
        _btnReAuth = [[UIButton alloc] init];
        [self.contentView addSubview:_btnReAuth];
    }
    return _btnReAuth;
}

-(UIImageView*)dealImage{
    if (!_dealImage) {
        _dealImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_dealImage];
    }
    return _dealImage;
}

- (UIButton *)cellAccreditationBtn{
    if (!_cellAccreditationBtn) {
        _cellAccreditationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_cellAccreditationBtn];
    }
    return _cellAccreditationBtn;
}

-(UIImageView*)commentImage{
    if (!_commentImage) {
        _commentImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_commentImage];
    }
    return _commentImage;
}

-(UILabel*)commentLabel{
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_commentLabel];
    }
    return _commentLabel;
}

-(UILabel*)userLabel{
    if (!_userLabel) {
        _userLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_userLabel];
    }
    return _userLabel;
}

-(UIButton*)funcitonBtn{
    if (!_funcitonBtn) {
        _funcitonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_funcitonBtn];
    }
    return _funcitonBtn;
}

-(UITextField*)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        [self.contentView addSubview:_textField];
    }
    return _textField;
}

-(UIImageView*)picture1{
    if (!_picture1) {
        _picture1 = [[UIImageView alloc] init];
        [self.contentView addSubview:_picture1];
    }
    return _picture1;
}

-(UIImageView*)picture2{
    if (!_picture2) {
        _picture2 = [[UIImageView alloc] init];
        [self.contentView addSubview:_picture2];
    }
    return _picture2;
}

-(UIImageView*)picture3{
    if (!_picture3) {
        _picture3 = [[UIImageView alloc] init];
        [self.contentView addSubview:_picture3];
    }
    return _picture3;
}

-(void)setCellStyle{
    self.backgroundImg.frame =CGRectMake(0, 0, self.contentView.frame.size.width-20, self.contentView.frame.size.height-10);
    self.backgroundImg.center = CGPointMake(self.contentView.frame.size.width/2, self.contentView.frame.size.height/2);
    self.backgroundImg.layer.masksToBounds = YES;
    self.backgroundImg.layer.cornerRadius = 5;
    self.backgroundImg.layer.borderWidth = 1;
    self.backgroundImg.layer.borderColor = [[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1] CGColor];
    self.backgroundImg.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

-(void)clearCellStyle{
    self.backgroundImg.frame = CGRectMake(0, 0, 0, 0);
    self.contentView.backgroundColor = [UIColor whiteColor];
}

#pragma mark confijure cell 


//Accreditation function

-(void)configureAccreditationCell:(NSDictionary*)data{
    
    Accreditation *accreditation = [[Accreditation alloc] initWithData:data];
    
    UIFont *font = [UIFont fontWithName:fontName size:18.0f];
    CGSize stringsize = [accreditation.realName sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    
    self.titleLabel.frame = CGRectMake(30, 10, stringsize.width, 30);
    self.titleLabel.text = accreditation.realName;
    
    self.userLabel.frame = CGRectMake(self.titleLabel.frame.size.width+self.titleLabel.frame.origin.x+3, self.titleLabel.frame.origin.y, 300, 30);
    self.userLabel.textColor = [UIColor grayColor];
    self.userLabel.font = [UIFont fontWithName:fontName size:13];
    self.userLabel.text = [NSString stringWithFormat:@"%@-%@",data[@"community"][@"name"],data[@"ownerTypeName"]];
    
    CGFloat textHeight = 25;
    
    // cardTypeName
    self.detailLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y+self.titleLabel.frame.size.height, 300, textHeight);
    [self.detailLabel grayColorStyle:15];
    self.detailLabel.text = [NSString stringWithFormat:@"证件号 %@",accreditation.cardNumber];
    //    self.detailLabel.text = [NSString stringWithFormat:@"证件号 %@ (%@)",accreditation.cardNumber,accreditation.cardTypeName]; 2015.10.20
    
    // building
    self.priceLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.detailLabel.frame.origin.y+self.detailLabel.frame.size.height, 300, textHeight);
    [self.priceLabel grayColorStyle:15];
    self.priceLabel.text = [NSString stringWithFormat:@"%@室",[data[@"parentNames"] componentsJoinedByString:@""]];
    
    //house
//    self.priceUnitLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.priceLabel.frame.origin.y+self.priceLabel.frame.size.height, 300, textHeight);
//    [self.priceUnitLabel grayColorStyle:15];
//    self.priceUnitLabel.text = [NSString stringWithFormat:@"房间号 %@",accreditation.houseName];
    
    // gray line
    self.grayLine.frame = CGRectMake(20, self.priceLabel.frame.size.height+self.priceLabel.frame.origin.y+5, self.frame.size.width-40, 1);
    
    //date label
    self.dateLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.grayLine.frame.origin.y+5, 300, textHeight);
    [self.dateLabel grayColorStyle:15];
    self.dateLabel.text = accreditation.applyTime;
    
    //deal
    self.cellAccreditationBtn.frame = CGRectMake(self.contentView.frame.size.width - 90, self.grayLine.frame.origin.y, 80, textHeight+10);
    [self.cellAccreditationBtn configureButtonTitle:@"再次认证" backgroundColor:nil];
    [self.cellAccreditationBtn setTitleColor:THEMECOLOR forState:UIControlStateNormal];
//    [self.cellAccreditationBtn addTarget:self action:@selector(btnReAuthWithSelf:) forControlEvents:UIControlEventTouchUpInside];
    self.cellAccreditationBtn.hidden = YES;
    // deal image
    self.dealImage.frame = CGRectMake(self.frame.size.width-70, 20, 65, 40);
    if (![data[@"isDelete"] boolValue]) {
        if ([data[@"auditStatus"] isEqualToString:@"Pending"]) {
            self.dealImage.image = [UIImage imageNamed:@"deal"];
        }else if([data[@"auditStatus"] isEqualToString:@"Handling"]){
            self.dealImage.image = [UIImage imageNamed:@"dealing"];
        }else if ([data[@"auditStatus"] isEqualToString:@"Success"]){
            self.dealImage.image = [UIImage imageNamed:@"dealed"];
        }else {
            self.dealImage.image = [UIImage imageNamed:@"认证-失败-0"];
            self.cellAccreditationBtn.hidden = NO;
        }
    }else{
        self.dealImage.image = [UIImage imageNamed:@"已移出-Delete"];
    }
    [self setCellStyle];
    self.selectionStyle = NO;
}

//- (void)btnReAuthWithSelf:(UIButton *)sender{
//    if (_ButtonReturn) {
//        _ButtonReturn();
//    }
//}

//-(UILabel*)setLabel:(UILabel*)label{
//    label.font = [UIFont fontWithName:fontName size:15];
//    label.textColor = [UIColor grayColor];
//    return label;
//}
// bill function
-(void)configureBillCellTitle:(NSString *)title price:(NSString *)price image:(UIImage *)image{
    NSString *strTemp = [NSString stringWithFormat:@"%@:%.2f元",[[title componentsSeparatedByString:@"："] firstObject],[price floatValue]] ;
    
    CGRect titleRect = [strTemp boundingRectWithSize:CGSizeMake(self.frame.size.width-100, 80) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17]} context:nil];
    self.titleLabel.frame = CGRectMake(10, 10, self.frame.size.width-100, titleRect.size.height);
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.text = strTemp;
    self.titleLabel.textColor = [UIColor lightGrayColor];
    self.titleLabel.font = [UIFont fontWithName:fontName size:17];
    
    self.priceLabel.frame = CGRectMake(10, 50, 100, 20);
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f元",[price floatValue]];
    self.priceLabel.textColor = [UIColor redColor];
    self.priceLabel.font = [UIFont fontWithName:fontName size:15];
    
//    self.funcitonBtn.frame = CGRectMake(self.frame.size.width - 80, 10, 60, 60);
//    [self.funcitonBtn setImage:[UIImage imageNamed:@"advise"] forState:UIControlStateNormal];
    
}

// like cell praise funciton
-(void)configureLikeCellImage:(NSString *)image title:(NSString *)title userName:(NSString *)username date:(NSString *)date pictures:(NSArray*)pictures{
    
    self.selectionStyle = NO;
    self.iconImage.frame = CGRectMake(25, 15, 50, 50);
    [self.iconImage  sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"loadingLogo"]];
    
    self.userLabel.frame = CGRectMake(self.iconImage.frame.origin.x + self.iconImage.frame.size.width + 10, 10, self.frame.size.width - 100, 20);
    self.userLabel.text =username;
    
    
    self.titleLabel.text = title;
    [self.titleLabel grayColorStyle:15];
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.frame = CGRectMake(self.userLabel.frame.origin.x, self.userLabel.frame.origin.y + self.userLabel.frame.size.height, self.frame.size.width - 100, 40);
    
    [self rentSetupMutilPictures:pictures];
    
    self.dateLabel.font = [UIFont fontWithName:fontName size:14];
    self.dateLabel.text = date;
    
    [self setCellStyle];
}

-(void)configureLikeCell:(NSString*)likeCount{
    
    self.iconImage.frame = CGRectMake(0, 0, 100, 100);
    self.iconImage.center = CGPointMake(self.contentView.frame.size.width/2, self.frame.size.height/2);
    self.iconImage.image = [UIImage imageNamed:@"good"];
    
    self.titleLabel.frame = CGRectMake(0, self.iconImage.frame.size.height+self.iconImage.frame.origin.y+10, self.contentView.frame.size.width, 30);
    self.titleLabel.text = likeCount;
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont fontWithName:fontName size:18];
    self.titleLabel.numberOfLines = 1;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    self.userLabel.frame = CGRectMake(0, 0, 0, 0);
    self.dateLabel.frame = CGRectMake(0, 0, 0, 0);
    self.grayLine.frame = CGRectMake(0, 0, 0, 0);
    
    self.selectionStyle = NO;
    
    [self clearCellStyle];
    
    
}


//compaint and repair function
-(void) configureTextCellImage:(NSURL*)image title:(NSString *)title date:(NSString*)date deal:(NSString*)deal pictures:(NSArray*)pictures detail:(BOOL)detailDisplay withCount:(NSString *)strCount{
    
    self.selectionStyle = NO;
    
    self.iconImage.frame = CGRectMake(20, 15, 50, 50);
    [self.iconImage sd_setImageWithURL:image placeholderImage:[UIImage imageNamed:@"advise"]];
    
    UIFont *font = [UIFont fontWithName:fontName size:14];
    CGFloat height = [Util getHeightForString:title width:self.contentView.frame.size.width-200 font:font];
    
    if (detailDisplay) {
        self.titleLabel.frame = CGRectMake(self.iconImage.frame.size.width+40, 10,self.contentView.frame.size.width-200 , MAX(height, 50));
        self.titleLabel.numberOfLines = 0;
    }else{
        self.titleLabel.frame = CGRectMake(self.iconImage.frame.size.width+40, 10,self.contentView.frame.size.width-200 , 50);
        self.titleLabel.numberOfLines = 2;
        [self setCellStyle];
    }
    
    self.titleLabel.textAlignment = NSTextAlignmentNatural;
    self.titleLabel.text = title;
    self.titleLabel.font = font;
    
    [self rentSetupMutilPictures:pictures];
    
    self.dateLabel.font = [UIFont fontWithName:fontName size:15];
    self.dateLabel.text = date;

    self.commentImage.frame = CGRectMake(self.frame.size.width-60, self.dateLabel.frame.origin.y, 20, 20);
    self.commentImage.image = [UIImage imageNamed:@"comment"];
    
    self.commentLabel.frame = CGRectMake(self.commentImage.frame.origin.x+30, self.commentImage.frame.origin.y, 50, 20);
    self.commentLabel.textColor = [UIColor lightGrayColor];
    self.commentLabel.text = [NSString stringWithFormat:@"%@",strCount];
    
    
    self.dealImage.frame = CGRectMake(self.frame.size.width-70, 20, 65, 40);
    
    if ([deal isEqualToString:@"Pending"]) {
        self.dealImage.image = [UIImage imageNamed:@"deal1"];
    }else if([deal isEqualToString:@"Handling"]){
        self.dealImage.image = [UIImage imageNamed:@"dealing1"];
    }else if ([deal isEqualToString:@"Success"]){
        self.dealImage.image = [UIImage imageNamed:@"dealed1"];
    }
    
    
}

+(CGFloat)getTextDetailHeight:(NSString*)title picture:(NSArray*)pictures{
    UIFont *font = [UIFont fontWithName:fontName size:17];
    CGFloat height = [Util getHeightForString:title width:SCREENSIZE.width-200 font:font];
    CGFloat pictureHeight = 0;
    if (![pictures isEqual:[NSNull null]]) {
        if (![pictures[0] isEqualToString:@""]) {
            pictureHeight = 55;
        }
    }
    return MAX(height, 50) + pictureHeight + 60;
}

-(void)rentSetupMutilPictures:(NSArray*)pictures{

    CGFloat height = 60;
    
    if (![pictures isEqual:[NSNull null]]) {
        if ([pictures[0] isEqualToString:@""]) {
            
            [self setupPictures];
            
        }else{
            self.picture1.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y+self.titleLabel.frame.size.height, height, height );
            [self.picture1 sd_setImageWithURL:[NSURL URLWithString:pictures[0]] placeholderImage:[UIImage imageNamed:@"loadingLogo"]];
            self.picture2.frame = CGRectMake(self.picture1.frame.origin.x + self.picture1.frame.size.width +10 , self.picture1.frame.origin.y, height, height);
            self.picture3.frame = CGRectMake(self.picture2.frame.origin.x + self.picture2.frame.size.width +10 , self.picture1.frame.origin.y, height, height);
            
            if (pictures.count == 2) {
                [self.picture2 sd_setImageWithURL:[NSURL URLWithString:pictures[1]] placeholderImage:[UIImage imageNamed:@"loadingLogo"]];
            }else if (pictures.count >2){
                [self.picture2 sd_setImageWithURL:[NSURL URLWithString:pictures[1]] placeholderImage:[UIImage imageNamed:@"loadingLogo"]];
                [self.picture3 sd_setImageWithURL:[NSURL URLWithString:pictures[2]] placeholderImage:[UIImage imageNamed:@"loadingLogo"]];
            }
            
            self.grayLine.frame = CGRectMake(20, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height +75,self.contentView.frame.size.width-40 , 1);
            self.dateLabel.frame = CGRectMake(20, self.grayLine.frame.origin.y + 5, 200, 20);
        }
        
    }else{
        [self setupPictures];
    }
    

}

-(void)setupPictures{
    self.picture1.image = nil;
    self.picture2.image = nil;
    self.picture3.image = nil;
    self.grayLine.frame = CGRectMake(20, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 15,self.contentView.frame.size.width-40 , 1);
    self.dateLabel.frame = CGRectMake(20, self.grayLine.frame.origin.y + 5, 200, 20);
}

//notice
-(void)configureNoticeCellTitle:(NSString *)title detail:(NSString *)detail date:(NSString *)date top:(NSString*)top detail:(BOOL)detailDisplay withReplyCount:(NSString *)replyCount{
    
    self.selectionStyle = NO;
    
    self.titleLabel.frame = CGRectMake(10, 10, self.contentView.frame.size.width-20, 20);
    self.titleLabel.textColor = [UIColor colorWithWhite:0.259 alpha:1.000];
    if ([top isEqualToString:@"1"]) {
        self.titleLabel.text = [NSString stringWithFormat:@"[置顶]%@",title];
        self.titleLabel.textColor = [UIColor redColor];
    }else{
        self.titleLabel.text = title;
    }
    
    UIFont *font = [UIFont fontWithName:fontName size:15];
    CGFloat detailHeight = [Util getHeightForString:detail width: self.contentView.frame.size.width-2*self.titleLabel.frame.origin.x font:font];
    
    if (detailDisplay) {
        self.detailLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.x + self.titleLabel.frame.size.height, self.contentView.frame.size.width-2*self.titleLabel.frame.origin.x, detailHeight);
        self.detailLabel.numberOfLines = 0;

    }else{
        self.detailLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.x + self.titleLabel.frame.size.height, self.contentView.frame.size.width-2*self.titleLabel.frame.origin.x, 60);
        self.detailLabel.numberOfLines = 4;
    }
    
    self.detailLabel.text = detail;
    self.detailLabel.font = font;
    [self.detailLabel grayColorStyle:15];
    self.detailLabel.textColor = [UIColor colorWithWhite:0.463 alpha:1.000];
    
    self.grayLine.frame = CGRectMake(0,self.detailLabel.frame.origin.y + self.detailLabel.frame.size.height +10 , self.contentView.frame.size.width, 1);
    
    self.dateLabel.frame = CGRectMake(10, self.grayLine.frame.origin.y + 5, 200, 20);
    self.dateLabel.font = [UIFont fontWithName:fontName size:14];
    self.dateLabel.text = date;
    
    if (!detailDisplay) {
        self.grayLine2.frame = CGRectMake(0, self.frame.size.height-10, SCREENSIZE.width, 10);
        self.grayLine2.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.957 alpha:1.000];
    }
    self.commentImage.frame = CGRectMake(self.frame.size.width-60, self.dateLabel.frame.origin.y, 20, 20);
    self.commentImage.image = [UIImage imageNamed:@"comment"];
    
    self.commentLabel.frame = CGRectMake(self.frame.size.width - 40, self.dateLabel.frame.origin.y, 30, 20);
    self.commentLabel.textColor = [UIColor colorWithWhite:0.533 alpha:1.000];
    self.commentLabel.font = [UIFont systemFontOfSize:14];
    self.commentLabel.textAlignment = NSTextAlignmentRight;
    self.commentLabel.text = [NSString stringWithFormat:@"%@", replyCount];
    
}

+(CGFloat)getNoticeDetailHeight:(NSString*)detail{
    
    UIFont *font = [UIFont fontWithName:fontName size:15];
    CGFloat detailHeight = [Util getHeightForString:detail width: SCREENSIZE.width-20 font:font];
    
    return detailHeight + 65;
}

//rent activity secondHand
-(void)configureRentCellImage:(NSString *)image title:(NSString *)title detail:(NSString *)detail price:(NSString *)price priceUnit:(NSString*)priceUnit date:(NSString *)date{
    
    self.selectionStyle = NO;

    self.iconImage.frame =CGRectMake(10, 10, 110, 80);
    
    NSURL *imageUrl = [NSURL URLWithString:image];
    
    [self.iconImage sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"loadingLogo"]];
    
    self.titleLabel.frame = CGRectMake(self.iconImage.frame.origin.x + self.iconImage.frame.size.width + 10 , 10, self.frame.size.width-140, 25);
    self.titleLabel.font = [UIFont fontWithName:fontName size:18];
    self.titleLabel.text = title;
    self.titleLabel.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0];
    
    
    self.detailLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height +5, self.frame.size.width-140, 20);
    [self.detailLabel grayColorStyle:15];
    self.detailLabel.text = detail;
    
    
    self.priceLabel.text = price;
    self.priceLabel.font =[UIFont fontWithName:fontName size:20];
    self.priceLabel.textColor = [UIColor redColor];
    UIFont *font = self.priceLabel.font;
    CGSize stringsize = [price sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    self.priceLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.frame.size.height - stringsize.height - 10, stringsize.width, stringsize.height);
    
    
    self.priceUnitLabel.frame = CGRectMake(self.priceLabel.frame.origin.x + self.priceLabel.frame.size.width,self.frame.size.height -28 , 80, 15);
    [self.priceUnitLabel grayColorStyle:15];
    self.priceUnitLabel.text = priceUnit;
    
    
    self.dateLabel.frame = CGRectMake(self.frame.size.width-50, self.priceUnitLabel.frame.origin.y, 40, 15);
    self.dateLabel.font = [UIFont fontWithName:fontName size:15];
    self.dateLabel.text = date;
    self.grayLine.frame = CGRectMake(0, self.contentView.frame.size.height, self.contentView.frame.size.width, .5);
}

//activity
-(void)configureActivityCellImage:(NSURL *)image title:(NSString *)title detail:(NSString *)detail address:(NSString *)address date:(NSString *)date attends:(NSString*)attends {
    
    self.selectionStyle = NO;
    
    self.iconImage.frame =CGRectMake(10, 10, 110, 80);
    [self.iconImage sd_setImageWithURL:image placeholderImage:[UIImage imageNamed:@"house1"]];
    
    self.titleLabel.frame = CGRectMake(self.iconImage.frame.origin.x + self.iconImage.frame.size.width + 10 , 10, self.frame.size.width-100, 25);
    self.titleLabel.font = [UIFont fontWithName:fontName size:18];
    self.titleLabel.text = title;
    self.titleLabel.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0];
    
    
    self.detailLabel.frame = CGRectMake(self.frame.size.width-80, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height +5, 80, 20);
    self.detailLabel.font = [UIFont fontWithName:fontName size:15];
    self.detailLabel.text = detail;
    self.detailLabel.textColor = [UIColor colorWithRed:77.0/255.0 green:192.0/255.0 blue:168.0/255.0 alpha:1.0];
    
    // address
    self.priceLabel.text = address;
    self.priceLabel.font =[UIFont fontWithName:fontName size:15];
    self.priceLabel.textColor = [UIColor grayColor];
    UIFont *font = self.priceLabel.font;
    CGSize stringsize = [address sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    self.priceLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.frame.size.height - stringsize.height - 10, self.contentView.frame.size.width-self.iconImage.frame.size.width - 60, stringsize.height);
    
    // attend
    self.priceUnitLabel.frame = CGRectMake(self.frame.size.width-30,self.frame.size.height -28 , 30, 20);
    self.priceUnitLabel.font =[UIFont fontWithName:fontName size:15];
    self.priceUnitLabel.text = attends;
    self.priceUnitLabel.textColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.0];
    
    self.funcitonBtn.frame = CGRectMake(self.frame.size.width-50, self.frame.size.height -28, 20, 20);
    [self.funcitonBtn setImage:[UIImage imageNamed:@"活动参加人数"] forState:UIControlStateNormal];
    
    //date
    self.dateLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height +5, self.frame.size.width-100, 20);
    self.dateLabel.font = [UIFont fontWithName:fontName size:15];
    self.dateLabel.text = date;
    
    self.grayLine.frame = CGRectMake(0, self.contentView.frame.size.height, self.contentView.frame.size.width, 1);
    
    
}

// user detail
-(void)configureUserDetailCell:(NSString*)title detail:(NSString*)detail{
    
    self.titleLabel.frame = CGRectMake(20, 10, 50, 30);
    self.titleLabel.text = title;
    
    
    UIFont *font = [UIFont fontWithName:fontName size:18.0f];
    CGSize stringsize = [detail sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    
    
    if (detail.length>30) {
        
        self.iconImage.frame = CGRectMake(self.frame.size.width-100, 10, 60 , 60);
        self.iconImage.layer.masksToBounds = YES;
        self.iconImage.layer.cornerRadius = self.iconImage.frame.size.width/2;
        [self.iconImage sd_setImageWithURL:[NSURL URLWithString:detail] placeholderImage:[UIImage imageNamed:@"smile.png"]];
        
        
    }else{
        self.detailLabel.frame = CGRectMake(self.frame.size.width-stringsize.width-35, 10, stringsize.width, 30);
        self.detailLabel.text = detail;
        self.detailLabel.textColor = [UIColor grayColor];
    }
    
    
    //    self.grayLine.frame = CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1);
    
    self.selectionStyle = NO;
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
}


@end
