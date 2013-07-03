//
//  ViewController2.m
//  testmi
//
//  Created by Sandra Zollner on 11.06.13.
//  Copyright (c) 2013 danqing liu. All rights reserved.
//

#import "ViewController2.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController2 ()

@end

@implementation ViewController2
@synthesize semestersdicView, gradeArray, GradesAndLectures, backg;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)setCalculation:(id)sender {
    
    if (self.calcBtn.selected) {
        [self setAlternativeGrades:YES];
        [self updateTable];
        self.calcLabel.text = @"Echte Noten?";
    } else {
        [self setAlternativeGrades:NO];
        [self updateTable];
        self.calcLabel.text = @"Verbessern?";
    }
    
    self.calcBtn.selected = !self.calcBtn.selected;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    NSLog(@"Checking orientation %d", interfaceOrientation);
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}




- (void) updateTable
{

    //get data of plist
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistLocation = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistLocation];
    NSPropertyListFormat format;
    NSString *errorDesc = nil;
    semestersdicView = (NSMutableDictionary *)[NSPropertyListSerialization
                                               propertyListFromData:plistXML
                                               mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                               format:&format
                                               errorDescription:&errorDesc]; 
    self.gradeArray = [[NSArray alloc] initWithObjects:@"1.0",@"1.3",@"1.7",@"2.0",@"2.3",@"2.7",@"3.0",@"3.3",@"3.7",@"4.0",@"Noch keine Note",@"Unbenotete Fächer",nil];
    
    self.GradesAndLectures = [NSMutableDictionary dictionaryWithObjects: [NSArray arrayWithObjects: [NSMutableArray array],[NSMutableArray array],[NSMutableArray array],[NSMutableArray array],[NSMutableArray array],[NSMutableArray array],[NSMutableArray array],[NSMutableArray array],[NSMutableArray array],[NSMutableArray array],[NSMutableArray array],[NSMutableArray array],nil]
                  
                                                                forKeys: gradeArray];
  
    //iterate all semesters
    for(id key in semestersdicView){
        
        NSMutableDictionary *semester = semestersdicView[key];
        NSMutableArray *lecturesArray = [semester objectForKey:@"lectures"];
        
        
        //iterate all lectures
        for(int i= 0; i < lecturesArray.count; i++){
            
            //iterate all grades
            for (int j= 0; j < gradeArray.count; j++){
                
                
                //if grade of lecture is 1.0 for example, the name of the lecture is added to the dictionary with key 1.0
                if(
                   [[lecturesArray objectAtIndex:i] [@"grade"] isEqualToString:[gradeArray objectAtIndex:j]]
                   
                   ||
                   
                   //or if not graded yet it's added to key "Noch Keine Note"
                   ([[lecturesArray objectAtIndex:i] [@"grade"] isEqualToString:@""] &&
                    [[lecturesArray objectAtIndex:i] [@"passed"] isEqualToString:@"NO"] &&
                    [@"Noch keine Note" isEqualToString:[gradeArray objectAtIndex:j]])
                   
                   ||
                   
                   //or if it's passed but no grade
                   ([[lecturesArray objectAtIndex:i] [@"passed"] isEqualToString:@"YES"] &&
                    [[lecturesArray objectAtIndex:i] [@"grade"] isEqualToString:@""] &&
                    [@"Unbenotete Fächer"isEqualToString:[gradeArray objectAtIndex:j]])
                   
                   )
                    
                    
                {
                    BOOL otherGradeFound = NO;
                    //show modified grades
                    for (int k= 0; k < gradeArray.count; k++){
                            if([[lecturesArray objectAtIndex:i] [@"otherGrade"] isEqualToString:[gradeArray objectAtIndex:k]] && self.alternativeGrades){
                               
                            NSMutableArray *lecturesArray1 = [self.GradesAndLectures objectForKey:[gradeArray objectAtIndex:k]];
                            [lecturesArray1 addObject:[lecturesArray objectAtIndex:i]];
                                otherGradeFound = YES;
                            }
                        }
 
                    if(!otherGradeFound || !self.alternativeGrades){
                    NSMutableArray *lecturesArray1 = [self.GradesAndLectures objectForKey:[gradeArray objectAtIndex:j]];
                    [lecturesArray1 addObject:[lecturesArray objectAtIndex:i]];
                    }
                }
            
                //show normal grades
                if([[lecturesArray objectAtIndex:i] [@"otherGrade"] isEqualToString:[gradeArray objectAtIndex:j]] && !self.alternativeGrades)
                {
                    NSMutableArray *lecturesArray1 = [self.GradesAndLectures objectForKey:[gradeArray objectAtIndex:j]];
                    [lecturesArray1 removeObject:[lecturesArray objectAtIndex:i]];
                }
                
                if( ![[lecturesArray objectAtIndex:i] [@"grade"] isEqualToString:@""] &&
                   [[lecturesArray objectAtIndex:i] [@"otherGrade"] isEqualToString: [lecturesArray objectAtIndex:i] [@"grade"]])
                {
                    
                    [[lecturesArray objectAtIndex:i] setObject: @"" forKey:@"otherGrade"];
                }
                

                
            }
        }
    }
    
    self.averageLabel.text =  [[NSString alloc] initWithFormat:
                               @"Dein Schnitt: %.2f\n%i ECTS",[[self calculateAverageOfGrades] floatValue], [[self getAmountEcts]intValue]];

    [self.tableView reloadData];
    
}

- (IBAction)menubt:(id)sender {
    if(self.menu.hidden ==YES){
        self.menu.hidden = NO;
        self.saveBtn.hidden = NO;
        self.edit.hidden = NO;
        self.calcBtn.hidden = NO;
        self.saveLab.hidden = NO;
        self.calcLab.hidden = NO;
        self.editLab.hidden = NO;
        //self.
    }
    else{self.menu .hidden =YES;
        self.saveBtn.hidden = YES;
        self.edit.hidden = YES;
        self.calcBtn.hidden = YES;
        self.saveLab.hidden = YES;
        self.calcLab.hidden = YES;
        self.editLab.hidden = YES;}
    
    [self.bt setBackgroundImage:[UIImage imageNamed:@"upArrow.png" ]forState:UIControlStateSelected];
    self.bt = (UIButton *)sender;
    self.bt.selected = !self.bt.selected;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self updateTable];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.alternativeGrades = NO;
    self.calcBtn.selected = YES;
    self.menu.backgroundColor = [[UIColor alloc] initWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    self.menu.hidden= YES;
    self.saveBtn.hidden = YES;
    self.edit.hidden = YES;
    self.calcBtn.hidden = YES;
    self.saveLab.hidden = YES;
    self.calcLab.hidden = YES;
    self.editLab.hidden = YES;

    [self updateTable];
    //self.tableView.backgroundColor=[UIColor colorWithRed:(155.0/255.0) green:(205.0/255.0) blue:(155.0/255.0) alpha:.5];
    self.averageLabel.layer.cornerRadius = 8;
    self.averageLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    self.averageLabel.layer.borderWidth = 1.0;
    self.averageLabel.backgroundColor=[UIColor colorWithRed:(224.0/255.0) green:(238.0/255.0) blue:(224.0/255.0) alpha:.15];
    self.averageLabel.font = [UIFont fontWithName:@"AppleGothic" size:18.0];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
  //  self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"green4.jpg"] ];
   // self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"woood1.jpg"] ];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.bounces = YES;
    
    NSUserDefaults *mydefault = [NSUserDefaults standardUserDefaults];
    NSString *image = [mydefault stringForKey:@"BildName"];
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:image] ];
    self.backg.image = [UIImage imageNamed:image];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return gradeArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    //counts how many lectures for one grade
    NSArray *lectures = [GradesAndLectures objectForKey:[gradeArray objectAtIndex:section]];
    return lectures.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell2";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if ( cell ==nil ){
        cell =[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.opaque = NO;
    NSArray *lectures = [GradesAndLectures objectForKey:[gradeArray objectAtIndex:indexPath.section]];


    NSString *title = [lectures objectAtIndex:indexPath.row][@"title"];
    if(![[lectures objectAtIndex:indexPath.row][@"tmpTitle"] isEqualToString:@""]){
        title = [lectures objectAtIndex:indexPath.row][@"tmpTitle"];
    }
    cell.textLabel.text = title;
    cell.textLabel.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    if(![[lectures objectAtIndex:indexPath.row][@"otherGrade"] isEqualToString:@""] &&self.alternativeGrades){
        //  cell.contentView.backgroundColor=[UIColor lightGrayColor];
        cell.backgroundColor=[UIColor colorWithRed:(2554.0/255.0) green:(069.0/255.0) blue:(000.0/255.0) alpha:.4];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        //  cell.textLabel.backgroundColor = [UIColor lightGrayColor];
    }else {
        //cell.contentView.backgroundColor=[UIColor whiteColor];
        //cell.textLabel.backgroundColor = [UIColor whiteColor];
        
        cell.backgroundColor=[UIColor colorWithRed:(224.0/255.0) green:(238.0/255.0) blue:(224.0/255.0) alpha:.15];
        cell.textLabel.backgroundColor = [UIColor clearColor];
    }
    
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* myView = [[UIView alloc] init];
    myView.backgroundColor = [UIColor clearColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 8, 220, 22)];
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName:@"Georgia" size:20.0];
    // titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
    
    titleLabel.text =[gradeArray objectAtIndex:section];
    
    
    [myView addSubview:titleLabel];
    
    
    return myView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [gradeArray objectAtIndex:section];

}


- (NSIndexPath *)tableView:(UITableView *)tableView
targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath
       toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    return proposedDestinationIndexPath;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
        NSMutableArray *lecturesWithGradeX = [self.GradesAndLectures objectForKey:[gradeArray objectAtIndex:sourceIndexPath.section]];
    //get the selected lecture
        NSMutableDictionary *lecture = [lecturesWithGradeX objectAtIndex:sourceIndexPath.row];
    
    
    
    //iterate all semesters
    for(id key in semestersdicView){
        
        NSMutableDictionary *semester = semestersdicView[key];
        NSMutableArray *lecturesArray = [semester objectForKey:@"lectures"];
        
        //iterate all lectures
        for(int i= 0; i < lecturesArray.count; i++){
            if([[lecturesArray objectAtIndex:i] [@"title"] isEqualToString: lecture [@"title"]]){
                
                //set as other grade because not real grade
                [[lecturesArray objectAtIndex:i] setObject: [gradeArray objectAtIndex:destinationIndexPath.section] forKey:@"otherGrade"];
                
                if([[lecturesArray objectAtIndex:i][@"grade"] isEqualToString:[gradeArray objectAtIndex:destinationIndexPath.section]]){
                    [[lecturesArray objectAtIndex:i] setObject: @"" forKey:@"otherGrade"];
                }
                if(destinationIndexPath.section == 10){
                    [[lecturesArray objectAtIndex:i] setObject: @"" forKey:@"otherGrade"];
                }
            }
        }
        
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistLocation = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
    [self.semestersdicView writeToFile:plistLocation atomically: YES];


    self.calcBtn.selected = NO;
    [self setAlternativeGrades:YES];
    self.calcLabel.text = @"Echte Noten?";
    
    [self updateTable];
    [self.tableView endUpdates];
    
}

- (NSDecimalNumber *) getAmountEcts
{
    NSDecimalNumber *ectsSumGr = [[NSDecimalNumber alloc]initWithString: @"0.00"];

    //iterate all semesters
    for(id key in semestersdicView){
        
        NSMutableDictionary *semester = semestersdicView[key];
        NSMutableArray *lecturesArray = [semester objectForKey:@"lectures"];
        NSLog(@"LECTURES ARRAY: %@", lecturesArray);
        //iterate all lectures
        for(int i= 0; i < lecturesArray.count; i++){
            
            if([lecturesArray objectAtIndex:i] [@"grade"] != nil && ![[lecturesArray objectAtIndex:i] [@"grade"] isEqualToString:@""] ){
                
                NSString *ects = [lecturesArray objectAtIndex:i] [@"ects"];
                ects = [ects stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                ects = [NSString stringWithFormat: @"%@.00", ects];
                
                
                NSDecimalNumber *ectsNumber = [[NSDecimalNumber alloc]initWithString: ects];
                
                ectsSumGr = [ectsSumGr decimalNumberByAdding: ectsNumber];

            }
            
            else if([[lecturesArray objectAtIndex:i] [@"passed"] isEqualToString:@"YES"] ){
                NSString *ects = [lecturesArray objectAtIndex:i] [@"ects"];
                ects = [ects stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                ects = [NSString stringWithFormat: @"%@.00", ects];
                NSDecimalNumber *ectsNumber = [[NSDecimalNumber alloc]initWithString: ects];
                ectsSumGr = [ectsSumGr decimalNumberByAdding: ectsNumber];
            }
        }
        
    }

    return ectsSumGr;
}


- (NSDecimalNumber *) calculateAverageOfGrades
{
    NSDecimalNumber *ectsSumGr = [[NSDecimalNumber alloc]initWithString: @"0.00"];
    NSDecimalNumber *ectsSumUngr = [[NSDecimalNumber alloc]initWithString: @"0.00"];
    NSDecimalNumber *sum = [[NSDecimalNumber alloc]initWithString: @"0.00"];
    NSDecimalNumber *average = [[NSDecimalNumber alloc]initWithString: @"0.00"];
    
    NSDecimalNumber *zero = [[NSDecimalNumber alloc]initWithString: @"0.00"];
    
    NSMutableDictionary *gradesDic = [[NSMutableDictionary alloc] init];
    [gradesDic setValue:zero forKey:@"1.00"];
    [gradesDic setValue:zero forKey:@"1.30"];
    [gradesDic setValue:zero forKey:@"1.70"];
    [gradesDic setValue:zero forKey:@"2.00"];
    [gradesDic setValue:zero forKey:@"2.30"];
    [gradesDic setValue:zero forKey:@"2.70"];
    [gradesDic setValue:zero forKey:@"3.00"];
    [gradesDic setValue:zero forKey:@"3.30"];
    [gradesDic setValue:zero forKey:@"3.70"];
    [gradesDic setValue:zero forKey:@"4.00"];
    
    
    //iterate all semesters
    for(id key in semestersdicView){
        
        NSMutableDictionary *semester = semestersdicView[key];
        NSMutableArray *lecturesArray = [semester objectForKey:@"lectures"];
        NSLog(@"LECTURES ARRAY: %@", lecturesArray);
        //iterate all lectures
        for(int i= 0; i < lecturesArray.count; i++){
           
            if([lecturesArray objectAtIndex:i] [@"grade"] != nil && ![[lecturesArray objectAtIndex:i] [@"grade"] isEqualToString:@""] ){
    
                NSString *ects = [lecturesArray objectAtIndex:i] [@"ects"];
                ects = [ects stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                ects = [NSString stringWithFormat: @"%@.00", ects];
                                
                NSString *grade = @"";
                grade = [lecturesArray objectAtIndex:i] [@"grade"];
                
                //calculate average with other grades
                if( ![[lecturesArray objectAtIndex:i] [@"otherGrade"] isEqualToString:@""] &&
                   self.alternativeGrades){
                    grade = [lecturesArray objectAtIndex:i] [@"otherGrade"];
                }
                
                grade = [grade stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                grade = [NSString stringWithFormat: @"%@0", grade];
                
                NSDecimalNumber *ectsNumber = [[NSDecimalNumber alloc]initWithString: ects];
                
                NSDecimalNumber *ectsPerGrade = [gradesDic objectForKey:grade];
                ectsPerGrade = [ectsPerGrade decimalNumberByAdding:ectsNumber];
                [gradesDic setValue:ectsPerGrade forKey:grade];
                
                
                ectsSumGr = [ectsSumGr decimalNumberByAdding: ectsNumber];
                NSLog(@"GRADE: %@ ECTS: %@ ECTSPERGRADE: %@ ECTSSUM: %@", grade, ects, ectsPerGrade, ectsSumGr);
            }
            
            else if([[lecturesArray objectAtIndex:i] [@"passed"] isEqualToString:@"YES"] ){
                NSString *ects = [lecturesArray objectAtIndex:i] [@"ects"];
                ects = [ects stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                ects = [NSString stringWithFormat: @"%@.00", ects];
                NSDecimalNumber *ectsNumber = [[NSDecimalNumber alloc]initWithString: ects];
                ectsSumUngr = [ectsSumUngr decimalNumberByAdding: ectsNumber];
            }
        }
        
    }
    
    //********** Mülltonnenregel ***********
    NSDecimalNumber *ectsSum = [[NSDecimalNumber alloc]initWithString: @"0.00"];
    ectsSum = [ectsSumUngr decimalNumberByAdding: ectsSumGr];
    
    NSDecimalNumberHandler *mydnh = [[NSDecimalNumberHandler alloc] initWithRoundingMode:NSRoundPlain
                                                                                   scale:0
                                                                        raiseOnExactness:NO
                                                                         raiseOnOverflow:NO
                                                                        raiseOnUnderflow:NO
                                                                     raiseOnDivideByZero:NO];
    
    NSDecimalNumber *trash = [ectsSum decimalNumberByDividingBy:[[NSDecimalNumber alloc]initWithString: @"6.00"]];
    trash = [trash decimalNumberByRoundingAccordingToBehavior:mydnh];
    
    NSLog(@"ECTS SUMSUMSUMSUM: %@", ectsSum);
    NSLog(@"ECTS SUMGR BEFORE: %@", ectsSumGr);
    ectsSumGr = [ectsSumGr decimalNumberBySubtracting:trash];
    NSLog(@"ECTS SUMGR AFTER: %@", ectsSumGr);
    NSLog(@"TRASH: %@", trash);

    NSArray *sortedKeys = [[gradesDic allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    for (int i = sortedKeys.count-1; i>=0; i--) {
        NSString *gradeKey = [sortedKeys objectAtIndex:i];
        NSDecimalNumber *ectsPerGrade = [gradesDic valueForKey:gradeKey];
        if ([ectsPerGrade compare:trash] == NSOrderedSame || [ectsPerGrade compare:trash] == NSOrderedDescending) {
            ectsPerGrade = [ectsPerGrade decimalNumberBySubtracting:trash];
            trash = [[NSDecimalNumber alloc]initWithString: @"0.00"];
            [gradesDic setValue:ectsPerGrade forKey:gradeKey];
        }
        else {
            trash = [trash decimalNumberBySubtracting:ectsPerGrade];
            ectsPerGrade = [[NSDecimalNumber alloc]initWithString: @"0.00"];
            [gradesDic setValue:ectsPerGrade forKey:gradeKey];
        }
        
        NSDecimalNumber *gradeNumber = [[NSDecimalNumber alloc]initWithString: gradeKey];
        NSDecimalNumber *sumTmp = [gradeNumber decimalNumberByMultiplyingBy:ectsPerGrade];
        sum =[sum decimalNumberByAdding: sumTmp];
        NSLog(@"SUM-TMP: %@ at grade %@", sumTmp, gradeKey);
    }
    
    if(![ectsSumGr.stringValue isEqualToString:@"0"]){
        
    //NSDecimalNumber *bestOf = [[NSDecimalNumber alloc]initWithString: @"0.00"];
    average = [sum decimalNumberByDividingBy:ectsSumGr];
    }
    
    return average;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView setEditing:YES animated:YES];
    // return UITableViewCellEditingStyleDelete;
    return UITableViewCellEditingStyleNone;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (IBAction)Edit:(id)sender {
    
    if(self.editing)
    {
        [self.tableView setEditing:NO animated:NO];
        
    }
    else
    {
        [self.tableView setEditing:YES animated:YES];
        
    }
}
- (IBAction)Save:(id)sender {
    
    [self.tableView setEditing:NO animated:NO];
    // self.menu.hidden = YES;
    //[self.bt setBackgroundImage:[UIImage imageNamed:@"upArrow1.png" ]forState:UIControlStateSelected];
    // self.bt = (UIButton *)sender;
    // self.bt.selected = !self.bt.selected
}

@end
