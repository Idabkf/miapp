//
//  PopoverViewController.m
//  PEM
//
//  Created by Sandra Zollner on 01.06.13.
//  Copyright (c) 2013 Sandra Zollner. All rights reserved.
//

#import "DetailPopoverViewController.h"

@interface DetailPopoverViewController ()<UIAlertViewDelegate, UITextFieldDelegate>

@end

@implementation DetailPopoverViewController
@synthesize semestersdicView, picker, gradeArray, noGradeArray, titleLabel, titleString, delegate, seminarTitle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"grey.jpg"] ];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.shadowColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont fontWithName:@"AppleGothic" size:20.0];
    
    self.ectsLabel.textColor = [UIColor whiteColor];
    self.ectsLabel.font = [UIFont fontWithName:@"AppleGothic" size:18.0];
    
    self.belegtLabel.textColor = [UIColor whiteColor];
    self.belegtLabel.font = [UIFont fontWithName:@"AppleGothic" size:18.0];
    
    self.bestandenLabel.textColor = [UIColor whiteColor];
    self.bestandenLabel.font = [UIFont fontWithName:@"AppleGothic" size:18.0];
    
    self.noteField.hidden = YES;
    self.noteField.delegate = self;
    
    self.noteLabel.hidden =YES;
    self.noteLabel.textColor = [UIColor whiteColor];
    self.noteLabel.font = [UIFont fontWithName:@"AppleGothic" size:18.0];
    
    self.ungradedLabel.hidden = YES;
    self.ungradedLabel.textColor = [UIColor whiteColor];
    self.ungradedLabel.font = [UIFont fontWithName:@"AppleGothic" size:18.0];
    
    self.picker.hidden = YES;
    
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
    
    self.titleLabel.text = self.titleString;
    
    self.gradeArray = [[NSArray alloc] initWithObjects: @"1.0",@"1.3",@"1.7",@"2.0",@"2.3",@"2.7",@"3.0",@"3.3",@"3.7",@"4.0", nil];
    
    [picker selectRow:0 inComponent:0 animated:YES];
    
    //get grade
    //iterate all semesters
    for(id key in semestersdicView){
        
        NSMutableDictionary *semester = semestersdicView[key];
        NSMutableArray *lecturesArray = [semester objectForKey:@"lectures"];
        
        
        //iterate all lectures
        for(int i= 0; i < lecturesArray.count; i++){
            //iterate all grades
            for (int j= 0; j < gradeArray.count; j++){
            
            NSString *title = [[lecturesArray objectAtIndex:i] [@"title"] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            
            if([title isEqualToString:titleString] ||
               [title isEqualToString:seminarTitle]){
                
                if([[lecturesArray objectAtIndex:i] [@"grade"]  isEqualToString: [gradeArray objectAtIndex:j]]){
                    [picker selectRow:j inComponent:0 animated:YES];
                }
                if([[lecturesArray objectAtIndex:i] [@"grade"]  isEqualToString: @""] &&
                   [[lecturesArray objectAtIndex:i] [@"passed"]  isEqualToString: @"YES"] ){
                    [picker selectRow:1 inComponent:0 animated:YES];
                } 
                
            }
            }
        }
        
    }
    int index = self.semesterIndex + 1;
    NSString *key = [NSString stringWithFormat: @"%i", index];
    NSLog(@"key %@", key);
    
    NSMutableDictionary *semester2 = semestersdicView[key];
    NSMutableArray *lecturesArray = [semester2 objectForKey:@"lectures"];
    int i = self.lectureIndex;
    lecture = [lecturesArray objectAtIndex:i];
    

    self.ectsLabel.text = [NSString stringWithFormat: @"%@ ECTS", lecture [@"ects"]];
    if([lecture [@"passed"] isEqualToString:@"YES"] &&
       ([lecture [@"tmpTitle"] isEqualToString:@""] ||
        [lecture [@"tmpTitle"] isEqualToString:titleString] )){
        self.bestandenSwitch.on = YES;
        self.noteLabel.hidden = NO;
        self.noteField.hidden = NO;
        self.noteField.text = lecture [@"grade"];}
    if([lecture [@"attending"] isEqualToString:@"YES"]&&
       ([lecture [@"tmpAttending"] isEqualToString:@""] ||
        [lecture [@"tmpAttending"] isEqualToString:titleString] )){
        self.belegtSwitch.on = YES;
    }
    
    if([lecture [@"graded"]  isEqualToString: @"NO"]){
        self.noteLabel.hidden =YES;
        self.noteField.hidden = YES;
    }
    


    
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

}

- (IBAction)saveAction:(id)sender {
    
    if(self.picker.hidden){
        [self.delegate dismissPopover];
        [self.delegate2 dismissPopover];
        return;
    }
    
    NSInteger row = [picker selectedRowInComponent:0];
    NSString *resultString = [gradeArray objectAtIndex:row];
    
    NSString *tmpTitle = titleString;
    

                //save grade
                [lecture setObject: resultString forKey:@"grade"];
                [lecture setObject:@"YES" forKey:@"passed"];
                
                
                if (self.modulFlag == 4 || self.modulFlag == 1 || self.modulFlag == 2 || self.modulFlag == 3) {
                    [lecture setObject:tmpTitle forKey:@"tmpTitle"];
                    [lecture setObject:self.seminarTitle forKey:@"tmpTitle2"];
                }
                self.noteField.text = lecture [@"grade"];
                
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *documentsDirectory = [paths objectAtIndex:0];
                NSString *plistLocation = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
                [self.semestersdicView writeToFile:plistLocation atomically: YES];
    
    
    self.titleString = tmpTitle;
    [self.delegate.tableView reloadData];

    self.delegate2.chosenLecture = titleString;
    [self.delegate2 updateTable];
    [self.delegate2.tableView reloadData];


    self.picker.hidden = YES;
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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    // Show UIPickerView
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)myTextField{
    
    [myTextField resignFirstResponder];
    
    picker.hidden = NO;
    self.noteField.inputView = picker;
    
    
}

-(void) saveToPlist{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistLocation = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
    [self.semestersdicView writeToFile:plistLocation atomically: YES];

    [self.delegate.tableView reloadData];
    [self.delegate2 updateTable];
    [self.delegate2.tableView reloadData];

}

- (IBAction)belegen:(id)sender {
    if(self.belegtSwitch.on){
        [lecture setObject:@"YES" forKey:@"attending"];
        if (self.modulFlag == 4 || self.modulFlag == 1 || self.modulFlag == 2 || self.modulFlag == 3) {
            [lecture setObject:titleString forKey:@"tmpAttending"];
            [lecture setObject:self.seminarTitle forKey:@"tmpAttending2"];
        }

    }
    else {
        [lecture setObject:@"NO" forKey:@"attending"];
        if (self.modulFlag == 4 || self.modulFlag == 1 || self.modulFlag == 2 || self.modulFlag == 3) {
            [lecture setObject:@"" forKey:@"tmpAttending"];
            [lecture setObject:@"" forKey:@"tmpAttending2"];
        }
        
    }
    [self saveToPlist];
}

- (IBAction)bestanden:(id)sender {
    if(self.bestandenSwitch.on){
        
        self.noteLabel.hidden = NO;
        self.noteField.hidden = NO;
        self.ungradedLabel.hidden = YES;
        NSString *tmpTitle = titleString;
        if([lecture [@"graded"]  isEqualToString: @"NO"]){
            self.noteLabel.hidden = NO;
            self.noteField.hidden = YES;
            self.ungradedLabel.hidden = NO;
            [lecture setObject:@"YES" forKey:@"passed"];
            if (self.modulFlag == 4 || self.modulFlag == 1 || self.modulFlag == 2 || self.modulFlag == 3) {
                [lecture setObject:tmpTitle forKey:@"tmpTitle"];
                [lecture setObject:self.seminarTitle forKey:@"tmpTitle2"];
            }
        }

    }
    else {
        [lecture setObject:@"NO" forKey:@"passed"];
        [lecture setObject:@"" forKey:@"grade"];
        self.noteField.text = @"-";
        [picker selectRow:0 inComponent:0 animated:YES];
        
        self.noteLabel.hidden = YES;
        self.noteField.hidden = YES;
        self.ungradedLabel.hidden = YES;
        if (self.modulFlag == 4 || self.modulFlag == 1 || self.modulFlag == 2 || self.modulFlag == 3) {
            [lecture setObject:@"" forKey:@"tmpTitle"];
            [lecture setObject:@"" forKey:@"tmpTitle2"];
        }
    }
    [self saveToPlist];
}
@end
