//
//  SummerInputView.m
//  WeCommunity
//
//  Created by madarax on 15/11/2.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerInputView.h"
#import "UITapGestureRecognizer+Data.h"

#define SELECT_IMG_HIGHT 70
@interface SummerInputView ()<UITextFieldDelegate ,UIScrollViewDelegate>
@property (nonatomic ,strong)UIScrollView *mScrollView;
@end

@implementation SummerInputView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor colorWithWhite:0.851 alpha:1.000].CGColor;
        self.backgroundColor = [UIColor colorWithWhite:0.949 alpha:1.000];
        
        self.btnAddImg = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnAddImg.frame = CGRectMake(15, 11, 25, 25);
        [self.btnAddImg setBackgroundImage:[UIImage imageNamed:@"xiangce"] forState:UIControlStateNormal];
        [self addSubview:self.btnAddImg];
        
        self.summerInputLabNumbers = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        self.summerInputLabNumbers.textAlignment = NSTextAlignmentCenter;
        self.summerInputLabNumbers.backgroundColor = [UIColor redColor];
        self.summerInputLabNumbers.layer.cornerRadius = self.summerInputLabNumbers.frame.size.width/2;
        self.summerInputLabNumbers.layer.masksToBounds = YES;
        self.summerInputLabNumbers.hidden = YES;
        self.summerInputLabNumbers.textColor = [UIColor whiteColor];
        [self addSubview:self.summerInputLabNumbers];
        
        self.summerInputView = [[UITextField alloc] initWithFrame:CGRectMake(55, 8, SCREENSIZE.width - 110, 34)];

        self.summerInputView.placeholder = @"添加评论....";
        [self.summerInputView addTarget:self action:@selector(summerInputViewChanges:) forControlEvents:UIControlEventEditingChanged];
        self.summerInputView.delegate = self;
        self.summerInputView.borderStyle = UITextBorderStyleRoundedRect;
        [self addSubview:self.summerInputView];
        
        self.btnSenderMessage = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnSenderMessage.frame = CGRectMake(SCREENSIZE.width - 50, 0, 50, 50);
        [self.btnSenderMessage setTitle:@"发送" forState:UIControlStateNormal];
        self.btnSenderMessage.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.btnSenderMessage setTitleColor:[UIColor colorWithWhite:0.259 alpha:1.000] forState:UIControlStateNormal];
        [self addSubview:self.btnSenderMessage];
        
        _mScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, SCREENSIZE.width, SELECT_IMG_HIGHT + 20)];
        _mScrollView.contentSize = CGSizeMake(80, SELECT_IMG_HIGHT + 20);
        [self addSubview:_mScrollView];
        _btnSelectAdd = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSelectAdd.frame = CGRectMake(10, 10, 70, 70);
        [_btnSelectAdd addTarget:self action:@selector(addImagesView) forControlEvents:UIControlEventTouchUpInside];
        [_btnSelectAdd setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [_mScrollView addSubview:_btnSelectAdd];
    }
    return self;
}

- (void)summerInputViewChanges:(UITextField *)textField{
    if (textField.text.length == 0) {
        self.btnSenderMessage.frame = CGRectMake(SCREENSIZE.width - 50, 0, 50, 50);
        self.btnAddImg.hidden = NO;
    }
}

- (void)confirmsSelectImage:(NSArray *)imgArrary{
    if (imgArrary.count == 8) {
        self.btnSelectAdd.hidden = YES;
        _mScrollView.contentSize = CGSizeMake(10 + 80 * (imgArrary.count), 90);
    }else{
        _mScrollView.contentSize = CGSizeMake(10 + 80 * (imgArrary.count + 1), 90);
        self.btnSelectAdd.hidden = NO;
    }
    for (id imgSub in self.mScrollView.subviews) {
        if ([imgSub isKindOfClass:[UIImageView class]]) {
            [imgSub removeFromSuperview];
        }
    }
    for (NSInteger index = 0; index < imgArrary.count; index ++) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:imgArrary[index]];
        imgView.userInteractionEnabled = YES;
        NSInteger xLine = 10 + 80 * index;
        NSInteger yRow  = 10;
        imgView.frame = CGRectMake(xLine, yRow, 70, 70);
        [_mScrollView addSubview:imgView];
        UITapGestureRecognizer_Data *tapImg = [[UITapGestureRecognizer_Data alloc] initWithTarget:self action:@selector(selectImageViewCheck:)];
        tapImg.tapTagImg = index + 1;
        [imgView addGestureRecognizer:tapImg];
    }
    _btnSelectAdd.frame = CGRectMake(10 + 80 * imgArrary.count, 10, 70, 70);
}

- (void)selectImageViewCheck:(UITapGestureRecognizer_Data *)sender{
    if (self.tapImageView) {
        _tapImageView(sender.tapTagImg);
    }
}

- (void)addImagesView{
    if (self.btnAddImageViews) {
        _btnAddImageViews();
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
