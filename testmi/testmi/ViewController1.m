//
//  ViewController1.m
//  testmi
//
//  Created by danqing liu on 13-6-10.
//  Copyright (c) 2013年 danqing liu. All rights reserved.
//

#import "ViewController1.h"
#import "DetailPopoverViewController.h"
#import "PopoverTable.h"
#import "FPPopoverController.h"

@interface ViewController1 ()

@end

@implementation ViewController1
@synthesize semestersdicView;




- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)updatePlist
{
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
}

- (void)viewWillAppear:(BOOL)animated
{
    [self updatePlist];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.menu.backgroundColor = [[UIColor alloc] initWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    self.menu.hidden = YES;
    
    self.titleLabelBig.font = [UIFont fontWithName:@"AppleGothic" size:21.0];
    self.titleLabelBig.backgroundColor=[UIColor colorWithRed:(224.0/255.0) green:(238.0/255.0) blue:(224.0/255.0) alpha:.15];
    
    NSUserDefaults *mydefault = [NSUserDefaults standardUserDefaults];
    
    if([[mydefault stringForKey:@"AF"] isEqualToString: @"KW"]){
        self.titleLabelBig.text = @"Medienwirkung";
    }
    if([[mydefault stringForKey:@"AF"] isEqualToString: @"MMI"]){
        
        self.titleLabelBig.font = [UIFont fontWithName:@"AppleGothic" size:17.0];
        self.titleLabelBig.text = @"Mensch-Maschine-Interaktion";
    }
    if([[mydefault stringForKey:@"AF"] isEqualToString: @"MG"]){
        self.titleLabelBig.text = @"Mediengestaltung";
    }
    if([[mydefault stringForKey:@"AF"] isEqualToString: @"BWL"]){
        self.titleLabelBig.text = @"Medienwirtschaft";
    }
    
    self.titleLabelBig.layer.cornerRadius = 8;
    self.titleLabelBig.layer.borderColor = [UIColor whiteColor].CGColor;
    self.titleLabelBig.layer.borderWidth = 1.0;
    self.titleLabel1 .text = [mydefault stringForKey:@"AF"];
    self.titleLabel.text = [NSString stringWithFormat:@"%@. Semester", [mydefault stringForKey:@"SA"]];
    
    

    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    self.plistLocation = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
    
    self.tmp = [[NSMutableString alloc] init];
    
    self.semestersdicParser = [[NSMutableDictionary alloc] init];
    
    NSPropertyListFormat format;
    NSString *errorDesc = nil;
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:self.plistLocation];
    self.semestersdicView = (NSMutableDictionary *)[NSPropertyListSerialization
                                             propertyListFromData:plistXML
                                             mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                             format:&format
                                             errorDescription:&errorDesc];
    
    
 
    self.title = @"Semester Plan";
    //self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"green4.jpg"] ];

    
    
    NSUserDefaults *mydefaut = [NSUserDefaults standardUserDefaults];
    int number = [mydefaut integerForKey:@"Bild"];
 
    if (number == 1) {
        self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"green4.jpg"] ];
        
    }
    
    else if (number == 2){
        self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"wood1.jpg"] ];
     

<<<<<<< HEAD
    }
    
    else if (number == 3){
        self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"card.jpg"] ];
    }
    else if (number == 0){
        self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"wood1.jpg"] ];
    }
   }
=======
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//- (void)tableViewEdit:(id)sender{
  //  [self.tableView setEditing:YES animated:YES];
   //self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"green4.jpg"] ];
   self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"wood1.jpg"] ];
    //self.tableView.backgroundColor=[UIColor colorWithRed:(155.0/255.0) green:(205.0/255.0) blue:(155.0/255.0) alpha:.5];
}
>>>>>>> bab3b149a6c01b4be6ad59fbfdd1c77ee1851dc1





- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView endUpdates];
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView setEditing:YES animated:YES];
    return UITableViewCellEditingStyleDelete;
    //return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView setEditing:NO animated:YES];
    
}

- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
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
    return 9;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    // NSMutableArray * sectionArray = [arry objectAtIndex:section];
    // return sectionArray.count;
    
    
    NSInteger levelInt = section +1;
    NSString *level = [NSString stringWithFormat:@"%i", levelInt];
    NSMutableDictionary *semesterDic = [self.semestersdicView objectForKey:level];
    NSMutableArray *lecturesArray = [semesterDic objectForKey:@"lectures"];
    
    return lecturesArray.count;
    

    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if ( cell ==nil ){
        cell =[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    cell.showsReorderControl =YES;
    cell.opaque = NO;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self updatePlist];
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(showResetMenu:)];
    [cell addGestureRecognizer:longPressGesture];
    
    NSInteger levelInt = indexPath.section +1;
    NSString *level = [NSString stringWithFormat:@"%i", levelInt];
    NSMutableDictionary *semesterDic = [self.semestersdicView objectForKey:level];
    NSMutableArray *lecturesArray = [semesterDic objectForKey:@"lectures"];
    NSMutableDictionary *lectureDic = [lecturesArray objectAtIndex:[indexPath row]];
    NSString *title = [lectureDic objectForKey:@"title"];
    cell.textLabel.text = title;
    cell.textLabel.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    if([[lectureDic objectForKey:@"passed"] isEqualToString:@"YES"]){
       // cell.contentView.backgroundColor=[UIColor colorWithRed:0.02 green:0.768 blue:0.45 alpha:1];
        cell.backgroundColor = [UIColor colorWithRed:(102.0/255.0) green:(205.0/255.0) blue:(170.0/255.0) alpha:.5];
         cell.textLabel.backgroundColor = [UIColor clearColor];
    } else {
        cell.backgroundColor=[UIColor colorWithRed:(224.0/255.0) green:(238.0/255.0) blue:(224.0/255.0) alpha:.15];
        //cell.backgroundColor = [UIColor clearColor];

        cell.textLabel.backgroundColor = [UIColor clearColor];
    }
    
    
    
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    UIView* myView = [[UIView alloc] init];
    myView.backgroundColor = [UIColor clearColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 300, 25)];
    //titleLabel.textColor=[UIColor colorWithRed:(47.0/255.0) green:(47.0/255.0) blue:(47.0/255.0) alpha:1];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName:@"Georgia" size:20.0];
   // titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
    
    NSInteger levelInt = section +1;
    NSString *level = [NSString stringWithFormat:@"%i", levelInt];
    NSMutableDictionary *semesterDic = [self.semestersdicView objectForKey:level];
    NSMutableArray *lecturesArray = [semesterDic objectForKey:@"lectures"];
    
    NSDecimalNumber *ectsSum = [[NSDecimalNumber alloc]initWithString: @"0.00"];
    
        //iterate all lectures
        for(int i= 0; i < lecturesArray.count; i++){
                
                NSString *ects = [lecturesArray objectAtIndex:i] [@"ects"];
                ects = [ects stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                ects = [NSString stringWithFormat: @"%@.00", ects];
                
                NSDecimalNumber *ectsNumber = [[NSDecimalNumber alloc]initWithString: ects];
                
                ectsSum = [ectsSum decimalNumberByAdding: ectsNumber];
       
        
    }
    
    NSString *semester = [NSString stringWithFormat:@"Semester %i                       %2i ECTS", section+1, [ectsSum intValue]];
    
    titleLabel.text =semester;
    [myView addSubview:titleLabel];
     
    
    return myView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0;
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

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
    NSInteger levelIntdest = destinationIndexPath.section +1;
    NSLog(@" start %i",levelIntdest);
    
    NSInteger levelIntsource = sourceIndexPath.section +1;
    NSLog(@"%i",levelIntsource);
    NSLog(@"zeile : % i",sourceIndexPath.row);
    
    //Lecture holen
    NSMutableDictionary *semesteralt =  [self.semestersdicView objectForKey:[NSString stringWithFormat:@"%i", levelIntsource ]];
    NSMutableArray *lecturesalt = [semesteralt objectForKey:@"lectures"];
    NSMutableDictionary *lecturemoved = [lecturesalt  objectAtIndex:sourceIndexPath.row ];
    
    
    NSLog(@"%@",[lecturemoved objectForKey:@"title"]);
    
    
    //lecture in richtigen Semester speichern
    NSMutableDictionary *semesterneu =  [self.semestersdicView objectForKey:[NSString stringWithFormat:@"%i", levelIntdest ]];
    NSMutableArray *lecturesneu = [semesterneu objectForKey:@"lectures"];
    [lecturesneu insertObject:lecturemoved atIndex:destinationIndexPath.row];
    //[lecturesneu addObject:lecturemoved];
    
    //alten platz löschen
    [lecturesalt removeObjectAtIndex:sourceIndexPath.row];
    
    NSLog(@"Lectures ALT!!!!!!!!!!!!!!!! %@", lecturesalt);
    NSMutableDictionary *semester =  [self.semestersdicView objectForKey:[NSString stringWithFormat:@"%i", levelIntdest ]];
    NSMutableArray *lectures = [semester objectForKey:@"lectures"];
    NSLog(@"Lectures NEU!!!!!!!!!!!!!!!! %@", lectures);
        NSLog(@"Lectures NEU!!!!!!!!!!!!!!!! %@", lecturesneu);
    
    //write data into plist ***important***
    [self.semestersdicView writeToFile:self.plistLocation atomically: YES];
    
    [self.tableView reloadData];
    [tableView endUpdates];
    
    
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


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //popover
    
    DetailPopoverViewController *viewController = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"popover"];
    viewController.delegate = self;
    NSInteger levelInt = indexPath.section +1;
    NSString *level = [NSString stringWithFormat:@"%i", levelInt];
    NSMutableDictionary *semesterDic = [self.semestersdicView objectForKey:level];
    NSMutableArray *lecturesArray = [semesterDic objectForKey:@"lectures"];
    NSMutableDictionary *lectureDic = [lecturesArray objectAtIndex:[indexPath row]];
    NSString *title = [lectureDic objectForKey:@"title"];


    
    title = [title stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    if([title isEqualToString: @"Seminar zu ausgewählten Themen der Informatik"]){
        
        [self performSegueWithIdentifier:@"options" sender:self];

        return;
        
    }
    
    viewController.title = nil;
    viewController.titleString = title;
     //e[viewController.titleLabel setText:title];
     
     popover = [[FPPopoverController alloc] initWithViewController:viewController];
     popover.delegate = self;
     popover.tint = FPPopoverDefaultTint;
     popover.border = NO;
     //popover.tint = FPPopoverWhiteTint;
    
     popover.contentSize = CGSizeMake(290, 380);
     
     popover.arrowDirection = FPPopoverNoArrow;
     [popover presentPopoverFromPoint: CGPointMake(self.view.center.x, self.view.center.y - 20 - popover.contentSize.height/2) ];
    [self.tableView reloadData];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void) dismissPopover
{
    [self.tableView reloadData];
    [popover dismissPopoverAnimated:YES];
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"options"])
    {
        NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
        NSInteger levelInt = selectedRowIndex.section +1;
        NSString *level = [NSString stringWithFormat:@"%i", levelInt];
        NSMutableDictionary *semesterDic = [self.semestersdicView objectForKey:level];
        NSMutableArray *lecturesArray = [semesterDic objectForKey:@"lectures"];
        NSMutableDictionary *lectureDic = [lecturesArray objectAtIndex: selectedRowIndex.row];
        NSString *title = [lectureDic objectForKey:@"title"];
        title = [title stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        PopoverTable *viewController = segue.destinationViewController;
        title = [title stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        viewController.titleString = title;

    }
}


- (IBAction)Edit:(id)sender {

    
        [super setEditing:YES animated:YES];
        
    
}

- (void)showResetMenu:(UILongPressGestureRecognizer *)gestureRecognizer{
    //if(self.editing)
    //{
    //  [super setEditing:NO animated:NO];
    
    //}
    //else
    //{
    [super setEditing:YES animated:YES];
    //self.button2.backgroundColor = (UIColor *)[ UIImage imageNamed:@"icon 6.png"];
    // }
}


- (IBAction)menubtn:(id)sender {
    if(self.menu.hidden ==YES){
        self.menu.hidden = NO;}
    else{self.menu .hidden =YES;}
    
    
        [self.bt setBackgroundImage:[UIImage imageNamed:@"upArrow.png" ]forState:UIControlStateSelected];
    self.bt = (UIButton *)sender;
    self.bt.selected = !self.bt.selected;
    
   }
- (IBAction)Save:(id)sender {
    
     [super setEditing:NO animated:NO];
   // self.menu.hidden = YES;
    //[self.bt setBackgroundImage:[UIImage imageNamed:@"upArrow1.png" ]forState:UIControlStateSelected];
   // self.bt = (UIButton *)sender;
   // self.bt.selected = !self.bt.selected
}
@end
