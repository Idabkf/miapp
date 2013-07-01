//
//  StartView.m
//  testmi
//
//  Created by danqing liu on 13-6-15.
//  Copyright (c) 2013年 danqing liu. All rights reserved.
//

#import "StartView.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"

@interface StartView ()<UIAlertViewDelegate>

@end

@implementation StartView
@synthesize picker;
@synthesize list;
@synthesize semester;
@synthesize fach;

@synthesize Semesterlabel,Fachlabel;
NSString *adfach;
NSString *semesteranzahl;

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
    self.Titel.backgroundColor = [UIColor clearColor];
	
    //self.Welcome.frame = CGRectMake(10, 20, 0, 0);
   // CGContextRef context = UIGraphicsGetCurrentContext();
   // [UIView beginAnimations:nil context:context];
    //[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //[UIView setAnimationDuration:1];
    //[self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
     //self.Welcome.frame = CGRectMake(0,0, 10, 20);
    
   self.Titel.frame = CGRectMake(480, 10, 0, 0);
    CGContextRef context1 = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context1];
   [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:2];
    [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:2];
    self.Titel.frame = CGRectMake(245,20, 10, 20);
    
    [UIView setAnimationDelegate:self];
    
    // [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];

        
    /*NSUserDefaults *mydefault = [NSUserDefaults standardUserDefaults];
     Fachlabel.text = [mydefault stringForKey:@"AF"];
    Semesterlabel.text = [mydefault stringForKey:@"SA"];*/
    
    fach  = [[NSMutableArray alloc] init];
   // [fach addObject:@"Fach"];
    [fach addObject:@"KW"];
    [fach addObject:@"MMI"];
    [fach addObject:@"MG"];
    [fach addObject:@"BWL"];
    semester  = [[NSMutableArray alloc] init];
   // [semester addObject:@"Semester"];
    [semester addObject:@"1"];
    [semester addObject:@"2"];
    [semester addObject:@"3"];
    [semester addObject:@"4"];
    [semester addObject:@"5"];
    [semester addObject:@"6"];
    [semester addObject:@"7"];
    [semester addObject:@"8"];
    [semester addObject:@"9"];
        picker.delegate = self;
    picker.dataSource = self;
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"pic3.jpg"] ];
    
    
   // picker.hidden = YES;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*- (IBAction)SelectAction:(id)sender {
    picker.hidden = NO;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.6];
    [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    self.picker.frame = CGRectMake(0, 245, 320, 260);
    
    [UIView setAnimationDelegate:self];
    
    // [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
}

- (IBAction)SpeicherAction:(id)sender {
    NSInteger fachRow = [picker selectedRowInComponent:FachComponent];
    NSInteger cemestRow = [picker selectedRowInComponent:SemesterComponent];
    
    NSString *afach= [self.fach objectAtIndex:fachRow];
    NSString *asemester = [self.semester objectAtIndex:cemestRow];
    
    NSString *title = [[NSString alloc] initWithFormat:@"Anwndungsfach:%@", afach];
    NSString *message = [[NSString alloc] initWithFormat:@"%@Semester", asemester];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil];
    
    [alert show];
    
 
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        [UIView beginAnimations:nil context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.6];
        self.picker.frame = CGRectMake(0, 480, 320, 260);
        
        [UIView setAnimationDelegate:self];
        
        //[UIView setAnimationDidStopSelector:@selector(animationFinished)];
        [UIView commitAnimations];
        NSUserDefaults *mydefault = [NSUserDefaults standardUserDefaults];
        NSInteger fachRow = [picker selectedRowInComponent:FachComponent];
        NSInteger cemestRow = [picker selectedRowInComponent:SemesterComponent];
        
        adfach = [self.fach objectAtIndex:fachRow];
        semesteranzahl = [self.semester objectAtIndex:cemestRow];
        [mydefault setObject:adfach forKey:@"AF"];
        [mydefault setObject:semesteranzahl forKey:@"SA"];
        [mydefault synchronize];
        picker.hidden = YES;
        
    }
    //else {
    
    //}
}*/

#pragma mark -
#pragma mark Picker Date Source Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == FachComponent) {
        return [self.fach count];
    }
    if (component == SemesterComponent) {
        return [self.semester count];
    }
    return 0;
}

#pragma mark Picker Delegate Methods
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == FachComponent) {
        return [self.fach objectAtIndex:row];
    }
    if (component == SemesterComponent) {
        return [self.semester objectAtIndex:row];
    }
    return 0;
}
-(void)cancelLocatePicker
{
    //[self.picker cancelpicker];
    self.picker.delegate = nil;
    self.picker = nil;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == FachComponent) {
        NSInteger fachRow = [picker selectedRowInComponent:FachComponent];
        NSString *afach= [self.fach objectAtIndex:fachRow];
        Fachlabel.text = afach;
        
        
        
    }
    if (component == SemesterComponent){
        NSInteger cemest = [picker selectedRowInComponent:SemesterComponent];
        
        
        NSString *asemester = [self.semester objectAtIndex:cemest];
        
        Semesterlabel.text = asemester;
    }
}





- (IBAction)StartAction:(id)sender {
    NSUserDefaults *mydefault = [NSUserDefaults standardUserDefaults];
    NSInteger fachRow = [picker selectedRowInComponent:FachComponent];
    NSInteger cemestRow = [picker selectedRowInComponent:SemesterComponent];
    
    adfach = [self.fach objectAtIndex:fachRow];
    semesteranzahl = [self.semester objectAtIndex:cemestRow];
    [mydefault setObject:adfach forKey:@"AF"];
    [mydefault setObject:semesteranzahl forKey:@"SA"];
    [mydefault synchronize];
    
    //0: KW
    //1: MMI
    //2: MG
    //3: BWL
    int urlId = 1;
    if ([adfach isEqualToString:@"KW"]) {
        urlId = 0;
    }
    else if ([adfach isEqualToString:@"MMI"]) {
        urlId = 1;
    }
    else if ([adfach isEqualToString:@"MG"]) {
        urlId = 2;
    }
    else if ([adfach isEqualToString:@"BWL"]) {
        urlId = 3;
    }
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate fetchEntriesWithUrlId:urlId];
    
    [NSThread sleepForTimeInterval:4];
}



@end
