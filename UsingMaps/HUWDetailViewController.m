//
//  HUWDetailViewController.m
//  UsingMaps
//
//  Created by Hugo Wetterberg on 2012-03-13.
//  Copyright (c) 2012 Good Old AB. All rights reserved.
//

#import "HUWDetailViewController.h"

@interface HUWDetailViewController ()
-(void)updateUI;
@end

@implementation HUWDetailViewController

@synthesize annotation = _annotation, nameLabel = _nameLabel, emailLabel = _emailLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self updateUI];
}

-(void)updateUI {
    self.nameLabel.text = [NSString stringWithFormat:@"%@, %d years", self.annotation.name, self.annotation.age];
    self.emailLabel.text = self.annotation.email;
}

-(HUWMapAnnotation *)annotation {
    return _annotation;
}

-(void)setAnnotation:(HUWMapAnnotation *)annotation {
    _annotation = annotation;
    [self updateUI];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
