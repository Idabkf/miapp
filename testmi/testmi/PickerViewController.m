//
//  PickerViewController.m
//  testmi
//
//  Created by danqing liu on 13-6-11.
//  Copyright (c) 2013年 danqing liu. All rights reserved.
//

#import "PickerViewController.h"
#import "ViewController1.h"

@interface PickerViewController ()<UIAlertViewDelegate,UITextFieldDelegate>

@end

@implementation PickerViewController
@synthesize picker;
@synthesize list;
@synthesize semester;
@synthesize fach;
//@synthesize select;
@synthesize speicher,SemesterField,FachField;
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
    
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"grey.jpg"] ];
    FachField.delegate=self;
    SemesterField.delegate = self;
   
    self.picker.frame = CGRectMake(0, 480, 320, 260);
    NSUserDefaults *mydefault = [NSUserDefaults standardUserDefaults];
    FachField .text = [mydefault stringForKey:@"AF"];
    SemesterField.text = [mydefault stringForKey:@"SA"];
    
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
    
    
    picker.hidden = YES;
    
   // [self.view addSubview:picker];
    FachField.backgroundColor = [UIColor whiteColor];
    SemesterField.backgroundColor = [UIColor whiteColor];
       
}

- (void)viewDidUnload
{
    [self cancelLocatePicker];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.picker = nil;
    self.list = nil;
    self.fach = nil;
    self.semester = nil;
    
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
}*/


- (IBAction)SpeicherAction:(id)sender {
    
       
    NSInteger fachRow = [picker selectedRowInComponent:FachComponent];
    NSInteger cemestRow = [picker selectedRowInComponent:SemesterComponent];
    
   // NSString *afach= [self.fach objectAtIndex:fachRow];
    //NSString *asemester = [self.semester objectAtIndex:cemestRow];
    NSUserDefaults *mydefault = [NSUserDefaults standardUserDefaults];
    NSString *fach1 = [mydefault stringForKey:@"AF"];
    NSString *sem = [mydefault stringForKey:@"SA"];
    
    NSString *title = [[NSString alloc] initWithFormat:@"Anwndungsfach:%@", fach1];
    NSString *message = [[NSString alloc] initWithFormat:@"%@Semester", sem];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
     
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
        //NSInteger fachRow = [picker selectedRowInComponent:FachComponent];
        //NSInteger cemestRow = [picker selectedRowInComponent:SemesterComponent];

        //adfach = [self.fach objectAtIndex:fachRow];
        //semesteranzahl = [self.semester objectAtIndex:cemestRow];
        [mydefault setObject:FachField.text  forKey:@"AF"];
        [mydefault setObject:SemesterField.text forKey:@"SA"];
         [mydefault synchronize];
        picker.hidden = YES;
    
        
        
        
    
    }
    //else {
        
    //}
}


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
        FachField.text = afach;
       NSUserDefaults *mydefault = [NSUserDefaults standardUserDefaults];
       [mydefault setObject:FachField.text  forKey:@"AF"];
       [mydefault synchronize];
    }
    if (component == SemesterComponent){
      NSInteger cemest = [picker selectedRowInComponent:SemesterComponent];
    
    
    NSString *asemester = [self.semester objectAtIndex:cemest];
   
    SemesterField.text = asemester;
        NSUserDefaults *mydefault = [NSUserDefaults standardUserDefaults];
        [mydefault setObject:SemesterField.text  forKey:@"SA"];
        [mydefault synchronize];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    // Show UIPickerView
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)myTextField{
    
    [myTextField resignFirstResponder];
    
    picker.hidden = NO;
    FachField.inputView = picker;
    SemesterField.inputView = picker;
    
    
    
    
}





@end
