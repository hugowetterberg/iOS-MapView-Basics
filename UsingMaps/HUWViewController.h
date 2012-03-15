//
//  HUWViewController.h
//  UsingMaps
//
//  Created by Hugo Wetterberg on 2012-02-12.
//  Copyright (c) 2012 Good Old AB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "HUWMapAnnotation.h"

@interface HUWViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate> {
    @private
    CLLocationManager *locationManager;
    CLLocation *currentPosition;
    __weak HUWMapAnnotation *selectedAnnotation;
}

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
