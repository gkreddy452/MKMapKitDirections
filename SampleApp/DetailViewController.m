//
//  DetailViewController.m
//  SampleApp
//
//  Created by kasturi gopal on 16/11/17.
//  Copyright © 2017 kasturi. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIButton *directionBtn;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation* currentLocation;

@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;
@property (weak, nonatomic) IBOutlet UILabel *detailTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailSubTextLabel;
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;
@property (weak, nonatomic) IBOutlet MKMapView *detailMapView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initLocationManager];
    
    self.detailMapView.delegate = self;
    self.detailMapView.showsUserLocation = YES;
    
    self.detailImageView.image = self.detailImage;
    self.detailTextLabel.text = self.detailText;
    self.detailSubTextLabel.text = self.detailSubText;
    self.detailTextView.text = self.textViewText;
    
    [self.view bringSubviewToFront:self.directionBtn];
}

// Initialize LocationManager
-(void) initLocationManager{
    
    if (!self.locationManager) {
        
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.delegate = self;
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            [_locationManager requestAlwaysAuthorization];
        }
    }
    
    [self.locationManager startUpdatingLocation];
    
    
}

// LocationManager Delegate method
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.currentLocation = [locations lastObject];
    // here we get the current location
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    //if (annotation == mapView.userLocation)
       // return nil;
    
    static NSString *s = @"identifier";
    MKAnnotationView *pin = [mapView dequeueReusableAnnotationViewWithIdentifier:s];
    if (!pin) {
        pin = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:s];
        pin.canShowCallout = YES;
        pin.image = [UIImage imageNamed:@"annotation"];
        pin.calloutOffset = CGPointMake(0, 0);
    }
    return pin;
}

- (void)selectUserLocation:(id)annotation{
    [self.detailMapView selectAnnotation:annotation animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)directionsClicked:(id)sender {
    
    NSString* directionsURL = [NSString stringWithFormat:@"http://maps.apple.com/?saddr=%f,%f&daddr=%f,%f",self.currentLocation.coordinate.latitude, self.currentLocation.coordinate.longitude, [self.latitude floatValue], [self.longitude floatValue]];
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: directionsURL] options:@{} completionHandler:^(BOOL success) {}];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: directionsURL]];
    }
}

-(void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.locationManager stopUpdatingLocation];
    
}


@end
