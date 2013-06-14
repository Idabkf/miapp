//
//  ViewController2.m
//  testmi
//
//  Created by Sandra Zollner on 11.06.13.
//  Copyright (c) 2013 danqing liu. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()

@end

@implementation ViewController2
@synthesize gradeArray, dataDictionary, GradesAndLectures;

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

    NSString *path= [[NSBundle mainBundle] pathForResource:@"Blist" ofType:@"plist"];
    
    dataDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    gradeArray = [[NSArray alloc] initWithObjects:@"1.0",@"1.3",@"1.7",@"2.0",@"2.3",@"2.7",@"3.0",@"3.3",@"3.7",@"4.0",@"Noch keine Note",@"Unbenotete Fächer",nil];
    GradesAndLectures = [NSMutableDictionary dictionaryWithObjects: [NSArray arrayWithObjects: [NSMutableArray array],[NSMutableArray array],[NSMutableArray array],[NSMutableArray array],[NSMutableArray array],[NSMutableArray array],[NSMutableArray array],[NSMutableArray array],[NSMutableArray array],[NSMutableArray array],[NSMutableArray array],[NSMutableArray array],nil]
                                                     forKeys: gradeArray];

    

    
        //iterate all semesters
        for(id key in dataDictionary){
        
        NSArray *semester = dataDictionary[key];
        
            //iterate all lectures
        for(int i= 0; i < semester.count; i++){
            
            //iterate all grades
            for (int j= 0; j < gradeArray.count; j++){
                
            //NSLog(@"%@",[semester objectAtIndex:i][@"grade"]);
            
            //if grade of lecture is 1.0 for example, the name of the lecture is added to the dictionary with key 1.0
            if(
               [[semester objectAtIndex:i] [@"grade"] isEqualToString:[gradeArray objectAtIndex:j]]
               
               ||
               
               //or if not graded yet it's added to key "Noch Keine Note"
               ([[semester objectAtIndex:i] [@"grade"] isEqualToString:@"0"] &&
                //[(BOOL)[[semester objectAtIndex:i] [@"passed"]] != YES] &&
                [@"Noch keine Note"isEqualToString:[gradeArray objectAtIndex:j]])
               
               ||
               
               //or if it's passed but no grade
               ([[semester objectAtIndex:i] [@"grade"] isEqualToString:@"0"] &&
                [semester objectAtIndex:i] [@"passed"] &&
                [@"Unbenotete Fächer"isEqualToString:[gradeArray objectAtIndex:j]])
               
               )
           
            
            {
                NSMutableArray *lecturesArray = [GradesAndLectures objectForKey:[gradeArray objectAtIndex:j]];
                [lecturesArray addObject:[semester objectAtIndex:i ] [@"lecture"]];
            }
            }
        }
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if ( cell ==nil ){
        cell =[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSArray *lectures = [GradesAndLectures objectForKey:[gradeArray objectAtIndex:indexPath.section]];

    cell.textLabel.text = [lectures objectAtIndex:indexPath.row];

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [gradeArray objectAtIndex:section];

}

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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
        [super setEditing:NO animated:NO];
        
    }
    else
    {
        [super setEditing:YES animated:YES];
        
    }
}

@end
