//
//  HUWDetailViewController.h
//  UsingMaps
//
//  Created by Hugo Wetterberg on 2012-03-13.
//  Copyright (c) 2012 Good Old AB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HUWMapAnnotation.h"

@interface HUWDetailViewController : UIViewController

@property (strong) HUWMapAnnotation *annotation;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;


@end
