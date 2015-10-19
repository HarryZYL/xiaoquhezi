//
//  SecondHandPostViewController.m
//  WeCommunity
//
//  Created by Harry on 8/16/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "SecondHandPostViewController.h"

@interface SecondHandPostViewController ()

@end

@implementation SecondHandPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    初始化滑动页面
    self.scollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scollView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    self.scollView.contentSize = CGSizeMake(self.view.frame.size.width, 800);
    [self.view addSubview:self.scollView];
//    初始化发布页面
    self.postView = [[SecondHandPostView alloc]  initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height)] ;
    [self.postView.cameraView.addImageBtn addTarget:self action:@selector(imagePicker:) forControlEvents:UIControlEventTouchUpInside];
    [self.scollView addSubview:self.postView];
    
    UIBarButtonItem *postBtn = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(uploadImages)];
    self.navigationItem.rightBarButtonItem = postBtn;

    
    self.chosenImages = [[NSMutableArray alloc] initWithCapacity:9];
    self.chosenImagesSmall = [[NSMutableArray alloc] initWithCapacity:9];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark imagepicker

-(void)imagePicker:(id)sender{
    
    UzysAssetsPickerController *picker = [[UzysAssetsPickerController alloc] init];
    picker.delegate = self;
    picker.maximumNumberOfSelectionMedia = 9 - self.chosenImages.count;
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
        [self.postView.cameraView configureImage:self.chosenImagesSmall];
        
    }
    
}

-(void)retrieveData:(NSArray*)imageArr{
    
    NSDictionary *parameters = @{
                                 @"token":[User getUserToken],
                                 @"communityId":@"1",
                                 @"fleaMarketType":@"Sale",
                                 @"title":self.postView.titleField.text,
                                 @"originalPrice":self.postView.originalPriceField.text,
                                 @"dealPrice":self.postView.dealPriceField.text,
                                 @"content":self.postView.describleView.text,
                                 @"pictures":imageArr
                                 };
    [Networking retrieveData:market_add parameters:parameters];

    
    
}

-(void)uploadImages{
    
    [Networking upload:self.chosenImages success:^(id responseObject) {
        [self retrieveData:responseObject];
    }];
    
}



@end
