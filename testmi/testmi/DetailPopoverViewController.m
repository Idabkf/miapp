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
@synthesize semestersdicView, picker, gradeArray, noGradeArray, titleString, delegate;

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
    
    self.gradeArray = [[NSArray alloc] initWithObjects:
                         @"Nicht Bestanden", @"Bestanden - Unbenotet", @"1.0", @"1.3",@"1.7",@"2.0",@"2.3",@"2.7",@"3.0",@"3.3",@"3.7",@"4.0", nil];
    
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
            if([title isEqualToString:titleString]){
                
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
    
    NSInteger row = [picker selectedRowInComponent:0];
    NSString *resultString = [gradeArray objectAtIndex:row];
    NSLog(@"result %@", resultString);
    //iterate all semesters
    for(id key in semestersdicView){
        
        NSMutableDictionary *semester = semestersdicView[key];
        NSMutableArray *lecturesArray = [semester objectForKey:@"lectures"];
        
        
        //iterate all lectures
        for(int i= 0; i < lecturesArray.count; i++){
            
            NSString *title = [[lecturesArray objectAtIndex:i] [@"title"] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            if([title isEqualToString:titleString]){
                
 
                
                if(row == 0){
                    [[lecturesArray objectAtIndex:i] setObject: @"" forKey:@"grade"];
                    [[lecturesArray objectAtIndex:i] setObject:@"NO" forKey:@"passed"];
                }
                else if(row == 1){
                    [[lecturesArray objectAtIndex:i] setObject: @"" forKey:@"grade"];
                    [[lecturesArray objectAtIndex:i] setObject:@"YES" forKey:@"passed"];
                    
                } else {
                    [[lecturesArray objectAtIndex:i] setObject: resultString forKey:@"grade"];
                    [[lecturesArray objectAtIndex:i] setObject:@"YES" forKey:@"passed"];
                }
                
                
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *documentsDirectory = [paths objectAtIndex:0];
                NSString *plistLocation = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
                [self.semestersdicView writeToFile:plistLocation atomically: YES];
                
            }
        }
        
    }
    [self.delegate dismissPopover];
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
