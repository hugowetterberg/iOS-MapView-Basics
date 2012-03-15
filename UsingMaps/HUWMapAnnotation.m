//
//  HUWMapAnnotation.m
//  UsingMaps
//
//  Created by Hugo Wetterberg on 2012-02-12.
//  Copyright (c) 2012 Good Old AB. All rights reserved.
//

#import "HUWMapAnnotation.h"

@implementation HUWMapAnnotation

@synthesize name = _name, age = _age, email = _email, coordinate = _coordinate;

-(id)initWithCoordinate:(CLLocationCoordinate2D)coordinate {
    if ((self = [super init])) {
        _coordinate = coordinate;
    }
    return self;
}

-(NSString *)title {
    return self.name;
}

-(NSString *)subtitle {
    return self.email;
}

@end
