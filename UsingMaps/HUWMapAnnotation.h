//
//  HUWMapAnnotation.h
//  UsingMaps
//
//  Created by Hugo Wetterberg on 2012-02-12.
//  Copyright (c) 2012 Good Old AB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface HUWMapAnnotation : NSObject<MKAnnotation>


@property (strong) NSString *name;
@property (strong) NSString *email;
@property (assign) NSInteger age;

-(id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;

@end
