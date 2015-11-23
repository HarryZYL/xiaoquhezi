//
//  RentPostViewController.m
//  WeCommunity
//
//  Created by Harry on 8/5/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "RentPostViewController.h"
#import "UIViewController+HUD.h"
#import <MobileCoreServices/UTCoreTypes.h>

@interface RentPostViewController ()<MWPhotoBrowserDelegate ,CameraImageViewDelegate ,UITextViewDelegate>
@property (nonatomic ,strong)UIView *detailView;
@property (nonatomic ,strong)NSMutableArray *photos;
@property (nonatomic ,strong)UITextField *titelField;
@property (nonatomic ,strong)UITextView *contentField;
@property (nonatomic ,strong)CameraImageView *cameraView;
@property (nonatomic ,strong)CATextLayer *placeHoderText;

@end

@implementation RentPostViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.houseData = [[HouseDeal alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    // Do any additional setup after loading the view.
    
    self.stepArray = @[@"基本信息",@"价格",@"发布"];
    self.title = self.stepArray[self.step];

    
    self.scollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scollView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    self.scollView.contentSize = CGSizeMake(self.view.frame.size.width, 780);
    [self.view addSubview:self.scollView];
    [self setupStepView:self.step];
    
    switch (self.step) {
        case 0:
            self.postView = [[RentPostView alloc]  initWithFrame:CGRectMake(0, 120, self.view.frame.size.width,190)] ;
            self.postView.delegate = self;
            [self.postView setupFirstPart];
            break;
        case 1:
            self.postView = [[RentPostView alloc]  initWithFrame:CGRectMake(0, 120, self.view.frame.size.width,92)] ;
            self.postView.delegate = self;
            [self.postView setupSecondPart];
            if (_houseDealType == SummerHouseDealTypeSale) {
                self.postView.areaLabel.text = @"元";
                UILabel *labPostView = (UILabel *)[self.postView viewWithTag:101];
                labPostView.text = @"售价";
            }
            break;
        case 2:
            self.detailView = [[UIView alloc]  initWithFrame:CGRectMake(0, 120, self.view.frame.size.width,330 - 90)] ;
            self.detailView.backgroundColor = [UIColor whiteColor];
            [self.scollView addSubview:self.detailView];
            _photos = [[NSMutableArray alloc] init];
            [self initWithDetailView];
            break;
            
        default:
            break;
    }
    

    self.postView.backgroundColor = [UIColor whiteColor];
    [self.postView.imgBtn addTarget:self action:@selector(imagePicker:) forControlEvents:UIControlEventTouchUpInside];
    [self.postView.houseTypeBtn addTarget:self action:@selector(selectPicker:) forControlEvents:UIControlEventTouchUpInside];
    [self.postView.houseOrientationBtn addTarget:self action:@selector(selectPicker:) forControlEvents:UIControlEventTouchUpInside];
    [self.postView.cameraView.addImageBtn addTarget:self action:@selector(imagePicker:) forControlEvents:UIControlEventTouchUpInside];
    [self.scollView addSubview:self.postView];
    
    [self setupSubmitBtn:self.step];
    
    self.houseTypeArr = @[@"普通住宅",@"商住两用",@"公寓",@"别墅",@"其他"];
    self.houseOrientationArr = @[@"东",@"西",@"南",@"北",@"东北",@"西北",@"东南",@"西南",@"东西",@"南北"];
    self.pickerStr = nil;
    
    self.loadingView = [[LoadingView alloc] initWithFrame:self.view.frame];
    self.loadingView.titleLabel.text = @"正在上传";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initWithDetailView{
    CGFloat textHeight = 45;
    GrayLine *fourthLine = [[GrayLine alloc] initWithFrame:CGRectMake(0, 0, _detailView.frame.size.width, .5)];
    [_detailView addSubview:fourthLine];
    
    NSArray *fourthArray = @[@"标题",@"描述"];
    self.chosenImages = [[NSMutableArray alloc] init];
    self.chosenImagesSmall = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<2; i++) {
        UILabel *title = [[UILabel alloc] init];
        title.frame = CGRectMake(10,fourthLine.frame.origin.y +fourthLine.frame.size.height + textHeight*i, 50, textHeight);
        title.textAlignment = NSTextAlignmentCenter;
        title.text = fourthArray[i];
        [self.detailView addSubview:title];
        
        GrayLine *rightLine = [[GrayLine alloc] initWithFrame:CGRectMake(title.frame.size.width+title.frame.origin.x, title.frame.origin.y+4, .5, textHeight-8)];
        [self.detailView addSubview:rightLine];
        
        GrayLine *bottomLine;
        if (i ==  0) {
            bottomLine = [[GrayLine alloc] initWithFrame:CGRectMake(8,title.frame.origin.y +textHeight, _detailView.frame.size.width-16, .5)];
            [self.detailView addSubview:bottomLine];
        }
        // the width on the right
        CGFloat labelWidth = bottomLine.frame.size.width - title.frame.size.width;
        switch (i) {
            case 0:
                self.titelField = [[UITextField alloc] initWithFrame:CGRectMake(rightLine.frame.origin.x+5 , title.frame.origin.y,labelWidth-30 , textHeight)];
                self.titelField.placeholder = @"1-20个字";
                [_detailView addSubview:self.titelField];
                
                break;
            case 1:
                self.contentField = [[UITextView alloc] initWithFrame:CGRectMake(rightLine.frame.origin.x + 1, self.titelField.frame.origin.y+self.titelField.frame.size.height + 5,_detailView.frame.size.width - rightLine.frame.origin.x-10, textHeight*2)];
                
                self.contentField.font = [UIFont systemFontOfSize:16];
                self.contentField.returnKeyType = UIReturnKeyDone;
                self.contentField.delegate = self;
                [_detailView addSubview:self.contentField];
                
                self.placeHoderText = [[CATextLayer alloc] init];
                self.placeHoderText.frame = CGRectMake(rightLine.frame.origin.x+5, self.titelField.frame.origin.y+self.titelField.frame.size.height + 10,_detailView.frame.size.width - rightLine.frame.origin.x-10, textHeight*2);
                self.placeHoderText.fontSize = 16;
                self.placeHoderText.string = @"交通配置等";
                self.placeHoderText.foregroundColor = [UIColor colorWithRed:0.733 green:0.733 blue:0.761 alpha:1.000].CGColor;
                [_detailView.layer addSublayer:self.placeHoderText];
                break;
                
            default:
                break;
        }
        
        
    }
    
    self.cameraView = [[CameraImageView alloc] initWithFrame:CGRectMake(20, self.contentField.frame.origin.y+self.contentField.frame.size.height+5, _detailView.frame.size.width-20, 150)];
    self.cameraView.delegate = self;
    [self.cameraView.addImageBtn addTarget:self action:@selector(imagePicker:) forControlEvents:UIControlEventTouchUpInside];
    [_detailView addSubview:self.cameraView];
}

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length > 0) {
        self.placeHoderText.hidden = YES;
    }else{
        self.placeHoderText.hidden = NO;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark - cameraViewDelegate

- (void)returnTapImageViewTagIndex:(NSInteger)index{
    if (self.photos) {
        [self.photos removeAllObjects];
    }
    for (int i = 0; i<self.chosenImages.count; i++) {
        MWPhoto *photo = [MWPhoto photoWithImage:self.chosenImages[i]];
        [self.photos addObject:photo];
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
    return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count)
        return [self.photos objectAtIndex:index];
    return nil;
}

- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    // If we subscribe to this method we must dismiss the view controller ourselves
    NSLog(@"Did finish modal presentation");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index{
    [self.photos removeObjectAtIndex:index];
    [self.chosenImages removeObjectAtIndex:index];
    [self.chosenImagesSmall removeObjectAtIndex:index];
    if (self.chosenImages.count < 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    [photoBrowser reloadData];
    [self.cameraView chuckSubViews];
    [self addPhotosOrMuteble];
    [self.cameraView configureImage:self.chosenImagesSmall];
    [self.cameraView.addImageBtn addTarget:self action:@selector(imagePicker:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setupStepView:(int)step{
    CGFloat width = self.view.frame.size.width/3;
    for (int i = 0; i<3; i++) {
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0 + width*i , 75,width , 30)];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.text = self.stepArray[i];
        textLabel.textColor = [UIColor grayColor];
        if (i == step) {
            textLabel.textColor = THEMECOLOR;
        }
        [self.scollView addSubview:textLabel];
        
        if (i<2) {
            UILabel *rightDirection = [[UILabel alloc] initWithFrame:CGRectMake(textLabel.frame.origin.x+width-10, textLabel.frame.origin.y, 20, textLabel.frame.size.height)];
            rightDirection.text = @">";
            rightDirection.textColor = [UIColor grayColor];
            [self.scollView addSubview:rightDirection];
        }
       
        
    }
}

-(void)setupSubmitBtn:(int)step{
    self.submitBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    if (self.step<2) {
        self.submitBtn.frame = CGRectMake(15, self.postView.frame.origin.y+self.postView.frame.size.height+63, self.view.frame.size.width-30, 47);
        [self.submitBtn configureButtonTitle:@"下一步" backgroundColor:THEMECOLOR];
    }else{
        [self.submitBtn configureButtonTitle:@"发布" backgroundColor:THEMECOLOR];
        self.submitBtn.frame = CGRectMake(15, self.detailView.frame.origin.y + self.detailView.frame.size.height + 63, SCREENSIZE.width - 30, 47);
    }
    [self.submitBtn addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
    [self.submitBtn roundRect];
    [self.scollView addSubview:self.submitBtn];
}

-(void)nextStep{

    RentPostViewController *postVC = [[RentPostViewController alloc] init];
    BOOL post = NO;
    
    switch (self.step) {
        case 0:
            if (self.houseType.length == 0 || self.postView.roomField.text.length == 0 || self.postView.sittingRoomField.text.length == 0 || self.postView.bathRoomField.text.length == 0 || self.postView.floorField.text.length == 0 || self.postView.totalFloorField.text.length == 0 || self.houseOrientation.length == 0) {
                [self showHint:@"信息不完整"];
                break;
            }else if([self.postView.floorField.text isEqualToString: @"0"] || [self.postView.totalFloorField.text isEqualToString: @"0"] ){
                [Util alertNetworingError:@"楼层数不能为0"];
                break;
            }else if([self.postView.floorField.text intValue] > [self.postView.totalFloorField.text intValue] ){
                [Util alertNetworingError:@"楼层数不能大于总楼层数"];
                break;
            } if([self.postView.roomField.text isEqualToString: @"0"] && [self.postView.bathRoomField.text isEqualToString: @"0"] && [self.postView.sittingRoomField.text isEqualToString: @"0"] ){
                [Util alertNetworingError:@"厅室不能都为0"];
                break;
            }else{
                post = YES;
                postVC.houseData.houseType = self.houseType;
                postVC.houseData.room = self.postView.roomField.text;
                postVC.houseData.sittingRoom = self.postView.sittingRoomField.text;
                postVC.houseData.bathRoom = self.postView.bathRoomField.text;
                postVC.houseData.floor = self.postView.floorField.text;
                postVC.houseData.totalFloor = self.postView.floorField.text;
                postVC.houseData.houseOrientation = self.houseOrientation;
                break;
            }

            break;
            
        case 1:
            
            if (self.postView.areaField.text.length == 0 || self.postView.priceField.text.length ==0) {
                [Util alertNetworingError:@"信息不完整"];
                break;
            }else{
                post = YES;
                postVC.houseData = self.houseData;
                postVC.houseData.area = self.postView.areaField.text;
                postVC.houseData.price = self.postView.priceField.text;
            }
            
            break;
        case 2:
            if (self.titelField.text.length == 0 || self.contentField.text.length ==0) {
                [Util alertNetworingError:@"信息不完整"];
                break;
            }else{
                self.houseData.title = self.titelField.text;
                self.houseData.content = self.contentField.text;
                [self uploadRentInfo];
                break;
            }
            break;
            
        default:
            break;
    }
    
    if (post) {
        postVC.step = self.step + 1;
        postVC.houseDealType = self.houseDealType;
        [self.navigationController pushViewController:postVC animated:YES];
    }
    
    
}

#pragma mark picker

-(void)selectPicker:(id)sender{
    
    UIButton *button = (UIButton*)sender;
    [self.view endEditing:YES];

    
    self.pickerTag = [NSString stringWithFormat:@"%ld",(long)button.tag];
    
    [self.pickerView removeFromSuperview];
    self.pickerView = [[PickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-200, self.view.frame.size.width, 200)];
    self.pickerView.pickerView.delegate = self;
    self.pickerView.pickerView.dataSource = self;
    [self.pickerView.confirmBtn addTarget:self action:@selector(confirmPicker:) forControlEvents:UIControlEventTouchUpInside];
    [self.pickerView.cancelBtn addTarget:self action:@selector(cancelPicker:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.pickerView];
}


// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if ([self.pickerTag isEqualToString:@"1"]) {
        return self.houseTypeArr.count;
    }else{
        return self.houseOrientationArr.count;
    }
}

// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return 200;
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if ([self.pickerTag isEqualToString:@"1"]) {
       self.pickerStr =  self.houseTypeArr[row];
    }else{
       self.pickerStr = self.houseOrientationArr[row];
    }
    
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if ([self.pickerTag isEqualToString:@"1"]) {
        self.pickerStr =  self.houseTypeArr[row];
       
        return self.houseTypeArr[row];
    }else{
        self.pickerStr = self.houseOrientationArr[row];
        
        return self.houseOrientationArr[row];
    }
    
    
}

-(void)confirmPicker:(id)sender{
    
   [self.pickerView removeFromSuperview];
    
    if (self.pickerStr) {
        if ([self.pickerTag isEqualToString:@"1"]) {
            [self.postView.houseTypeBtn setTitle:self.pickerStr forState:UIControlStateNormal];
             self.houseType =  [Util translateHouseType:self.pickerStr En:NO];
        }else{
            [self.postView.houseOrientationBtn setTitle:self.pickerStr forState:UIControlStateNormal];
            self.houseOrientation = [Util translateOrientation:self.pickerStr En:NO];
        }
    }
    
    self.pickerStr = nil;
}

-(void)cancelPicker:(id)sender{
    [self.pickerView removeFromSuperview];
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
        
        [self addPhotosOrMuteble];
        [self.cameraView chuckSubViews];
        [self.cameraView configureImage:self.chosenImagesSmall];
        [self.cameraView.addImageBtn addTarget:self action:@selector(imagePicker:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

- (void)addPhotosOrMuteble{
    if (self.chosenImages.count > 3) {
        self.detailView.frame = CGRectMake(0, 120, self.view.frame.size.width,330);
    }else{
        self.detailView.frame = CGRectMake(0, 120, self.view.frame.size.width,330 - 90);
    }
    self.submitBtn.frame = CGRectMake(15, self.detailView.frame.origin.y + self.detailView.frame.size.height + 63, SCREENSIZE.width - 30, 47);
}

- (void)rentPostViewSelecteImageViewIndex:(NSInteger)index{
    if (!self.photos) {
        [self.photos removeAllObjects];
    }
    for (int i = 0; i<self.chosenImages.count; i++) {
        MWPhoto *photo = [MWPhoto photoWithImage:self.chosenImagesSmall[i]];
        [self.photos addObject:photo];
    }
    // Create browser
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser = [Util fullImageSetting:browser];
    browser.displayNavArrows = YES;
    [browser setCurrentPhotoIndex:index];
    [self.navigationController pushViewController:browser animated:YES];
}

#pragma mark networking

-(void)uploadRentInfo{
    
    [self.view addSubview:self.loadingView];
    NSString *houseType ;
    if (self.houseDealType == SummerHouseDealTypeSale) {
        houseType = @"Sale";
    }else if (self.houseDealType == SummerHouseDealTypeRent){
        houseType = @"Rent";
    }
    if (self.chosenImages.count) {
        [Networking upload:self.chosenImages success:^(id responseObject) {
            NSDictionary *parameters = @{
                                         @"token":[User getUserToken],
                                         @"communityId":[Util getCommunityID],
                                         @"houseDealType":houseType,
                                         @"title":self.titelField.text,
                                         @"content":self.contentField.text,
                                         @"pictures":responseObject,
                                         @"room":self.houseData.room,
                                         @"sittingRoom":self.houseData.sittingRoom,
                                         @"bathRoom":self.houseData.bathRoom,
                                         @"area":self.houseData.area,
                                         @"floor":self.houseData.floor,
                                         @"totalFloor":self.houseData.totalFloor,
                                         @"houseOrientation":self.houseData.houseOrientation,
                                         @"houseType":self.houseData.houseType,
                                         @"price":self.houseData.price
                                         };
            [Networking retrieveData:houseDeal_add parameters:parameters success:^(id responseObject) {
                
                [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
            } addition:^{
                [self.loadingView removeFromSuperview];
            }];
        }];

    }else{
        NSDictionary *parameters = @{
                                     @"token":[User getUserToken],
                                     @"communityId":[Util getCommunityID],
                                     @"houseDealType":houseType,
                                     @"title":self.titelField.text,
                                     @"content":self.contentField.text,
                                     @"room":self.houseData.room,
                                     @"sittingRoom":self.houseData.sittingRoom,
                                     @"bathRoom":self.houseData.bathRoom,
                                     @"area":self.houseData.area,
                                     @"floor":self.houseData.floor,
                                     @"totalFloor":self.houseData.totalFloor,
                                     @"houseOrientation":self.houseData.houseOrientation,
                                     @"houseType":self.houseData.houseType,
                                     @"price":self.houseData.price
                                     };
        [Networking retrieveData:houseDeal_add parameters:parameters success:^(id responseObject) {
            [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
        } addition:^{
            [self.loadingView removeFromSuperview];
        }];
    }
       
}

- (void)textFieldReturnWarning:(NSString *)strError{
    [self showHint:strError yOffset:-150.0];
}

@end
