//
//  HUWViewController.m
//  UsingMaps
//
//  Created by Hugo Wetterberg on 2012-02-12.
//  Copyright (c) 2012 Good Old AB. All rights reserved.
//

#import "HUWViewController.h"
#import "HUWDetailViewController.h"

@implementation HUWViewController
@synthesize mapView;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    // Check if this is the first time we get a reading.
    if (currentPosition == nil) {
        // Create a map point from the coordinate.
        MKMapPoint point = MKMapPointForCoordinate(newLocation.coordinate);
        // Get the relationship between map points and metres at our current latitude.
        double pointsPerMeter = MKMapPointsPerMeterAtLatitude(newLocation.coordinate.latitude);
        // Calculate the number of map points that equals a distance of 500m.
        double visibleDistance = pointsPerMeter * 500.0;
        
        // Create a rectangle that is a kilometer at the sides and is centered on our position.
        MKMapRect rect = MKMapRectMake(
                                       point.x - visibleDistance, point.y - visibleDistance, 
                                       visibleDistance * 2, visibleDistance * 2);
        
        // Tell the map view to show the rectangle.
        [self.mapView setVisibleMapRect:rect animated:YES];
        
        HUWMapAnnotation *annotation = [[HUWMapAnnotation alloc] initWithCoordinate:newLocation.coordinate];
        annotation.name = @"Hugo Wetterberg";
        annotation.email = @"hugo@wetterberg.nu";
        annotation.age = 30;
        [self.mapView addAnnotation:annotation];
    }
    // Update the current position.
    currentPosition = newLocation;
}

-(MKAnnotationView *)mapView:(MKMapView *)view viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *pin = nil;
    
    //Check if the annotation is of our annotation class
    if ([annotation isKindOfClass:[HUWMapAnnotation class]]) {
        NSString *pinIdentifier = @"red_pin";
        // Get a pin for re-use
        pin = (MKPinAnnotationView*)[view dequeueReusableAnnotationViewWithIdentifier:pinIdentifier];
        if (!pin) {
            // If no pin was available for re-use we'll create a new one.
            pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pinIdentifier];
            pin.pinColor = MKPinAnnotationColorGreen;
            pin.canShowCallout = YES;
            pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            pin.animatesDrop = YES;
        }
        else {
            // Update the annotation if we're re-using an old pin
            pin.annotation = annotation;
        }
    }
    
    return pin;
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    //Check if the annotation is of our annotation class
    if ([view.annotation isKindOfClass:[HUWMapAnnotation class]]) {
        // Store a reference to the annotation so that we can pass it on in prepare for segue.
        selectedAnnotation = view.annotation;
        [self performSegueWithIdentifier:@"showPinDetails" sender:self];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Check that the segue is our showPinDetails-segue
    if ([segue.identifier isEqualToString:@"showPinDetails"]) {
        // Pass the annotation reference to the detail view controller.
        HUWDetailViewController *detail = [segue destinationViewController];
        detail.annotation = selectedAnnotation;
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Check if the user has enabled location services.
    if ([CLLocationManager locationServicesEnabled]) {
        // Create a location manager.
        locationManager = [[CLLocationManager alloc] init];
        // Set ourselves as it's delegate so that we get notified of position updates.
        locationManager.delegate = self;
        // Set the desired accuracy.
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        // Start tracking.
        [locationManager startUpdatingLocation];
    }
    
    // Add a long press gesture recognizer to the map for adding new pins to the map
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(mapLongPress:)];
    longPress.minimumPressDuration = 1.0;
    [self.mapView addGestureRecognizer:longPress];
}

-(void)mapLongPress:(UIGestureRecognizer*)gesture {
    if (gesture.state != UIGestureRecognizerStateBegan)
        return;
    
    // Get the screen coordinates for the touch relative to our map view.
    CGPoint point = [gesture locationInView:self.mapView];
    // Get the world coordinates that corresponds to the screen coordinates.
    CLLocationCoordinate2D coordinates = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
    
    // Create and add an annotation with the coordinates.
    HUWMapAnnotation *annotation = [[HUWMapAnnotation alloc] initWithCoordinate:coordinates];
    annotation.name = @"Dropped pin";
    [self.mapView addAnnotation:annotation];
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [super viewDidUnload];
    
    [locationManager stopUpdatingLocation];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
