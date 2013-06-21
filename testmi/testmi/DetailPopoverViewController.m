//
//  PopoverViewController.m
//  PEM
//
//  Created by Sandra Zollner on 01.06.13.
//  Copyright (c) 2013 Sandra Zollner. All rights reserved.
//

#import "DetailPopoverViewController.h"

@interface DetailPopoverViewController ()<UIAlertViewDelegate>

@end

@implementation DetailPopoverViewController
@synthesize semestersdicView, picker, gradeArray, noGradeArray, gradeLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *plistLocation = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
        NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistLocation];
        NSPropertyListFormat format;
        NSString *errorDesc = nil;
        self.semestersdicView = (NSMutableDictionary *)[NSPropertyListSerialization
                                                 propertyListFromData:plistXML
                                                 mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                                 format:&format
                                                 errorDescription:&errorDesc];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.titleLabel.text = self.titleString;
    
    self.gradeArray = [[NSArray alloc] initWithObjects:
                         @"Nicht Bestanden", @"Bestanden - Unbenotet", @"1.0", @"1.3",@"1.7",@"2.0",@"2.3",@"2.7",@"3.0",@"3.3",@"3.7",@"4.0", nil];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    NSString *resultString = [gradeArray objectAtIndex:row];
    gradeLabel.text = resultString;
}

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return [gradeArray count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return [gradeArray objectAtIndex:row];
}

@end
