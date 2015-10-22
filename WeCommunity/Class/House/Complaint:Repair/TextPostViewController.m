//
//  TextPostViewController.m
//  WeCommunity
//
//  Created by Harry on 7/21/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "TextPostViewController.h"

@interface TextPostViewController ()<UITextViewDelegate>

@end

@implementation TextPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([self.function isEqualToString:@"complaint"] || [self.function isEqualToString:@"praise"] ) {
        
        UIBarButtonItem *postBtn = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(post:)];
        self.navigationItem.rightBarButtonItem = postBtn;
        
    }else if([self.function isEqualToString:@"repair"]) {
        UIBarButtonItem *postBtn = [[UIBarButtonItem alloc] initWithTitle:@"价格单" style:UIBarButtonItemStylePlain target:self action:@selector(priceList)];
        self.navigationItem.rightBarButtonItem = postBtn;
    }
    
    
    self.user = [[User alloc] initWithData];

    self.loadingView = [[LoadingView alloc] initWithFrame:self.view.frame];
    self.loadingView.titleLabel.text = @"正在上传";
    [self setupAppearance];
    self.postType = @"";
    self.chosenImages = [[NSMutableArray alloc] initWithCapacity:9];
    self.chosenImagesSmall = [[NSMutableArray alloc] initWithCapacity:9];

}

-(void)setupAppearance{
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 900);
    [self.view addSubview:self.scrollView];
    
    self.functionView = [[FunctionView alloc] initWithFrame:CGRectMake(30, 80, self.view.frame.size.width-60, 200)];
    
    if ([self.function isEqualToString:@"complaint"] || [self.function isEqualToString:@"praise"] ) {
        
        [self.functionView setupFunctionViewFirst:@"服务" title1:@"服务" Second:@"绿化" title2:@"环境绿化" Third:@"报修" title3:@"设备保养" Fourth:@"保安" title4:@"治安秩序" Fifth:@"保洁" title5:@"保洁服务" Sixth:@"其他" title6:@"其他"];

    }else if([self.function isEqualToString:@"repair"]) {
        [self.functionView setupFunctionViewFirst:@"公共设施" title1:@"公共设施" Second:@"房屋维修" title2:@"房屋维修" Third:@"水电燃气" title3:@"水电燃气" Fourth:nil title4:nil Fifth:nil title5:nil Sixth:nil title6:nil ];
    }
    
    [self.functionView.firstItem.functionButton addTarget:self action:@selector(chosen:) forControlEvents:UIControlEventTouchUpInside];
    [self.functionView.secondItem.functionButton addTarget:self action:@selector(chosen:) forControlEvents:UIControlEventTouchUpInside];
    [self.functionView.thirdItem.functionButton addTarget:self action:@selector(chosen:) forControlEvents:UIControlEventTouchUpInside];
    [self.functionView.fourthItem.functionButton addTarget:self action:@selector(chosen:) forControlEvents:UIControlEventTouchUpInside];
    [self.functionView.fifthItem.functionButton addTarget:self action:@selector(chosen:) forControlEvents:UIControlEventTouchUpInside];
    [self.functionView.sixthItem.functionButton addTarget:self action:@selector(chosen:) forControlEvents:UIControlEventTouchUpInside];
    
    // 设置不同的输入框位置
    CGFloat textY = 300;
    
    if([self.function isEqualToString:@"repair"]) {
        textY = 200;
    }
    
    [self.scrollView addSubview:self.functionView];
    
    self.describleView=[[SAMTextView alloc] initWithFrame:CGRectMake(10, textY, self.view.frame.size.width-20, 100)];
    self.describleView.placeholder=@"说点什么";
    self.describleView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.5];
    self.describleView.font=[UIFont fontWithName:@"Arial" size:15];
    self.describleView.returnKeyType = UIReturnKeyDone;
    self.describleView.delegate = self;
    [self.scrollView addSubview:self.describleView];
    
    self.cameraView = [[CameraImageView alloc] initWithFrame:CGRectMake(10, self.describleView.frame.size.height+self.describleView.frame.origin.y+5, self.view.frame.size.width-20, 150)];
    [self.cameraView.addImageBtn addTarget:self action:@selector(imagePicker:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.cameraView];
    
    if (![self.function isEqualToString:@"praise"]) {
    self.nickNameField = [[UITextField alloc] initWithFrame:CGRectMake(self.describleView.frame.origin.x, self.cameraView.frame.origin.y+self.cameraView.frame.size.height+20, self.view.frame.size.width-2*self.describleView.frame.origin.x, 50)];
    self.nickNameField.placeholder = @"昵称";
    self.nickNameField.borderStyle = UITextBorderStyleRoundedRect;
    self.nickNameField.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.5];
    self.nickNameField.text = self.user.nickName;
    [self.scrollView addSubview:self.nickNameField];
    
    self.phoneField = [[UITextField alloc] initWithFrame:CGRectMake(self.nickNameField.frame.origin.x, self.nickNameField.frame.origin.y+self.nickNameField.frame.size.height+10, self.nickNameField.frame.size.width, self.nickNameField.frame.size.height)];
    self.phoneField.placeholder = @"手机号";
    self.phoneField.text = self.user.userName;
    self.phoneField.borderStyle = UITextBorderStyleRoundedRect;
    self.phoneField.backgroundColor =[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.5];
    [self.scrollView addSubview:self.phoneField];
    }
    
    if([self.function isEqualToString:@"repair"]){
        
        BottomButton *bottomBtn = [[BottomButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 50)];
        [bottomBtn.secondBtn addTarget:self action:@selector(post:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:bottomBtn];   
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)chosen:(id)sender{
    [self.functionView clearColor];
    UIButton *button = (UIButton*)sender;
    int i = 0;
    if ([self.function isEqualToString:@"praise"]) {
        i = 6;
    }
    
    switch (button.tag) {
        case 1:
            [self.functionView.firstItem chosen];
            self.postID = [NSNumber numberWithInt:1+i];
            break;
        case 2:
            [self.functionView.secondItem chosen];
            self.postID =[NSNumber numberWithInt:2+i];
            break;

        case 3:
            [self.functionView.thirdItem chosen];
            self.postID = [NSNumber numberWithInt:3+i];
            break;

        case 4:
            [self.functionView.fourthItem chosen];
            self.postID = [NSNumber numberWithInt:4+i];
            break;

        case 5:
            [self.functionView.fifthItem chosen];
            self.postID = [NSNumber numberWithInt:5+i];
            break;

        case 6:
            [self.functionView.sixthItem chosen];
            self.postID = [NSNumber numberWithInt:6+i];
            break;

            
        default:
            break;
    }
    
    
}


# pragma mark retrieve data

-(void)priceList{
    
}

-(void)post:(id)sender{
    
    if (self.postID == nil) {
        [Util alertNetworingError:@"请选择分类"];
    }else{
        [self.view addSubview:self.loadingView];
        if (self.chosenImages.count==0) {
            [self uploadInfo:@[]];
        }else{
            [Networking upload:self.chosenImages success:^(id responseObject) {
                [self uploadInfo:responseObject];
            }];
        }
        
    }
    
}

-(void)uploadInfo:(NSArray*)pictures{
//    小区信息 communityId
    
    NSDictionary *parameters = @{};
    NSString *url = @"";
    if ([self.function isEqualToString:@"complaint"]) {
        url =complaint_add;
        parameters = @{@"token":[User getUserToken],@"communityId":[Util getCommunityID],@"content":self.describleView.text,@"pictures":pictures,@"complaintTypeId":self.postID,@"name":self.nickNameField.text,@"phone":self.phoneField.text};
        
    }else if([self.function isEqualToString:@"repair"]){
        url = repair_add;
        parameters = @{@"token":[User getUserToken],@"communityId":[Util getCommunityID],@"content":self.describleView.text,@"pictures":pictures,@"repairTypeId":self.postID,@"name":self.nickNameField.text,@"phone":self.phoneField.text};
        
    }else if ([self.function isEqualToString:@"praise"]){
        url = praise_add;
        parameters = @{@"token":[User getUserToken],@"communityId":[Util getCommunityID],@"praiseTypeId":self.postID,@"content":self.describleView.text,@"pictures":pictures};
    }
    
    [Networking retrieveData:url parameters:parameters success:^(id responseObject) {
        [self.navigationController popViewControllerAnimated:YES];
    } addition:^{
        [self.loadingView removeFromSuperview];
    }];

}

#pragma mark UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark imagepicker

-(void)imagePicker:(id)sender{
    UzysAssetsPickerController *picker = [[UzysAssetsPickerController alloc] init];
    picker.delegate = self;
    picker.maximumNumberOfSelectionMedia = 8 - self.chosenImages.count;
    [self presentViewController:picker animated:YES completion:nil];
    
}

- (void)uzysAssetsPickerController:(UzysAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    
    if([[assets[0] valueForProperty:@"ALAssetPropertyType"] isEqualToString:@"ALAssetTypePhoto"]) //Photo
    {
        [assets enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ALAsset *representation = obj;
            
            UIImage *img = [UIImage imageWithCGImage:representation.defaultRepresentation.fullResolutionImage
                                               scale:representation.defaultRepresentation.scale
                                         orientation:(UIImageOrientation)representation.defaultRepresentation.orientation];
            
            [self.chosenImages addObject:img];
            [self.chosenImagesSmall addObject:[Util scaleToSize:img size:CGSizeMake(200, 200)]];
            
            if (idx==0 && self.chosenImages.count == 1) {
                
            }
            
        }];
        [self.cameraView configureImage:self.chosenImagesSmall];
        
    }
    
}

@end
