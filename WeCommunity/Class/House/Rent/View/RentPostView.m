//
//  RentPostView.m
//  WeCommunity
//
//  Created by Harry on 8/5/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "RentPostView.h"

@interface RentPostView()<UITextFieldDelegate>

@end

@implementation RentPostView

-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        //first part
//        self.headView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width/2)];
//        self.headView.image = [UIImage imageNamed:@"rentBg.png"];
//        [self addSubview:self.headView];
//        
//        CGRect workingFrame = CGRectMake(0, 0, 120, 120);
//        
//        self.imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.imageBtn.frame = workingFrame;
//        self.imageBtn.center = CGPointMake(self.headView.frame.size.width/2, self.headView.frame.size.height/2);
//        self.imageBtn.hidden = YES;
//        [self addSubview:self.imageBtn];
//        
//        self.imageCount = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, workingFrame.size.width, 20)];
//        self.imageCount.center = CGPointMake(self.headView.frame.size.width/2, self.headView.frame.size.height/2+workingFrame.size.height/2-10);
//        self.imageCount.textAlignment = NSTextAlignmentCenter;
//        self.imageCount.textColor = [UIColor whiteColor];
//        self.imageCount.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
//        self.imageCount.hidden = YES;
//        [self addSubview:self.imageCount];
//
//        
//        self.imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.imgBtn.frame = CGRectMake(0, 0, 100, 100);
//        self.imgBtn.center = CGPointMake(self.headView.frame.size.width/2, self.headView.frame.size.height/2);
//        [self.imgBtn setImage:[UIImage imageNamed:@"camera.png"] forState:UIControlStateNormal];
//        [self addSubview:self.imgBtn];
        
        
        
    }
    
    return self;
    
}

-(void)setupFirstPart{
    CGFloat textHeight = 45;
    // second part
    NSArray *firstArray = @[@"房型",@"户型",@"楼层",@"朝向"];
    NSArray *settingArray = @[@"室",@"厅",@"卫"];
    
    for (int i = 0 ; i<4; i++) {
        UILabel *title = [[UILabel alloc] init];
        title.frame = CGRectMake(10,self.headView.frame.size.height + 10+textHeight*i, 50, textHeight);
        title.textAlignment = NSTextAlignmentCenter;
        title.text = firstArray[i];
        [self addSubview:title];
        GrayLine *bottomLine = [[GrayLine alloc] initWithFrame:CGRectMake(8,self.headView.frame.size.height + 10+textHeight*(i+1), self.frame.size.width-16, 1)];
        [self addSubview:bottomLine];
        
        GrayLine *rightLine = [[GrayLine alloc] initWithFrame:CGRectMake(title.frame.size.width+title.frame.origin.x, title.frame.origin.y+4, 1, textHeight-8)];
        [self addSubview:rightLine];
        
        CGFloat labelWidth = bottomLine.frame.size.width - title.frame.size.width;
        
        switch (i) {
            case 0:
                self.houseTypeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                self.houseTypeBtn.frame = CGRectMake(0, 0, 200, textHeight);
                self.houseTypeBtn.center = CGPointMake(rightLine.frame.origin.x + labelWidth/2 , title.center.y);
                [self.houseTypeBtn setTitle:@"-点击选择房屋类型-" forState:UIControlStateNormal];
                self.houseTypeBtn.tag = 1;
                [self.houseTypeBtn setTintColor:[UIColor blackColor]];
                [self addSubview:self.houseTypeBtn];
                break;
            case 1:
                for (int j=0; j<3; j++) {
                    UILabel *setting = [[UILabel alloc] initWithFrame:CGRectMake(rightLine.frame.origin.x + (j+1)*labelWidth/3 -20, title.frame.origin.y, 20, textHeight)];
                    setting.text = settingArray[j];
                    [self addSubview:setting];
                }
                
                self.roomField = [[UITextField alloc] initWithFrame:CGRectMake(rightLine.frame.origin.x , title.frame.origin.y, labelWidth/3-30, textHeight)];
                self.roomField.delegate = self;
                self.roomField.keyboardType = UIKeyboardTypeNumberPad;
                self.roomField.textAlignment = NSTextAlignmentRight;
                [self addSubview:self.roomField];
                
                self.sittingRoomField = [[UITextField alloc] initWithFrame:CGRectMake(rightLine.frame.origin.x + labelWidth/3, title.frame.origin.y, labelWidth/3-30, textHeight)];
                self.sittingRoomField.delegate = self;
                self.sittingRoomField.keyboardType = UIKeyboardTypeNumberPad;
                self.sittingRoomField.textAlignment = NSTextAlignmentRight;
                [self addSubview:self.sittingRoomField];
                
                self.bathRoomField = [[UITextField alloc] initWithFrame:CGRectMake(rightLine.frame.origin.x +2*labelWidth/3, title.frame.origin.y, labelWidth/3-30, textHeight)];
                self.bathRoomField.delegate = self;
                self.bathRoomField.keyboardType = UIKeyboardTypeNumberPad;
                self.bathRoomField.textAlignment = NSTextAlignmentRight;
                [self addSubview:self.bathRoomField];
                
                break;
            case 2:
                for (int j=0; j<2; j++) {
                    NSArray *floorArr = @[@"/",@""];
                    UILabel *setting = [[UILabel alloc] initWithFrame:CGRectMake(rightLine.frame.origin.x + (j+1)*(bottomLine.frame.size.width - title.frame.size.width)/2 , title.frame.origin.y, 20, textHeight)];
                    setting.text = floorArr[j];
                    [self addSubview:setting];
                }
                
                self.floorField = [[UITextField alloc] initWithFrame:CGRectMake(rightLine.frame.origin.x , title.frame.origin.y,labelWidth/2-30 , textHeight)];
                self.floorField.keyboardType = UIKeyboardTypeNumberPad;
                self.floorField.textAlignment = NSTextAlignmentRight;
                self.floorField.delegate = self;
                self.floorField.placeholder = @"楼层数";
                [self addSubview:self.floorField];
                
                self.totalFloorField = [[UITextField alloc] initWithFrame:CGRectMake(rightLine.frame.origin.x +(bottomLine.frame.size.width - title.frame.size.width)/2, title.frame.origin.y, labelWidth/2 -30, textHeight)];
                self.totalFloorField.keyboardType = UIKeyboardTypeNumberPad;
                self.totalFloorField.textAlignment = NSTextAlignmentRight;
                self.totalFloorField.delegate = self;
                self.totalFloorField.placeholder = @"总楼层数";
                [self addSubview:self.totalFloorField];

                break;
            case 3:
                self.houseOrientationBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                self.houseOrientationBtn.frame = CGRectMake(0, 0, 200, textHeight);
                self.houseOrientationBtn.center = CGPointMake(rightLine.frame.origin.x + (bottomLine.frame.size.width - title.frame.size.width)/2 , title.center.y);
                [self.houseOrientationBtn setTitle:@"-点击选择房屋朝向-" forState:UIControlStateNormal];
                self.houseOrientationBtn.tag = 2;
                [self.houseOrientationBtn setTintColor:[UIColor blackColor]];
                [self addSubview:self.houseOrientationBtn];

                break;
            default:
                break;
        }
        
        
        
    }

}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == self.roomField && [self.houseTypeBtn.titleLabel.text isEqualToString:@"-点击选择房屋类型-"]) {
//        [self.delegate textFieldReturnWarning:@"请选择房屋类型"];
//        [self.roomField resignFirstResponder];
//        return;
    }else if (textField == self.sittingRoomField && (self.roomField.text.length < 1 || self.roomField.text.intValue < 1)){
        [self.delegate textFieldReturnWarning:@"房间不能为空，至少为1"];
        [self.roomField becomeFirstResponder];
        return;
    }else if (textField == self.bathRoomField && self.sittingRoomField.text.length < 1){
        [self.delegate textFieldReturnWarning:@"房间不能为空，至少为0"];
        [self.sittingRoomField becomeFirstResponder];
        return;
    }else if (textField == self.floorField && self.bathRoomField.text.length < 1){
        [self.delegate textFieldReturnWarning:@"房间不能为空，至少为0"];
        [self.bathRoomField becomeFirstResponder];
        return;
    }else if (textField == self.totalFloorField && self.floorField.text.length < 1){
        [self.delegate textFieldReturnWarning:@"楼层不能为空，至少为0"];
        [self.floorField becomeFirstResponder];
        return;
    }
    if (textField == self.priceField && self.areaField.text.length < 1) {
        [self.delegate textFieldReturnWarning:@"房间面积不能为空"];
        [self.areaField becomeFirstResponder];
        return;
    }
    if (textField == self.priceField && self.areaField.text.intValue < 1) {
        [self.delegate textFieldReturnWarning:@"房间面积不能太小哦"];
        [self.areaField becomeFirstResponder];
        return;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.totalFloorField && self.totalFloorField.text < self.floorField.text) {
        [self.delegate textFieldReturnWarning:@"楼层数不能大于总层数"];
        [self.totalFloorField becomeFirstResponder];
        return;
    }
    if (textField == self.priceField && self.priceField.text.length < 1) {
        [self.delegate textFieldReturnWarning:@"别忘记填写租金了"];
        [self.priceField becomeFirstResponder];
        return;
    }
    if (textField == self.priceField && self.priceField.text.intValue == 0) {
        [self.delegate textFieldReturnWarning:@"租金不能太小"];
        [self.priceField becomeFirstResponder];
        return;
    }
}

-(void)setupSecondPart{
    CGFloat textHeight = 45;
    // third part
    GrayLine *thirdLine = [[GrayLine alloc] initWithFrame:CGRectMake(0,0 , self.frame.size.width, 1)];
    [self addSubview:thirdLine];
    
    NSArray *thirdArray = @[@"面积",@"租金"];
    
    for (int i=0; i<2; i++) {
        UILabel *title = [[UILabel alloc] init];
        title.frame = CGRectMake(10,thirdLine.frame.origin.y +thirdLine.frame.size.height + textHeight*i, 50, textHeight);
        title.textAlignment = NSTextAlignmentCenter;
        title.text = thirdArray[i];
        [self addSubview:title];
        GrayLine *bottomLine = [[GrayLine alloc] initWithFrame:CGRectMake(8,title.frame.origin.y +textHeight, self.frame.size.width-16, 1)];
        [self addSubview:bottomLine];
        
        GrayLine *rightLine = [[GrayLine alloc] initWithFrame:CGRectMake(title.frame.size.width+title.frame.origin.x, title.frame.origin.y+4, 1, textHeight-8)];
        [self addSubview:rightLine];
        
        // the width on the right
//        CGFloat labelWidth = bottomLine.frame.size.width - title.frame.size.width;
        
        switch (i) {
            case 0:
                
                for (int j = 0; j<1; j++) {
                    UILabel *areaLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-50, title.frame.origin.y, 50, textHeight)];
                    areaLabel.text = @"平米";
                    [self addSubview:areaLabel];
                }
                
                self.areaField = [[UITextField alloc] initWithFrame:CGRectMake(rightLine.frame.origin.x+10, title.frame.origin.y, bottomLine.frame.size.width - title.frame.size.width -60, textHeight)];
                self.areaField.keyboardType = UIKeyboardTypeNumberPad;
                self.areaField.textAlignment = NSTextAlignmentRight;
                self.areaField.delegate = self;
                [self addSubview:self.areaField];

                break;
            case 1:
                for (int j = 0; j<1; j++) {
                    UILabel *areaLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-50, title.frame.origin.y, 50, textHeight)];
                    areaLabel.text = @"元/月";
                    [self addSubview:areaLabel];
                }
                
                self.priceField= [[UITextField alloc] initWithFrame:CGRectMake(rightLine.frame.origin.x+10, title.frame.origin.y, bottomLine.frame.size.width - title.frame.size.width -60, textHeight)];
                self.priceField.keyboardType = UIKeyboardTypeNumberPad;
                self.priceField.textAlignment = NSTextAlignmentRight;
                self.priceField.delegate = self;
                [self addSubview:self.priceField];

                break;
                
            default:
                break;
        }
        
    }

}

-(void)setupThirdPart{
    
    // fourth part
    CGFloat textHeight = 45;
    GrayLine *fourthLine = [[GrayLine alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
    [self addSubview:fourthLine];
    
    NSArray *fourthArray = @[@"标题",@"描述"];
    
    
    for (int i = 0; i<2; i++) {
        UILabel *title = [[UILabel alloc] init];
        title.frame = CGRectMake(10,fourthLine.frame.origin.y +fourthLine.frame.size.height + textHeight*i, 50, textHeight);
        title.textAlignment = NSTextAlignmentCenter;
        title.text = fourthArray[i];
        [self addSubview:title];
        GrayLine *bottomLine = [[GrayLine alloc] initWithFrame:CGRectMake(8,title.frame.origin.y +textHeight, self.frame.size.width-16, 1)];
        [self addSubview:bottomLine];
        
        GrayLine *rightLine = [[GrayLine alloc] initWithFrame:CGRectMake(title.frame.size.width+title.frame.origin.x, title.frame.origin.y+4, 1, textHeight-8)];
        [self addSubview:rightLine];
        
        // the width on the right
        CGFloat labelWidth = bottomLine.frame.size.width - title.frame.size.width;
        switch (i) {
            case 0:
                self.titleField = [[UITextField alloc] initWithFrame:CGRectMake(rightLine.frame.origin.x+5 , title.frame.origin.y,labelWidth-30 , textHeight)];
                self.titleField.placeholder = @"1-20个字";
                [self addSubview:self.titleField];
                
                break;
            case 1:
                self.contentField = [[UITextField alloc] initWithFrame:CGRectMake(rightLine.frame.origin.x+5 , title.frame.origin.y,labelWidth-30 , textHeight)];
                self.contentField.placeholder = @"交通配置等";
                [self addSubview:self.contentField];
                
                break;

            default:
                break;
        }
        
    }
    
    self.cameraView = [[CameraImageView alloc] initWithFrame:CGRectMake(10, self.contentField.frame.origin.y+self.contentField.frame.size.height+5, self.frame.size.width-10, 150)];
    [self addSubview:self.cameraView];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

@end
