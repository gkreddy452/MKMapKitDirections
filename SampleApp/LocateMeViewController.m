//
//  LocateMeViewController.m
//  SampleApp
//
//  Created by kasturi gopal on 16/11/17.
//  Copyright © 2017 kasturi. All rights reserved.
//

#import "LocateMeViewController.h"

@interface LocateMeViewController () {
    
    UIView *segmentView;
    UISegmentedControl *mainSegment;
}
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation* currentLocation;

@end

@implementation LocateMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initLocationManager];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    [self AddSegmentControl];
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


//Added SegmentControl
-(void) AddSegmentControl {
    
    segmentView = [[UIView alloc] init];
    segmentView.backgroundColor = [UIColor whiteColor];
    segmentView.layer.cornerRadius = 5;
    segmentView.layer.masksToBounds = YES;
    segmentView.frame = CGRectMake(20, self.view.frame.size.height - 70, 250, 40);
    [self.view bringSubviewToFront:segmentView];
    [self.view addSubview:segmentView];
    
    mainSegment = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Standard",@"satellite",@"Hybrid", nil]];
    [mainSegment setFrame:segmentView.frame];
    mainSegment.selectedSegmentIndex = 0;
    [mainSegment addTarget:self action:@selector(mainSegmentControl:) forControlEvents: UIControlEventValueChanged];
    [self.view bringSubviewToFront:mainSegment];
    [self.view addSubview:mainSegment];
    
    
}

- (void)mainSegmentControl:(UISegmentedControl *)segment
{
    if(segment.selectedSegmentIndex == 0)
    {
        self.mapView.mapType = MKMapTypeStandard;
    }
    else if(segment.selectedSegmentIndex == 1)
    {
        self.mapView.mapType = MKMapTypeSatellite;
    } else {
        
        self.mapView.mapType = MKMapTypeHybrid;
    }
    
}

-(void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.locationManager stopUpdatingLocation];
    
}
- (IBAction)closeBtnClicked:(id)sender {
    
    [self dismissViewControllerAnimated:NO completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
