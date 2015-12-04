//
//  TextPostViewController.m
//  WeCommunity
//
//  Created by Harry on 7/21/15.
//  Copyright (c) 2015 Harry. All rights reserved.
// 发布，报修，表扬，批评
#import "UIViewController+HUD.h"
#import "TextPostViewController.h"

#import "SummerPriceListViewController.h"
#define FONT_COLOR [UIColor colorWithWhite:0.533 alpha:1.000]

@interface TextPostViewController ()<UITextViewDelegate ,CameraImageViewDelegate ,MWPhotoBrowserDelegate ,UIPickerViewDataSource ,UIPickerViewDelegate>
{
    NSMutableArray *photos;
    NSDictionary *dicPhoneNumber;
    NSMutableArray *arrRoomAddress;
    UIButton *btnAddress;
    UIPickerView *pickerView;
    NSDictionary *dicSelectAddress;
    UILabel *labAddress;
    UIView *bgNamePhone;
    
    UIView *bgContentView;/**<输入内容View*/
    UIView *bgAddressView;/**<电话View*/
}
@end

@implementation TextPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    photos = [[NSMutableArray alloc] init];
    if ([self.function isEqualToString:@"complaint"] || [self.function isEqualToString:@"praise"] ) {
        UIBarButtonItem *postBtn = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(post:)];
        self.navigationItem.rightBarButtonItem = postBtn;
        
    }else if([self.function isEqualToString:@"repair"]) {
        UIBarButtonItem *postBtn = [[UIBarButtonItem alloc] initWithTitle:@"价格单" style:UIBarButtonItemStylePlain target:self action:@selector(priceList)];
        self.navigationItem.rightBarButtonItem = postBtn;
        arrRoomAddress = [[NSMutableArray alloc] init];
        [self getCommunityHoom];
    }
    
    self.user = [[User alloc] initWithData];
    self.loadingView = [[LoadingView alloc] initWithFrame:self.view.frame];
    self.loadingView.titleLabel.text = @"正在上传";
    [self setupAppearance];
    self.postType = @"";
    self.chosenImages = [[NSMutableArray alloc] initWithCapacity:0];
    self.chosenImagesSmall = [[NSMutableArray alloc] initWithCapacity:0];
    [self getCommunityPhone];
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
        [self.functionView setupFunctionViewFirst:@"房屋维修" title1:@"房屋维修" Second:@"公共设施" title2:@"公共设施" Third:nil title3:nil Fourth:nil title4:nil Fifth:nil title5:nil Sixth:nil title6:nil ];
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
    bgContentView = [[UIView alloc] initWithFrame:CGRectMake(10, textY, SCREENSIZE.width - 20, 160 + 90)];
    bgContentView.backgroundColor = [UIColor colorWithWhite:0.969 alpha:1.000];
    bgContentView.layer.cornerRadius = 3;
    bgContentView.layer.masksToBounds = YES;
    [self.scrollView addSubview:bgContentView];
    
    self.describleView=[[SAMTextView alloc] initWithFrame:CGRectMake(0, 0, SCREENSIZE.width - 20, 160)];
    if ([self.function isEqualToString:@"praise"]) {
        self.describleView.placeholder = @"物业服务很好，赞一个";
    }else{
        self.describleView.placeholder = @"说点什么吧...";
    }
    self.describleView.textColor = [UIColor colorWithWhite:0.533 alpha:1.000];
    self.describleView.backgroundColor = [UIColor clearColor];
    self.describleView.font=[UIFont fontWithName:@"Arial" size:15];
    self.describleView.returnKeyType = UIReturnKeyDone;
    self.describleView.delegate = self;
    [bgContentView addSubview:self.describleView];
    
    self.cameraView = [[CameraImageView alloc] initWithFrame:CGRectMake(10, self.describleView.frame.origin.y + self.describleView.frame.size.height + 5, self.view.frame.size.width-20, 160)];
    self.cameraView.delegate = self;
    [self.cameraView.addImageBtn addTarget:self action:@selector(imagePicker:) forControlEvents:UIControlEventTouchUpInside];
    [bgContentView addSubview:self.cameraView];
    
    if (![self.function isEqualToString:@"praise"]) {
        bgNamePhone = [[UIView alloc] initWithFrame:CGRectMake(10, bgContentView.frame.origin.y + bgContentView.frame.size.height + 10, SCREENSIZE.width - 20, 90)];
        bgNamePhone.layer.cornerRadius = 5;
        bgNamePhone.layer.masksToBounds = YES;
        bgNamePhone.backgroundColor = [UIColor colorWithWhite:0.969 alpha:1.000];
        bgNamePhone.layer.borderColor = [UIColor colorWithWhite:0.851 alpha:1.000].CGColor;
        bgNamePhone.layer.borderWidth = .5;
        
        [self.scrollView addSubview:bgNamePhone];
        
        CALayer *lineLayer = [[CALayer alloc] init];
        lineLayer.frame = CGRectMake(0, bgNamePhone.frame.size.height/2, SCREENSIZE.width - 20, .5);
        lineLayer.backgroundColor = [UIColor colorWithWhite:0.851 alpha:1.000].CGColor;
        [bgNamePhone.layer addSublayer:lineLayer];
        
        self.nickNameField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, bgNamePhone.frame.size.width-20, 45)];
        self.nickNameField.textColor = [UIColor colorWithWhite:0.533 alpha:1.000];
        self.nickNameField.placeholder = @"昵称";
        self.nickNameField.textColor = FONT_COLOR;
        self.nickNameField.text = self.user.nickName;
        [bgNamePhone addSubview:self.nickNameField];
        
        self.phoneField = [[UITextField alloc] initWithFrame:CGRectMake(self.nickNameField.frame.origin.x, self.nickNameField.frame.origin.y+self.nickNameField.frame.size.height+1, self.nickNameField.frame.size.width, self.nickNameField.frame.size.height)];
        self.phoneField.placeholder = @"手机号";
        self.phoneField.text = self.user.userName;
        self.phoneField.textColor = FONT_COLOR;
        [bgNamePhone addSubview:self.phoneField];
    }
    
    if([self.function isEqualToString:@"repair"]){
        bgAddressView = [[UIView alloc] initWithFrame:CGRectMake(bgContentView.frame.origin.x, bgNamePhone.frame.origin.y + bgNamePhone.frame.size.height + 10, bgContentView.frame.size.width, 45)];
        bgAddressView.layer.borderColor = [UIColor colorWithWhite:0.851 alpha:1.000].CGColor;
        bgAddressView.layer.borderWidth = .5;
        bgAddressView.layer.cornerRadius = 5;
        bgAddressView.layer.masksToBounds = YES;
        bgAddressView.backgroundColor = bgNamePhone.backgroundColor;
        [self.scrollView addSubview:bgAddressView];
        
        labAddress = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, bgNamePhone.frame.size.width - 10, 45)];
        labAddress.textColor = FONT_COLOR;
        labAddress.text = @"维修地址：";
        [bgAddressView addSubview:labAddress];
        
        btnAddress = [UIButton buttonWithType:UIButtonTypeCustom];
        btnAddress.frame = CGRectMake(0, 0, bgContentView.frame.size.width, 45);
        
        btnAddress.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btnAddress addTarget:self action:@selector(btnSelectRoom) forControlEvents:UIControlEventTouchUpInside];
        [btnAddress roundRect];
//        [btnAddress setBackgroundColor:[UIColor redColor]];
        [btnAddress setTitleColor:FONT_COLOR forState:UIControlStateNormal];
        [bgAddressView addSubview:btnAddress];
        
        
        
        BottomButton *bottomBtn = [[BottomButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 50)];
        [bottomBtn.secondBtn addTarget:self action:@selector(post:) forControlEvents:UIControlEventTouchUpInside];
        [bottomBtn.firstBtn addTarget:self action:@selector(phonePost:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:bottomBtn];   
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getCommunityPhone{
    [Networking retrieveData:get_COMMNITY_PHONE_NMBER parameters:@{@"communityId": [Util getCommunityID]} success:^(id responseObject) {
        dicPhoneNumber = responseObject;
        NSLog(@"-->%@",responseObject);
    }];
}

- (void)getCommunityHoom{
    [Networking retrieveData:GET_AUTHC_HOUSE parameters:@{@"token": [User getUserToken],@"communityId":[Util getCommunityID],@"page":@"1",@"row":@"30"} success:^(id responseObject) {
        NSLog(@"---->%@",responseObject);
        arrRoomAddress = responseObject;
    }];
}

- (void)confirmsAddPhotosOrDelete{
    // 设置不同的输入框位置
    CGFloat textY = 300;
    
    if([self.function isEqualToString:@"repair"]) {
        textY = 200;
    }
    if (self.chosenImages.count > 3) {
        bgContentView.frame = CGRectMake(10, textY, SCREENSIZE.width - 20, 160 + 90 + 80);
    }else{
        bgContentView.frame = CGRectMake(10, textY, SCREENSIZE.width - 20, 160 + 90);
    }
    bgNamePhone.frame = CGRectMake(10, bgContentView.frame.origin.y + bgContentView.frame.size.height + 10, SCREENSIZE.width - 20, 90);
    bgAddressView.frame = CGRectMake(bgContentView.frame.origin.x, bgNamePhone.frame.origin.y + bgNamePhone.frame.size.height + 10, bgContentView.frame.size.width, 45);
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
            self.repareType = ReparePostTypePublicFacility;
            self.postID = [NSNumber numberWithInt:1+i];
            break;
        case 2:
            [self.functionView.secondItem chosen];
            self.repareType = ReparePostTypeHome;
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


# pragma mark retrieve data 价格单

-(void)priceList{
    [self.navigationController pushViewController:[[SummerPriceListViewController alloc] init] animated:YES];
}

-(void)post:(id)sender{
    if (self.postID == nil) {
        [self showHint:@"请选择分类"];
    }else{
        if ([self.function isEqualToString:@"repair"]) {
            if (self.describleView.text.length < 1) {
                [self showHint:@"内容不能为空"];
                return;
            }
            if (dicSelectAddress == nil) {
                [self showHint:@"请选择房屋号"];
                return;
            }
        }
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
//电话报修
- (void)phonePost:(UIButton *)sender{
    if (dicPhoneNumber[@"phone"]&&![dicPhoneNumber[@"phone"] isEqualToString:@" "]) {
        NSString *phoneNumberStr = [NSString stringWithFormat:@"telprompt://%@",[dicPhoneNumber[@"phone"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        NSURL *urlPhone = [NSURL URLWithString:phoneNumberStr];
        if ([[UIApplication sharedApplication] canOpenURL:urlPhone]) {
            [[UIApplication sharedApplication] openURL:urlPhone];
        }else{
            [self showHint:@"当前设备不支持打电话哦"];
        }
    }else{
        [self showHint:@"暂无当前小区的电话"];
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
        NSString *tempStr;
        if (self.describleView.text.length < 1) {
            tempStr = @"说点什么";
        }else{
            tempStr = self.describleView.text;
        }
        if (pictures.count>0) {
            if (self.repareType == ReparePostTypeHome) {
                self.postID = [NSNumber numberWithInteger:3];
            }else{
                self.postID = [NSNumber numberWithInteger:1];
            }
            parameters = @{@"token":[User getUserToken],@"communityId":[Util getCommunityID],@"content":tempStr,@"houseId":dicSelectAddress[@"id"],@"pictures":pictures,@"repairTypeId":self.postID,@"name":self.nickNameField.text,@"phone":self.phoneField.text};
        }else{
            if (self.repareType == ReparePostTypeHome) {
                self.postID = [NSNumber numberWithInteger:3];
            }else{
                self.postID = [NSNumber numberWithInteger:1];
            }
            parameters = @{@"token":[User getUserToken],@"houseId":dicSelectAddress[@"id"],@"communityId":[Util getCommunityID],@"content":tempStr,@"repairTypeId":self.postID,@"name":self.nickNameField.text,@"phone":self.phoneField.text};
        }
        
    }else if ([self.function isEqualToString:@"praise"]){
        NSString *tempStr;
        if (self.describleView.text.length < 1) {
            tempStr = @"物业服务很好，赞一个";
        }else{
            tempStr = self.describleView.text;
        }
        url = praise_add;
        parameters = @{@"token":[User getUserToken],@"communityId":[Util getCommunityID],@"praiseTypeId":self.postID,@"content":tempStr,@"pictures":pictures};
    }
    
    [Networking retrieveData:url parameters:parameters success:^(id responseObject) {
        if (responseObject) {
            [self showHint:@"发布成功"];
        }
        [self.delegate issueInformationSeccess];
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
            [self.chosenImagesSmall addObject:[Util scaleToSize:img size:CGSizeMake(100, 100)]];
            
            if (idx==0 && self.chosenImages.count == 1) {
                
            }
            
        }];
        [self.cameraView chuckSubViews];
        [self.cameraView configureImage:self.chosenImagesSmall];
        [self confirmsAddPhotosOrDelete];
        
        [self.cameraView.addImageBtn addTarget:self action:@selector(imagePicker:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

#pragma mark - cameraViewDelegate

- (void)returnTapImageViewTagIndex:(NSInteger)index{
    if (photos) {
        [photos removeAllObjects];
    }
    for (int i = 0; i < self.chosenImagesSmall.count; i++) {
        MWPhoto *photo = [MWPhoto photoWithImage:self.chosenImages[i]];
        [photos addObject:photo];
    }
    // Create browser
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser = [Util fullImageSetting:browser];
    browser.displayNavArrows = YES;
    [browser setCurrentPhotoIndex:index];
    [self.navigationController pushViewController:browser animated:YES];
}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < photos.count)
        return [photos objectAtIndex:index];
    return nil;
}

- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index{
    [photos removeObjectAtIndex:index];
    
    [self.chosenImages removeObjectAtIndex:index];
    [self.chosenImagesSmall removeObjectAtIndex:index];
    if (self.chosenImages.count < 1) {
        [photos removeAllObjects];
        [self.navigationController popViewControllerAnimated:YES];
    }
    [photoBrowser reloadData];
    [self.cameraView chuckSubViews];
    [self.cameraView configureImage:self.chosenImagesSmall];
    [self confirmsAddPhotosOrDelete];
    [self.cameraView.addImageBtn addTarget:self action:@selector(imagePicker:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnSelectRoom{
    dicSelectAddress = arrRoomAddress[0];
    NSString *str = [NSString stringWithFormat:@"维修地址：%@",[dicSelectAddress[@"parentNames"] componentsJoinedByString:@""]];
    [pickerView removeFromSuperview];
    labAddress.text = str;
    if (arrRoomAddress.count == 1) {
        return;
    }
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, bgAddressView.frame.origin.y + bgAddressView.frame.size.height, SCREENSIZE.width, 200)];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [self.scrollView addSubview:pickerView];
}

#pragma mark - UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return arrRoomAddress.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSDictionary *dicTemp = arrRoomAddress[row];
    return [dicTemp[@"parentNames"] componentsJoinedByString:@""];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    dicSelectAddress = arrRoomAddress[row];
    NSString *str = [NSString stringWithFormat:@"维修地址：%@",[dicSelectAddress[@"parentNames"] componentsJoinedByString:@""]];
    labAddress.text = str;
    [self->pickerView removeFromSuperview];
}

@end
