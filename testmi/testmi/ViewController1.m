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

- (void)viewWillAppear:(BOOL)animated
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(showResetMenu:)];
    [self.view addGestureRecognizer:longPressGesture];
    
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
    
    //UIBarButtonItem *left=[[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleBordered target:self action:@selector(edit)];
   // self.navigationItem.leftBarButtonItem=left;
 
    
    
    
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
        
       
    //arry =[[NSMutableArray alloc] initWithContentsOfFile:blist];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//- (void)tableViewEdit:(id)sender{
  //  [self.tableView setEditing:YES animated:YES];
}





- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView endUpdates];
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView setEditing:YES animated:YES];
    return UITableViewCellEditingStyleDelete;
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
    
    NSInteger levelInt = indexPath.section +1;
    NSString *level = [NSString stringWithFormat:@"%i", levelInt];
    NSMutableDictionary *semesterDic = [self.semestersdicView objectForKey:level];
    NSMutableArray *lecturesArray = [semesterDic objectForKey:@"lectures"];
    NSMutableDictionary *lectureDic = [lecturesArray objectAtIndex:[indexPath row]];
    NSString *title = [lectureDic objectForKey:@"title"];
    cell.textLabel.text = title;
    

    if([[lectureDic objectForKey:@"passed"] isEqualToString:@"YES"]){
        cell.contentView.backgroundColor=[UIColor colorWithRed:0.02 green:0.768 blue:0.45 alpha:1];
        cell.textLabel.backgroundColor = [UIColor colorWithRed:0.2 green:0.768 blue:0.45 alpha:1];
    } else {
        cell.contentView.backgroundColor=[UIColor whiteColor];
        cell.textLabel.backgroundColor = [UIColor whiteColor];
    }
    
    
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
   // return @"semester";
    switch (section) {
        case 0:
            return @"Semster 1";
            break;
        case 1:
            return @"Semster 2";
            break;
        case 2:
            return @"Semster 3";
            break;
        case 3:
            return @"Semster 4";
            break;
        case 4:
            return @"Semster 5";
            break;
        case 5:
            return @"Semster 6";
            break;
        case 6:
            return @"Semster 7";
            break;
        case 7:
            return @"Semster 8";
            break;
        case 8:
            return @"Semster 9";
            break;
                default:
            break;
    }
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
     popover.border = YES;
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
    
    if(self.editing)
    {
        [super setEditing:NO animated:NO];
       
    }
    else
    {
        [super setEditing:YES animated:YES];
        
    }
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


@end;
