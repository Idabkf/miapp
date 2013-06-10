//
//  PopoverViewController.m
//  PEM
//
//  Created by Sandra Zollner on 01.06.13.
//  Copyright (c) 2013 Sandra Zollner. All rights reserved.
//

#import "PopoverViewController.h"

@interface PopoverViewController ()

@end

@implementation PopoverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.titleLabel.text = @"Titel der Vorlesung";
    //slider
    [self.slider addTarget:self action:@selector(val:) forControlEvents:UIControlEventValueChanged];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)val:(id)sender
{
    if(self.slider.value >= 1){
	self.sliderLabel.text = [NSString stringWithFormat:@"%.0f", self.slider.value];
    }else self.sliderLabel.text = @"keine Note";
}

@end
