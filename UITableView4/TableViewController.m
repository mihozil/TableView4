//
//  TableViewController.m
//  UITableView4
//
//  Created by Apple on 1/11/16.
//  Copyright (c) 2016 AMOSC. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()
@property (nonatomic, strong) UISearchController* searchcontroller;

@end

@implementation TableViewController{
    NSDictionary* dics;
    NSArray* keyarray;
    NSMutableArray*filter;
}
-(void) initProject{
    filter = [[NSMutableArray alloc]init];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initProject];
    [self addObject];
    [self addsearchcontroller];
}
- (void) addsearchcontroller{
    self.searchcontroller = [[UISearchController alloc]initWithSearchResultsController:nil];
    [self.searchcontroller.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchcontroller.searchBar;
    self.searchcontroller.searchBar.delegate = self;
    self.searchcontroller.searchResultsUpdater = self;
}
- (void) addObject{
    dics = @{              @"B": @[@"Bear",@"Black Swan",@"Buffalo"],
                           @"C": @[@"Camel",@"Cockatoo"],
                           @"D": @[@"Dog",@"Donkey"],
                           @"E": @[@"Emu"],
                           @"G": @[@"Giraffe",@"Greater Rhea"],
                           @"H" : @[@"Hippopotamus", @"Horse"],
                           @"K" : @[@"Koala"],
                           @"L" : @[@"Lion", @"Llama"],
                           @"M" : @[@"Manatus", @"Meerkat"],
                           @"P" : @[@"Panda", @"Peacock", @"Pig", @"Platypus", @"Polar Bear"],
                           @"R" : @[@"Rhinoceros"],
                           @"S" : @[@"Seagull"],
                           @"T" : @[@"Tasmania Devil"],
                           @"W" : @[@"Whale", @"Whale Shark", @"Wombat"]};
    keyarray = [dics allKeys];
    keyarray = [keyarray sortedArrayUsingSelector:@selector(compare:)];
    
}
- (NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return keyarray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    if (self.searchcontroller.searchBar.text.length>0)
        return 1;
    else
    return keyarray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (self.searchcontroller.searchBar.text.length>0)
        return filter.count;
    else{
        NSArray *animals = [dics valueForKey:keyarray[section]];
        
        return animals.count;
        
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    if (self.searchcontroller.searchBar.text.length>0)
//        if (filter.count==0){
//            NSLog(@"asdf");
//        }
    
    if (self.searchcontroller.searchBar.text.length>0)
    if (filter.count>0)
    {

        NSString* item = filter[indexPath.row];
        NSString *keyword = self.searchcontroller.searchBar.text;
        NSRange range = [item rangeOfString:keyword options:NSCaseInsensitiveSearch];
        
        NSMutableAttributedString*realitem = [[NSMutableAttributedString alloc]initWithString:item];
        
        [realitem addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
        
        
        cell.textLabel.attributedText = realitem;
        
                item = [item lowercaseString];
        NSString* imagename = [NSString stringWithFormat:@"%@.jpg",item];
        cell.imageView.image = [UIImage imageNamed:imagename];
        return cell;
    }
    
    
  
    NSArray *animals = [dics valueForKey:keyarray[indexPath.section]];
    if (indexPath.section ==0)
        if (indexPath.row==0){
            NSLog(@"%@",animals[0]);
        }
    
    // Configure the cell...
    cell.textLabel.text =animals[indexPath.row];
    NSString* imagename = [NSString stringWithFormat:@"%@.jpg",[animals[indexPath.row] lowercaseString]];
    
    
    cell.imageView.image = [UIImage imageNamed:imagename];

    
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (self.searchcontroller.searchBar.text.length>0)
        return self.searchcontroller.searchBar.text;
    
    NSString *title = keyarray[section];
    return title;
}
- (void) updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString* search = searchController.searchBar.text;
//    NSLog(@"%@",search);
    [filter removeAllObjects];
    
    for (int i =0;i<keyarray.count;i++){
        for (NSString* item in dics[keyarray[i]]){
            if ([item rangeOfString:search].location != NSNotFound){
                [filter addObject:item];
            }
        }
    }
    [self.tableView reloadData];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
