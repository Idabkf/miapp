//
//  ViewController1.m
//  testmi
//
//  Created by danqing liu on 13-6-10.
//  Copyright (c) 2013年 danqing liu. All rights reserved.
//

#import "ViewController1.h"
#import "DetailPopoverViewController.h"
#import "FPPopoverController.h"

@interface ViewController1 ()

@end

@implementation ViewController1
@synthesize semester,lecture,blist,arry1,arry2,arry3,arry4,arry5,arry6,arry7,arry8,arry9;
NSString *s1;
NSString *s2;
NSString*s3;
NSString*s4;
NSString *s5;
NSString*s6;
NSString *s7;
NSString*s8;
NSString *s9;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.title = @"Semester Plan";
    NSString *vlFile= [[NSBundle mainBundle] pathForResource:@"Blist" ofType:@"plist"];
   
    blist = [[NSMutableDictionary alloc] initWithContentsOfFile:vlFile];
    //arry =[NSMutableArray arrayWithContentsOfFile:vlFile];
    //lecturename = [blist objectForKey:@"lecture"];
    
    arry1 = blist[@"Semester 1"];
    arry2 = blist[@"Semester 2"];
    arry3 = [blist objectForKey:@"Semester 3"];
    arry4 = [blist objectForKey:@"Semester 4"];
    arry5 = [blist objectForKey:@"Semester 5"];
    arry6 = [blist objectForKey:@"Semester 6"];
    arry7 = [blist objectForKey:@"Semester 7"];
    arry8 = [blist objectForKey:@"Semester 8"];
    arry9 = [blist objectForKey:@"Semester 9"];
    
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
    
    
    
switch (section) {
        case 0:
            return arry1.count;
           case 1:
            return arry2.count;
            case 2:
            return [arry3 count];
            case 3:
            return arry4.count;
            case 4:
            return arry5. count;
            case 5:
            return [arry6 count];
            case 6:
            return [arry7 count];
            case 7:
            return [arry8 count];
            case 8:
            return [arry9 count];
            break;
        default:
            break;
    }
    
   
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
    
  switch (indexPath.section) {
      case 0:
         s1 =[arry1 objectAtIndex:[indexPath row]][@"lecture"];
        cell.textLabel.text = s1;
          break;
       case 1:
          s2=[arry2 objectAtIndex:[indexPath row]][@"lecture"];
          cell.textLabel.text = s2;
          break;
      case 2:
          s3=[arry3 objectAtIndex:[indexPath row]][@"lecture"];
          cell.textLabel.text = s3;
          break;
        case 3:
          s4=[arry4 objectAtIndex:[indexPath row]][@"lecture"];
            cell.textLabel.text = s4;
          break;
        case 4:
          s5=[arry5 objectAtIndex:[indexPath row]][@"lecture"];
            cell.textLabel.text = s5;
          break;
        case 5:
          s6=[arry6 objectAtIndex:[indexPath row]][@"lecture"];
           cell.textLabel.text = s6;
          break;
        case 6:
          s7=[arry7 objectAtIndex:[indexPath row]][@"lecture"];
            cell.textLabel.text = s7;
          break;
        case 7:
          s8=[arry8 objectAtIndex:[indexPath row]][@"lecture"];
            cell.textLabel.text = s8;
          break;
        case 8:
          s9=[arry9 objectAtIndex:[indexPath row]][@"lecture"];
            cell.textLabel.text = s9;
            break;
      default:
          break;
    }
        cell.contentView.backgroundColor=[UIColor colorWithRed:0.02 green:0.768 blue:0.45 alpha:1];
    cell.textLabel.backgroundColor = [UIColor colorWithRed:0.2 green:0.768 blue:0.45 alpha:1];
  
    
   
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
    
    NSString *title;
     //title
    switch (indexPath.section) {
        case 0:
            title =[arry1 objectAtIndex:[indexPath row]][@"lecture"];
            break;
        case 1:
            title =[arry2 objectAtIndex:[indexPath row]][@"lecture"];
                        break;
        case 2:
            title=[arry3 objectAtIndex:[indexPath row]][@"lecture"];
                       break;
        case 3:
            title =[arry4 objectAtIndex:[indexPath row]][@"lecture"];
                        break;
        case 4:
            title=[arry5 objectAtIndex:[indexPath row]][@"lecture"];
                       break;
        case 5:
            title=[arry6 objectAtIndex:[indexPath row]][@"lecture"];
           break;
        case 6:
            title =[arry7 objectAtIndex:[indexPath row]][@"lecture"];
            break;
        case 7:
            title =[arry8 objectAtIndex:[indexPath row]][@"lecture"];
            break;
        case 8:
            title=[arry9 objectAtIndex:[indexPath row]][@"lecture"];
            break;
        default:break;
    }
    
     viewController.title = nil;
    viewController.titleString = title;
     //e[viewController.titleLabel setText:title];
     
     FPPopoverController *popover = [[FPPopoverController alloc] initWithViewController:viewController];
     
     popover.tint = FPPopoverDefaultTint;
     popover.border = YES;
     //popover.tint = FPPopoverWhiteTint;
     
     popover.contentSize = CGSizeMake(290, 400);
     
     popover.arrowDirection = FPPopoverNoArrow;
     [popover presentPopoverFromPoint: CGPointMake(self.view.center.x, self.view.center.y - 20 - popover.contentSize.height/2) ];
     
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
@end;
