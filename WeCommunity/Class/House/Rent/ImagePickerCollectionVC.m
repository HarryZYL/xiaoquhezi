//
//  ImagePickerCollectionVC.m
//  WeCommunity
//
//  Created by Harry on 8/26/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "ImagePickerCollectionVC.h"

@interface ImagePickerCollectionVC ()

@end

@implementation ImagePickerCollectionVC

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[ImagePickerCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    self.collectionView.alwaysBounceVertical = YES;
    // Do any additional setup after loading the view.
    
    self.bottomBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-30, self.view.frame.size.width, 50)];
    [self.bottomBtn configureButtonTitle:@"确定" backgroundColor:[UIColor orangeColor]];
    [self.bottomBtn addTarget:self action:@selector(goback:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.bottomBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.chosenImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImagePickerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    cell.imageView.image = self.chosenImagesSmall[indexPath.row];
    [cell.deleteBtn setImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
    [cell.deleteBtn addTarget:self action:@selector(deleteImg:) forControlEvents:UIControlEventTouchUpInside];
    cell.deleteBtn.tag = indexPath.row;
     
    return cell;
}

#pragma mark action

-(void)deleteImg:(id)sender{
    
    UIButton *button = (UIButton*)sender;
    [self.chosenImagesSmall removeObjectAtIndex:button.tag];
    [self.chosenImages removeObjectAtIndex:button.tag];
    [self.collectionView reloadData];
    
}

-(void)goback:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
