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
    self.semestersdicView = (NSDictionary *)[NSPropertyListSerialization
                                             propertyListFromData:plistXML
                                             mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                             format:&format
                                             errorDescription:&errorDesc];
    
    NSURL *url = [NSURL URLWithString:@"http://www.medien.ifi.lmu.de/studierende/semesterplanung/bachelor/mediengestaltung/index.xhtml.de"];
    
    [self fetchEntries];

   
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

-(void)createPList{
    
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    
    
    
    [self.semestersdicParser writeToFile:self.plistLocation atomically: YES];
    
    NSLog(@"WRITE TO FILE: %@", self.plistLocation);
    NSLog(@"WRITE: %@", documentsDirectory);
    
    NSPropertyListFormat format;
    NSString *errorDesc = nil;
    
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:self.plistLocation];
    NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
                                          propertyListFromData:plistXML
                                          mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                          format:&format
                                          errorDescription:&errorDesc];
    
    NSLog(@"  plist: %@",   temp);
    
    
    /*//NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
     
     // NSString *plistPath = [rootPath stringByAppendingPathComponent:@"lecture.plist"];
     
     NSString *folderPath = [[NSBundle mainBundle] pathForResource:@"lecture2" ofType:@"plist"];
     //NSString *documentsDirectory = [folderPath objectAtIndex:0];
     NSString *plistPath = [folderPath stringByAppendingPathComponent:@"lecture2.plist"];
     
     //NSString *test= @"test";
     BOOL succesful = [self.semestersdic writeToFile:plistPath atomically:YES];
     //[test writeToFile:plistPath atomically:YES];
     
     
     NSLog(@"WRITE TO FILE: %c", succesful);
     */
    /*
     NSData *myData = [NSKeyedArchiver archivedDataWithRootObject:self.semestersdic];
     id plist = [NSPropertyListSerialization propertyListWithData:myData options:NSPropertyListMutableContainersAndLeaves format:nil error:&error];
     NSLog(@"PLIST: %@", plist);
     */
    
    /*
     NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:self.semestersdic
     format:NSPropertyListXMLFormat_v1_0
     errorDescription:&error];
     
     if(plistData) {
     
     }
     else {
     NSLog(@"%@", error);
     }
     */
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
    
    
    NSInteger levelInt = section +1;
    NSString *level = [NSString stringWithFormat:@"%i", levelInt];
    NSMutableDictionary *semesterDic = [self.semestersdicView objectForKey:level];
    NSMutableArray *lecturesArray = [semesterDic objectForKey:@"lectures"];
    
    return lecturesArray.count;
    
    /*
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
     */
    
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
    
    /*
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
     */
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
    
    NSInteger levelInt = indexPath.section +1;
    NSString *level = [NSString stringWithFormat:@"%i", levelInt];
    NSMutableDictionary *semesterDic = [self.semestersdicView objectForKey:level];
    NSMutableArray *lecturesArray = [semesterDic objectForKey:@"lectures"];
    NSMutableDictionary *lectureDic = [lecturesArray objectAtIndex:[indexPath row]];
    NSString *title = [lectureDic objectForKey:@"title"];

    /*NSString *title;
     title
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
    */
    
    title = [title stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    if([title isEqualToString: @"Seminar zu ausgewählten Themen der Informatik"]){
        
        PopoverTable *viewController = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"table"];
        viewController.title = nil;
        viewController.titleString = title;
        //e[viewController.titleLabel setText:title];
        
        FPPopoverController *popover = [[FPPopoverController alloc] initWithViewController:viewController];
        
        popover.tint = FPPopoverDefaultTint;
        popover.border = YES;
        //popover.tint = FPPopoverWhiteTint;
        
        popover.contentSize = CGSizeMake(290, 380);
        
        popover.arrowDirection = FPPopoverNoArrow;
        [popover presentPopoverFromPoint: CGPointMake(self.view.center.x, self.view.center.y - 20 - popover.contentSize.height/2) ];
        return;
        
    }
    
    viewController.title = nil;
    viewController.titleString = title;
     //e[viewController.titleLabel setText:title];
     
     FPPopoverController *popover = [[FPPopoverController alloc] initWithViewController:viewController];
     
     popover.tint = FPPopoverDefaultTint;
     popover.border = YES;
     //popover.tint = FPPopoverWhiteTint;
     
     popover.contentSize = CGSizeMake(290, 380);
     
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
- (void)fetchEntries
{
    // Create a new data container for the stuff that comes back from the service
    xmlData = [[NSMutableData alloc] init];
    
    // Construct a URL that will ask the service for what you want -
    // note we can concatenate literal strings together on multiple
    // lines in this way - this results in a single NSString instance
    NSURL *url = [NSURL URLWithString:@"http://www.medien.ifi.lmu.de/studierende/semesterplanung/bachelor/mediengestaltung/index.xhtml.de"];
    
    
    
    // For Apple's Hot News feed, replace the line above with
    // NSURL *url = [NSURL URLWithString:@"http://www.apple.com/pr/feeds/pr.rss"];
    
    // Put that URL into an NSURLRequest
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    // Create a connection that will exchange this request for data from the URL
    connection = [[NSURLConnection alloc] initWithRequest:req
                                                 delegate:self
                                         startImmediately:YES];
}

- (void)connection:(NSURLConnection *)conn didReceiveData:(NSData *)data
{
    // Add the incoming chunk of data to the container we are keeping
    // The data always comes in the correct order
    [xmlData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)conn
{
    // Create the parser object with the data received from the web service
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData];
    
    // Give it a delegate
    [parser setDelegate:self];
    
    // Tell it to start parsing - the document will be parsed and
    // the delegate of NSXMLParser will get all of its delegate messages
    // sent to it before this line finishes execution - it is blocking
    [parser parse];
    
    [self createPList];
    
    // Get rid of the XML data as we no longer need it
    xmlData = nil;
    
    // Get rid of the connection, no longer need it
    connection = nil;
    
    // Reload the table.. for now, the table will be empty.
    //[[self tableView] reloadData];
    
    //NSLog(@"%@\n %@\n %@\n", channel, [channel title], [channel infoString]);
}

- (void)connection:(NSURLConnection *)conn
  didFailWithError:(NSError *)error
{
    // Release the connection object, we're done with it
    connection = nil;
    
    // Release the xmlData object, we're done with it
    xmlData = nil;
    
    // Grab the description of the error object passed to us
    NSString *errorString = [NSString stringWithFormat:@"Fetch failed: %@",
                             [error localizedDescription]];
    
    // Create and show an alert view with this error displayed
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error"
                                                 message:errorString
                                                delegate:nil
                                       cancelButtonTitle:@"OK"
                                       otherButtonTitles:nil];
    [av show];
}


- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    //[self.tmp setString:@""];
    self.tmp = [[NSMutableString alloc] init];
    
    if ([elementName isEqual:@"h2"]) {
        
        
        for (int i = 1; i<7; i++) {
            
            NSString *idAttr = @"id";
            
            //wir prüfen auf ids, da hier unsere semester beginnen
            NSString *idIs = [attributeDict objectForKey:idAttr];
            
            if ([idIs isEqual:[NSString stringWithFormat:@"id-%i.-semester", i ]]) {
                
                /*
                 Semester *s_local = [[Semester alloc] init];
                 s_local.level = i;
                 s_local.lectures = [[NSMutableDictionary alloc]init];
                 */
                
                NSMutableDictionary *semesterNew = [[NSMutableDictionary alloc] init];
                
                NSMutableArray *lectures = [[NSMutableArray alloc] init];
                [semesterNew setObject:lectures forKey:@"lectures"];
                
                [self.semestersdicParser setObject: semesterNew forKey:[NSString stringWithFormat:@"%i", i]];
                self.level = i;
                
                /*
                 //in unser dictionary werden mit Semester gefüllt, die wiederum arrays sind
                 [self.semestersdic setObject: s_local forKey:[NSString stringWithFormat:@"%i", s_local.level]];
                 self.level = i;
                 */
            }
        }
    }
    
    if ([elementName isEqual:@"tr"]) {
        if (attributeDict.count <1) {
            self.tr = true;
            self.td = 1;
        }
    }
    
    if ([elementName isEqual:@"td"]) {
        self.inTd = true;
    }
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    [self.tmp appendString:string];
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    
    if (self.inTd) {
        if (self.td == 1) {
            
            self.currentLecture1 = [[NSMutableDictionary alloc] init];
            [self.currentLecture1 setObject:self.tmp forKey:@"title"];
            self.td++;
            
            /*
             self.currentLecture = [[Lecture alloc] init];
             self.currentLecture.title = self.tmp;
             self.td++;
             */
        }
        else if (self.td == 2){
            [self.currentLecture1 setObject:self.tmp forKey:@"kind"];
            //self.currentLecture.kind = self.tmp;
            self.td++;
        }
        else if (self.td == 3){
            //self.currentLecture.sws = self.tmp;
            [self.currentLecture1 setObject:self.tmp forKey:@"sws"];
            self.td++;
        }
        else if (self.td == 4) {
            //self.currentLecture.ects = self.tmp;
            [self.currentLecture1 setObject:self.tmp forKey:@"ects"];
            
            /*
             //semester objekt anhand von dic erstellt aber hier sitzt doch nur ein array
             Semester *semester = [self.semestersdic objectForKey:[NSString stringWithFormat:@"%i",self.level]];
             [semester.lectures setObject:self.currentLecture forKey:self.currentLecture.title];
             */
            self.td = 0;
            self.inTd = false;
            
            NSMutableDictionary *currentSemester = [self.semestersdicParser objectForKey:[NSString stringWithFormat:@"%i",self.level]];
            NSMutableArray *currentLectures = [currentSemester objectForKey:@"lectures"];
            [currentLectures addObject:self.currentLecture1];
            
            
            
            
            NSLog(@"Im Semester: %i", self.level );
            NSLog(@"TITEL: %@", [self.currentLecture1 objectForKey:@"title"]);
            
            NSLog(@"SWS: %@",  [self.currentLecture1 objectForKey:@"sws"]);
            NSLog(@"KIND: %@",  [self.currentLecture1 objectForKey:@"kind"]);
            
        }
    }
}


@end;
