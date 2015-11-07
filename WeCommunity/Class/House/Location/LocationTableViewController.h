//
//  LocationTableViewController.h
//  WeCommunity
//
//  Created by Harry on 8/30/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicTableViewCell.h"

@protocol LocationTableViewControllerDelegate <NSObject>

- (void)selectedFinishedCommunityNameAndID:(NSDictionary *)dicTemp;

@end

typedef NS_ENUM(NSUInteger, LocationTableViewControllerStyle) {
    LocationTableViewControllerStyleDefult,
    LocationStyleSelectCommunityNameAndID,
    LocationTableViewControllerStyleOther,
};

@interface LocationTableViewController : UITableViewController<MKMapViewDelegate,CLLocationManagerDelegate>{
    
     CLLocationManager *_locationManager;
     CLGeocoder *_geocoder;
}

@property (nonatomic,strong) NSArray *locationArr;
@property (nonatomic,strong) NSArray *locationID;

@property (nonatomic,strong) MKMapView *mapView;
@property (weak) id delegate;
@property (assign)LocationTableViewControllerStyle locationStyle;

@end
