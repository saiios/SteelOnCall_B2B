//
//  LeftPanelViewController.m
//  TestTableCell
//
//  Created by administrator on 29/11/16.
//  Copyright © 2016 com.SteelonCall. All rights reserved.
//

#import "LeftPanelViewController.h"
#import "TreeViewNode.h"
#import "MainTableViewCell.h"
#import "ChieldTableViewCell.h"
#import "AppDelegate.h"
#import "CateGoryTableViewCell.h"
#import "Products_List.h"
#import "DEMONavigationController.h"
@interface LeftPanelViewController ()
{
    NSUInteger indentation;
    NSArray *nodes;
    AppDelegate *appDle;
}

@property (strong, nonatomic) IBOutlet UITableView *leftMenuTable;
@property (nonatomic, retain) NSMutableArray *displayArray;

- (void)expandCollapseNode:(NSNotification *)notification;

- (void)fillDisplayArray;
- (void)fillNodeWithChildrenArray:(NSArray *)childrenArray;

- (void)fillNodesArray;
- (NSArray *)fillChildrenForNode;

- (IBAction)expandAll:(id)sender;
- (IBAction)collapseAll:(id)sender;

@end

@implementation LeftPanelViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
    
}
-(void )viewWillAppear:(BOOL)animated{
    
    [self preferredStatusBarStyle];
    [self setNeedsStatusBarAppearanceUpdate];
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [del setShouldRotate:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(expandCollapseNode:) name:@"ProjectTreeNodeButtonClicked" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(CloseCells) name:@"close" object:nil];
    
self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"img_1.jpg"]];

    appDle = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDle.itemsArray.count>0) {
        
        [self fillNodesArray];
        [self fillDisplayArray];
    }
   
    [self.leftMenuTable reloadData];
    self.leftMenuTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}
- (void)viewDidUnload
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [super viewDidUnload];
}


-(void)CloseCells{
    for (TreeViewNode *treeNode in nodes) {
        treeNode.isExpanded = NO;
    }
    [self fillDisplayArray];
    [self.leftMenuTable reloadData];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)ClosePannel:(id)sender {
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController hideMenuViewController];

}

#pragma mark - Messages to fill the tree nodes and the display array

//This function is used to expand and collapse the node as a response to the ProjectTreeNodeButtonClicked notification
- (void)expandCollapseNode:(NSNotification *)notification
{
    

    
    [self fillDisplayArray];
    [self.leftMenuTable reloadData];
}

//These two functions are used to fill the nodes array with the tree nodes
- (void)fillNodesArray
{
    TreeViewNode *firstLevelNode1 = [[TreeViewNode alloc]init];
    firstLevelNode1.nodeLevel = 0;
    firstLevelNode1.item_img = @"Construction";
    firstLevelNode1.nodeObject = [NSString stringWithFormat:@"Construction"];
    firstLevelNode1.isExpanded = NO;
    firstLevelNode1.nodeChildren = [[self fillChildrenForNode] mutableCopy];
    firstLevelNode1.isHidden = YES;
    
    TreeViewNode *firstLevelNode2 = [[TreeViewNode alloc]init];
    firstLevelNode2.nodeLevel = 0;
      firstLevelNode2.item_img = @"Fabrication";
    firstLevelNode2.nodeObject = [NSString stringWithFormat:@"Fabrication"];
    firstLevelNode2.isExpanded = NO;
    firstLevelNode2.nodeChildren = [[self subNodes] mutableCopy];
     firstLevelNode1.isHidden = NO;
    
    TreeViewNode *firstLevelNode3 = [[TreeViewNode alloc]init];
    firstLevelNode3.nodeLevel = 0;
    firstLevelNode3.item_img = @"special";
    firstLevelNode3.nodeObject = [NSString stringWithFormat:@"Special"];
    firstLevelNode3.isExpanded = NO;
    firstLevelNode1.isHidden = NO;
    //firstLevelNode3.nodeChildren = [[self fillChildrenForNode] mutableCopy];
    
  
    
    nodes = [NSMutableArray arrayWithObjects:firstLevelNode1, firstLevelNode2, firstLevelNode3, nil];
}

- (NSArray *)fillChildrenForNode
{
    NSMutableArray *childrenArray = [[NSMutableArray alloc]init];
    NSArray *ar =[[appDle.itemsArray objectAtIndex:1] valueForKey:@"Objects"];
    
    for (NSDictionary *dic in ar) {
        TreeViewNode *secondLevelNode1 = [[TreeViewNode alloc]init];
        secondLevelNode1.nodeLevel = 1;
        secondLevelNode1.isExpanded = NO;
        secondLevelNode1.nodeObject = [dic valueForKey:@"name"];
        secondLevelNode1.item_id =[dic valueForKey:@"id"];
        secondLevelNode1.isHidden = YES;
        [childrenArray addObject:secondLevelNode1];
        
    }
   
    
    return childrenArray;
}
- (NSArray *)subNodes
{
    TreeViewNode *secondLevelNode1 = [[TreeViewNode alloc]init];
    secondLevelNode1.nodeLevel = 1;
    secondLevelNode1.isExpanded = NO;
    secondLevelNode1.nodeObject = @"Light Structurals";
    secondLevelNode1.nodeChildren = [[self lightchieldNodes] mutableCopy];
    secondLevelNode1.isHidden = NO;
    
    TreeViewNode *secondLevelNode2 = [[TreeViewNode alloc]init];
    secondLevelNode2.nodeLevel = 1;
    secondLevelNode2.nodeObject = @"Heavy Structurals";
    secondLevelNode2.nodeChildren = [[self HeavychieldNodes] mutableCopy];
    secondLevelNode1.isHidden = NO;
    NSArray *childrenArray = [NSArray arrayWithObjects:secondLevelNode1, secondLevelNode2, nil];
    
    return childrenArray;
}
- (NSArray *)HeavychieldNodes
{
    
    NSMutableArray *childrenArray = [[NSMutableArray alloc]init];
    
    for (NSDictionary *dic in [[appDle.itemsArray objectAtIndex:2] valueForKey:@"sections"]) {
        if (![[dic valueForKey:@"name"] isEqualToString:@"Light Structurals"]) {
            
            for (NSDictionary *dic1 in [dic valueForKey:@"secObjects"]) {
                TreeViewNode *secondLevelNode1 = [[TreeViewNode alloc]init];
                secondLevelNode1.nodeLevel = 2;
                secondLevelNode1.isExpanded = NO;
                secondLevelNode1.nodeObject = [dic1 valueForKey:@"name"];
                secondLevelNode1.item_id =[dic1 valueForKey:@"id"];
                [childrenArray addObject:secondLevelNode1];
                
            }
        }
      
        
    }

    
    return childrenArray;
}
- (NSArray *)lightchieldNodes
{
    
    NSMutableArray *childrenArray = [[NSMutableArray alloc]init];
    
    for (NSDictionary *dic in [[appDle.itemsArray objectAtIndex:2] valueForKey:@"sections"]) {
        if ([[dic valueForKey:@"name"] isEqualToString:@"Light Structurals"]) {
            
            for (NSDictionary *dic1 in [dic valueForKey:@"secObjects"]) {
                TreeViewNode *secondLevelNode1 = [[TreeViewNode alloc]init];
                secondLevelNode1.nodeLevel = 2;
                secondLevelNode1.isExpanded = NO;
                secondLevelNode1.nodeObject = [dic1 valueForKey:@"name"];
                secondLevelNode1.item_id =[dic1 valueForKey:@"id"];
                [childrenArray addObject:secondLevelNode1];
                
            }
        }
        
        
    }
    
    
    return childrenArray;
}
//This function is used to fill the array that is actually displayed on the table view
- (void)fillDisplayArray
{
    self.displayArray = [[NSMutableArray alloc]init];
    for (TreeViewNode *node in nodes) {
        [self.displayArray addObject:node];
        if (node.isExpanded) {
            [self fillNodeWithChildrenArray:node.nodeChildren];
        }
    }
}

//This function is used to add the children of the expanded node to the display array
- (void)fillNodeWithChildrenArray:(NSArray *)childrenArray
{
    for (TreeViewNode *node in childrenArray) {
        [self.displayArray addObject:node];
        if (node.isExpanded) {
            [self fillNodeWithChildrenArray:node.nodeChildren];
        }
    }
}

//These functions are used to expand and collapse all the nodes just connect them to two buttons and they will work
- (IBAction)expandAll:(id)sender
{
    [self fillNodesArray];
    [self fillDisplayArray];
    [self.leftMenuTable reloadData];
}

- (IBAction)collapseAll:(id)sender
{
    for (TreeViewNode *treeNode in nodes) {
        treeNode.isExpanded = NO;
    }
    [self fillDisplayArray];
    [self.leftMenuTable reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.displayArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //It's cruical here that this identifier is treeNodeCell and that the cell identifier in the story board is anything else but not treeNodeCell
    
    TreeViewNode *node = [self.displayArray objectAtIndex:indexPath.row];
    
    if (node.nodeLevel ==0) {
        static NSString *CellIdentifier = @"mainCell";
        UINib *nib = [UINib nibWithNibName:@"MainTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        
        MainTableViewCell *cell = (MainTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        
        cell.treeNode = node;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.catNAme_lbl.text = node.nodeObject;
        cell.imgVIew.image = [UIImage imageNamed:node.item_img];
        if (node.isExpanded) {
//            [cell setTheButtonBackgroundImage:[UIImage imageNamed:@"Open"]];
            
        }
        else {
            [cell.mainCell_Btn setSelected:NO];
//            [cell setTheButtonBackgroundImage:[UIImage imageNamed:@"Close"]];
        }
        [cell setNeedsDisplay];
        
        
        // Configure the cell...
        
        return cell;
    }else if (node.nodeLevel ==1){
        static NSString *CellIdentifier = @"treeNodeCell";
        UINib *nib = [UINib nibWithNibName:@"CateGoryTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        
        CateGoryTableViewCell *cell = (CateGoryTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        
        cell.treeNode = node;
        
        cell.cellLabel.text = node.nodeObject;
        
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (node.isHidden == YES) {
            cell.cellButton.hidden =YES;
            cell.expandBtn.hidden =YES;
            cell.expandBtn.enabled =NO;
            
        }else{
            cell.cellButton.hidden =NO;
            cell.expandBtn.hidden =NO;
            cell.expandBtn.enabled =YES;


        }
        if (node.isExpanded) {
            [cell setTheButtonBackgroundImage:[UIImage imageNamed:@"down-arrow"]];
            
        }
        else {
             [cell.cellButton setSelected:NO];
            [cell setTheButtonBackgroundImage:[UIImage imageNamed:@"right-arrow"]];
        }
        [cell setNeedsDisplay];
        
        
        // Configure the cell...
        
        return cell;
    }else{
        static NSString *CellIdentifier = @"cheildCell";
        UINib *nib = [UINib nibWithNibName:@"ChieldTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        
        ChieldTableViewCell *cell = (ChieldTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.treeNode = node;
        
        cell.chield_lbl.text = node.nodeObject;
//        
//        if (node.isExpanded) {
//            [cell setTheButtonBackgroundImage:[UIImage imageNamed:@"Open"]];
//        }
//        else {
//            [cell setTheButtonBackgroundImage:[UIImage imageNamed:@"Close"]];
//        }
        [cell setNeedsDisplay];
        
        
        // Configure the cell...
        
        return cell;
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.row);
    
 
     TreeViewNode *node = [self.displayArray objectAtIndex:indexPath.row];
 
        // use node.itemId for ID
    [self Products_list:node.item_id];
        
}

-(void)Products_list:(NSString *)productId
{
    
   
    NSDictionary* userInfo = @{@"id": productId};
    
    
    
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:@"leftMenuClicked" object:self userInfo:userInfo];
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController hideMenuViewController];

 }

@end
