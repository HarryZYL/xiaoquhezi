//
//  SummerRePostMyRentViewController.m
//  WeCommunity
//
//  Created by madarax on 15/11/21.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerRePostMyRentViewController.h"
#import "UIViewController+HUD.h"
#import "MBProgressHUD.h"
#import "PickerView.h"
@interface SummerRePostMyRentViewController ()<UzysAssetsPickerControllerDelegate ,MWPhotoBrowserDelegate ,CameraImageViewDelegate ,UIPickerViewDataSource ,UIPickerViewDelegate>

@property (nonatomic ,strong) NSMutableArray *chosenImages;
@property (nonatomic ,strong) NSMutableArray *photosArrary;
@property (nonatomic ,strong) NSArray *houseTypeArr;
@property (nonatomic ,strong) NSArray *houseOrientationArr;
@property (nonatomic ,strong) PickerView *pickerView;
@property (nonatomic ,strong) NSString *pickerTag;
@property (nonatomic ,strong) NSString *pickerStr;
@property (nonatomic ,strong) NSString *houseType;
@property (nonatomic ,strong) NSString *houseOrientation;
@property (nonatomic ,strong) MBProgressHUD *progessHUD;

@end

@implementation SummerRePostMyRentViewController

- (instancetype)init{
    if (self == [super init]) {
        UIBarButtonItem *pushItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(upLoadData)];
        self.navigationItem.rightBarButtonItem = pushItem;
        _chosenImages = [[NSMutableArray alloc] init];
        _photosArrary = [[NSMutableArray alloc] init];
        
        self.houseTypeArr = @[@"普通住宅",@"商住两用",@"公寓",@"别墅",@"其他"];
        self.houseOrientationArr = @[@"东",@"西",@"南",@"北",@"东北",@"西北",@"东南",@"西南",@"东西",@"南北"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"编辑";
    self.view.backgroundColor = [UIColor whiteColor];
    _alertViewModel = [[SummerRentAlertView alloc] initWithFrame:self.view.frame];
    _alertViewModel.houseDeal = self.houseDeal;
    [self.view addSubview:_alertViewModel];
    [_alertViewModel setContentTitle];
    self.alertViewModel.photoImage.delegate = self;
    self.chosenImages = _alertViewModel.selectImagesArrary;
    
    [self.alertViewModel.photoImage.addImageBtn addTarget:self action:@selector(imagePicker:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.alertViewModel.orientationBtn addTarget:self action:@selector(selectPicker:) forControlEvents:UIControlEventTouchUpInside];
    [self.alertViewModel.roomType addTarget:self action:@selector(selectPicker:) forControlEvents:UIControlEventTouchUpInside];
    
    self.houseOrientation = self.alertViewModel.houseDeal.houseOrientation;
    self.houseType = self.alertViewModel.houseDeal.houseType;
}

-(void)selectPicker:(UIButton *)sender{
    [self.view endEditing:YES];
    self.pickerTag = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
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
            [self.alertViewModel.roomType setTitle:self.pickerStr forState:UIControlStateNormal];
            self.houseType =  [Util translateHouseType:self.pickerStr En:NO];
        }else{
            [self.alertViewModel.orientationBtn setTitle:self.pickerStr forState:UIControlStateNormal];
            self.houseOrientation = [Util translateOrientation:self.pickerStr En:NO];
        }
    }
    
    self.pickerStr = nil;
    
    
}

-(void)cancelPicker:(id)sender{
    [self.pickerView removeFromSuperview];
}

- (void)upLoadData{
    
    [self.view endEditing:YES];
    UITextField *titleField = (UITextField *)[self.alertViewModel viewWithTag:17];
    SAMTextView *contentField = (SAMTextView *)[self.alertViewModel viewWithTag:18];
    
    UITextField *roomField = (UITextField *)[self.alertViewModel viewWithTag:10];
    UITextField *roomSittingField = (UITextField *)[self.alertViewModel viewWithTag:11];
    UITextField *roomBathField = (UITextField *)[self.alertViewModel viewWithTag:12];
    UITextField *totalField = (UITextField *)[self.alertViewModel viewWithTag:14];
    UITextField *floorField = (UITextField *)[self.alertViewModel viewWithTag:13];
    
    UITextField *areaField = (UITextField *)[self.alertViewModel viewWithTag:15];
    UITextField *priceField = (UITextField *)[self.alertViewModel viewWithTag:16];
    if ([roomField.text integerValue] < 1 || [roomSittingField.text integerValue] < 1 || [roomBathField.text integerValue] < 1 || [totalField.text integerValue] < 1 || [floorField.text integerValue] < 1) {
        [self showHint:@"信息填写不完整"];
        return;
    }
    if ([floorField.text integerValue] > [totalField.text integerValue]) {
        [self showHint:@"楼层不能大于总楼层"];
        return;
    }
    self.progessHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.progessHUD hide:YES afterDelay:30.0];
    
    NSString *houseType ;
    if (self.houseDealType == SummerHouseDealTypeSale) {
        houseType = @"Sale";
    }else if (self.houseDealType == SummerHouseDealTypeRent){
        houseType = @"Rent";
    }
    __weak typeof(self)weakSelf = self;
    if (self.chosenImages.count) {
        self.progessHUD.labelText = @"上传图片中";
        [Networking upload:self.chosenImages success:^(id responseObject) {
            NSDictionary *parameters = @{
                                         @"token":[User getUserToken],
                                         @"communityId":[Util getCommunityID],
                                         @"houseDealType":houseType,
                                         @"title":titleField.text,
                                         @"content":contentField.text,
                                         @"pictures":responseObject,
                                         @"room":roomField.text,
                                         @"sittingRoom":roomSittingField.text,
                                         @"bathRoom":roomBathField.text,
                                         @"area":areaField.text,
                                         @"floor":floorField.text,
                                         @"totalFloor":totalField.text,
                                         @"houseDealId":self.strHouseDeailID,
                                         @"houseOrientation":self.houseOrientation,
                                         @"houseType":self.houseType,
                                         @"price":priceField.text
                                         };
            weakSelf.progessHUD.labelText = @"上传信息中";
            [Networking retrieveData:get_HOUSE_DETAIL_EDITE parameters:parameters success:^(id responseObject) {
                [weakSelf.progessHUD removeFromSuperview];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"RENT_ROOM_UPDATE" object:nil];
                [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
            } addition:^{
            }];
        }];
        
    }else{
        self.progessHUD.labelText = @"上传信息中";
        NSDictionary *parameters = @{
                                     @"token":[User getUserToken],
                                     @"communityId":[Util getCommunityID],
                                     @"houseDealType":houseType,
                                     @"title":titleField.text,
                                     @"content":contentField.text,
                                     @"room":roomField.text,
                                     @"sittingRoom":roomSittingField.text,
                                     @"bathRoom":roomBathField.text,
                                     @"area":areaField.text,
                                     @"floor":floorField.text,
                                     @"totalFloor":totalField.text,
                                     @"houseDealId":self.strHouseDeailID,
                                     @"houseOrientation":self.houseOrientation,
                                     @"houseType":self.houseType,
                                     @"price":priceField.text
                                     };
        [Networking retrieveData:get_HOUSE_DETAIL_EDITE parameters:parameters success:^(id responseObject) {
            [weakSelf.progessHUD removeFromSuperview];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"RENT_ROOM_UPDATE" object:nil];
            [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
        } addition:^{

        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
            
            if (idx==0 && self.chosenImages.count == 1) {
                
            }
            
        }];
        
        [self addPhotosOrMuteble];
        [self.alertViewModel.photoImage chuckSubViews];
        [self.alertViewModel.photoImage configureImage:self.chosenImages];
        [self.alertViewModel.photoImage.addImageBtn addTarget:self action:@selector(imagePicker:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)addPhotosOrMuteble{
    if (self.chosenImages.count > 3) {
        self.alertViewModel.bootomView.frame = CGRectMake(0, 300, SCREENSIZE.width, 330);
    }else{
        self.alertViewModel.bootomView.frame = CGRectMake(0, 300, SCREENSIZE.width, 250);
    }
}

- (void)returnTapImageViewTagIndex:(NSInteger)index{
    if (self.photosArrary) {
        [self.photosArrary removeAllObjects];
    }
    for (int i = 0; i<self.chosenImages.count; i++) {
        MWPhoto *photo = [MWPhoto photoWithImage:self.chosenImages[i]];
        [self.photosArrary addObject:photo];
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
    return self.photosArrary.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photosArrary.count)
        return [self.photosArrary objectAtIndex:index];
    return nil;
}

- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    // If we subscribe to this method we must dismiss the view controller ourselves
    NSLog(@"Did finish modal presentation");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index{
    [self.photosArrary removeObjectAtIndex:index];
    [self.chosenImages removeObjectAtIndex:index];
    if (self.chosenImages.count < 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    [photoBrowser reloadData];
    [self.alertViewModel.photoImage chuckSubViews];
    [self addPhotosOrMuteble];
    [self.alertViewModel.photoImage configureImage:self.chosenImages];
    [self.alertViewModel.photoImage.addImageBtn addTarget:self action:@selector(imagePicker:) forControlEvents:UIControlEventTouchUpInside];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
