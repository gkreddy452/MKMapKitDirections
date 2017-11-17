//
//  DetailViewController.h
//  SampleApp
//
//  Created by kasturi gopal on 16/11/17.
//  Copyright © 2017 kasturi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface DetailViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>

@property(nonatomic, strong) UIImage *detailImage;
@property(nonatomic, strong) NSString *detailText;
@property(nonatomic, strong) NSString *detailSubText;
@property(nonatomic, strong) NSString *textViewText;
@property(nonatomic, strong) NSString * latitude;
@property(nonatomic, strong) NSString * longitude;



@end
