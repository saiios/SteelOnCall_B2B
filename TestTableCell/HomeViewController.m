 //
//  HomeViewController.m
//  TestTableCell
//
//  Created by administrator on 29/11/16.
//  Copyright © 2016 com.SteelonCall. All rights reserved.
//

#import "HomeViewController.h"
#import "CustomTableViewCell.h"
#import "AppDelegate.h"
#import "STParsing.h"
#import "DashBoard.h"
#import "MainTableViewCell.h"
#import "ChieldTableViewCell.h"
#import "searchPopupVIew.h"
#import "JMOTableViewCell.h"
#import "AccountManageViewController.h"
#import "YourOrdersViewController.h"
#import "Payment_ProductDetailsViewController.h"
#import "OrderReviewViewController.h"
#import "LoginViewController.h"
@interface HomeViewController ()
{
    NSMutableArray *testArray;
}
@property (strong, nonatomic) IBOutlet UITableView *testtableView;

@end

@implementation HomeViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)viewWillAppear:(BOOL)animated
{
  

    
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [del setShouldRotate:NO];
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:44.0/255.0 green:52.0/255.0 blue:75.0/255.0 alpha:1];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    user_data=[NSUserDefaults standardUserDefaults];
    NSString *C_Count=[user_data valueForKey:@"cart_count"];
    _Cart_count.text=C_Count;

}

-(void)viewDidAppear:(BOOL)animated
{
    
    
    user_data=[NSUserDefaults standardUserDefaults];
    user_id=[user_data valueForKey:@"user_id"];
    
       if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        searchView = [[searchPopupVIew alloc]initWithFrame:CGRectMake(10,_searchTextField.frame.origin.y+40 ,[UIScreen mainScreen].bounds.size.width-20,400)];
        
    }
    else
    {
        if ([UIScreen mainScreen].bounds.size.width == 320) {
            searchView = [[searchPopupVIew alloc]initWithFrame:CGRectMake(10,_searchTextField.frame.origin.y+40 ,[UIScreen mainScreen].bounds.size.width-20,200)];
        }else{
            searchView = [[searchPopupVIew alloc]initWithFrame:CGRectMake(10,_searchTextField.frame.origin.y+40 ,[UIScreen mainScreen].bounds.size.width-20,260)];
        }
    }
    
    searchView.delegate =self;
    searchView.hidden =YES;

    [self.view addSubview:searchView];
//    NSArray *currentControllers = self.navigationController.viewControllers;
//    if (currentControllers.count>1) {
//        HomeViewController *con = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
//       
//        NSMutableArray *newControllers = [NSMutableArray
//                                          arrayWithArray:@[con]];
//        
//      
//        self.navigationController.viewControllers = newControllers;
//
//    }
//    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //remove
    
//    OrderReviewViewController * newView = [[OrderReviewViewController alloc] initWithNibName:@"OrderReviewViewController" bundle:nil];
//   
//    [self.navigationController pushViewController:newView animated:YES];
    
    
//     Do any additional setup after loading the view from its nib.
//     [UIApplication sharedApplication].statusBarStyle =UIFontWeightUltraLight;
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(recieveMenuAction:) name:@"leftMenuClicked" object:nil];
   
    
   
    user_data=[NSUserDefaults standardUserDefaults];
    NSString *C_Count=[user_data valueForKey:@"cart_count"];
    if ([C_Count isEqual:[NSNull null]]||[C_Count isEqualToString:@""]||C_Count ==nil||[C_Count isEqualToString:@"<nil>"])
    {
        _Cart_count.text=@"0";
        
        [user_data setValue:@"0" forKey:@"cart_count"];
    }
    else
        _Cart_count.text=C_Count;
    
    _cart_view.layer.cornerRadius = 10;
    
    //tap gesture
    UITapGestureRecognizer *cart_tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(Cart_click:)];
    [_cart_view addGestureRecognizer:cart_tap];

    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped)];
    [self.view addGestureRecognizer:tap];
    [tap setNumberOfTapsRequired:1];
    [tap setCancelsTouchesInView:NO];
   
    [self preferredStatusBarStyle];
    [self setNeedsStatusBarAppearanceUpdate];
    self.navigationController.navigationBar.hidden =YES;
    
    [_searchTextField addTarget:self action:@selector(searchItems:) forControlEvents:UIControlEventEditingChanged];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    _searchTextField.leftView = paddingView;
    _searchTextField.leftViewMode = UITextFieldViewModeAlways;
    _searchTextField.layer.cornerRadius = 3;
    _searchTextField.layer.masksToBounds =YES;
    _searchBtn.layer.cornerRadius =3;
    _searchBtn.layer.masksToBounds =YES;
    testArray = [[NSMutableArray alloc]init];
    searchItemsArray = [[NSMutableArray alloc]init];
    searchResultArray = [[NSMutableArray alloc]init];
    mainSearchArry = [[NSMutableArray alloc]init];
    ad_Array = [[NSMutableDictionary alloc]init];
    
    UINib *cellNib = [UINib nibWithNibName:@"CustomTableViewCell" bundle:nil];
    [_testtableView registerNib:cellNib forCellReuseIdentifier:@"cell"];
    _testtableView.allowsSelection = NO;
         //    _testtableView.estimatedRowHeight = 50;
    //    _testtableView.rowHeight = UITableViewAutomaticDimension;
   [self callInitialWebservice];

        
    [self performSelector:@selector(getAddImagesFromServer) withObject:nil afterDelay:0.2];
    [self performSelector:@selector(loadAdds) withObject:nil afterDelay:0.0];


    
}


-(void)loadAdds{
    
    [[STParsing sharedWebServiceHelper]requesting_GET_ServiceWithString:@"getsponsors" requestNumber:WS_SPONSORS showProgress:NO withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             if (data) {
                 
                 for (NSDictionary *dic in data) {
                     
                     NSArray *Ar = [[dic valueForKey:@"brand_image"] componentsSeparatedByString:@"/" ];
                     if ([Ar containsObject:@"tata.png"]) {
                         [ad_Array setValue:[dic valueForKey:@"brand_image"] forKey:@"img1"];
                         [ad_Array setValue:[dic valueForKey:@"description"] forKey:@"desc1"];
                         
                     }
                     if ([Ar containsObject:@"vizag_2.png"]) {
                         
                         [ad_Array setValue:[dic valueForKey:@"brand_image"] forKey:@"img2"];
                         [ad_Array setValue:[dic valueForKey:@"description"] forKey:@"desc2"];
                         
                     }
                     
                 }
                 
                 [_testtableView reloadData];
                 
                 //archive
                
             }
             
         }
         
         
     }];

    
}
-(void)getAddImagesFromServer{
    
    [[STParsing sharedWebServiceHelper]requesting_GET_ServiceWithString:@"getbanners" requestNumber:WS_Banners showProgress:NO withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             if (data) {
                 
                 
                 //archive
                 NSData *dataStore = [NSKeyedArchiver archivedDataWithRootObject:data];
                 [[NSUserDefaults standardUserDefaults] setObject:dataStore forKey:@"Banners"];
             }
             
         }
         
         
     }];
    
    
}

-(void)callInitialWebservice
{
    [[STParsing sharedWebServiceHelper]requesting_GET_ServiceWithString:@"" requestNumber:WS_MAIN showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             _reloadBtn.hidden =YES;
             _errorLbl.hidden =YES;
             [testArray removeAllObjects];
             [testArray addObjectsFromArray:[DashBoard parseResponce:[data valueForKey:@"sub_categories"]]];
             [_testtableView reloadData];
             
             AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
             del.itemsArray = testArray;
             
         }
         else
         {
             _errorLbl.hidden =NO;
             _reloadBtn.hidden =NO;
//             UIAlertController * alert=   [UIAlertController
//                                           alertControllerWithTitle:@"Alert"
//                                           message:[NSString stringWithFormat:@"%@",[data valueForKey:@"error_message"]]
//                                           preferredStyle:UIAlertControllerStyleAlert];
//             
//             UIAlertAction* ok = [UIAlertAction
//                                  actionWithTitle:@"OK"
//                                  style:UIAlertActionStyleDefault
//                                  handler:^(UIAlertAction * action)
//                                  {
//                                      [alert dismissViewControllerAnimated:YES completion:nil];
//                                      
//                                  }];
//             [alert addAction:ok];
//             [self presentViewController:alert animated:YES completion:nil];
            // ALERT_DIALOG(@"Alert", @"Something went wrong please try again");
         }
         
         
         
     }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)menuTapped:(id)sender {
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
}


- (void)setUpCell:(CustomTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    //cell.label.text = ];
    [cell.flowCollectionView reloadData];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ([scrollView isKindOfClass:[_testtableView class]]) {
        
        
        CGFloat sectionHeaderHeight = 44;
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
    
}
#pragma mark MAin Tableview delegate & datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return testArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    int itemHeight = 0 ;
    int itemCount = 3;
    int scrollHeight = 255;
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){
        itemCount = ((int)[UIScreen mainScreen].bounds.size.width/170);
        
        itemHeight = 190;
        scrollHeight = 400;
    }else{
        
        
        if ([UIScreen mainScreen].bounds.size.width==320) {
            
            itemHeight = 100;
            
        }else if ([UIScreen mainScreen].bounds.size.width==414) {

            
            itemHeight = 140;
            
        }else{
            itemHeight = 130;
        }
    }
    
    if(indexPath.section == 0){
        
        return scrollHeight;
        
    }else  if(indexPath.section == 1){
        
        float kk =ceil([[[testArray objectAtIndex:indexPath.section] valueForKey:@"Objects"] count]) ;
        float p =ceil((float) kk/itemCount);
        return ceil (p*itemHeight)+10;
        
    }else{
        
        float k = ceil((float)[[[testArray objectAtIndex:indexPath.section] valueForKey:@"totalCount"] floatValue] ) *itemHeight;
        
        return k+100;//height of table
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 0;
    }
    else
    {
        return 44;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //base View
    UIView *vi=[[UIView alloc]initWithFrame:CGRectMake(0, 0,tableView.frame.size.width, 44)];
    UIImageView *h_image = [[UIImageView alloc]init];
    h_image.frame =CGRectMake(0,7, 200, 30);
    h_image.image = [UIImage imageNamed:@"category_bg"];
    
    vi.backgroundColor = [UIColor clearColor];
    
    UIView *vi2=[[UIView alloc]initWithFrame:CGRectMake(10, 0,tableView.frame.size.width-20, 44)];
    vi2.backgroundColor = [UIColor whiteColor];
    [vi2 addSubview:h_image];
    UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(5,7,200, 30)];
    // lbl.backgroundColor = [UIColor blueColor];
    
    lbl.text = [[testArray objectAtIndex:section]valueForKey:@"CategoryName"];
    lbl.textColor = [UIColor whiteColor];
    [vi2 addSubview:lbl];
    [vi addSubview:vi2];
    
    return vi;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0)
    {
                HeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"headerCell"];
        if (cell==nil)
        {
            [tableView registerNib:[UINib nibWithNibName:@"HeaderTableViewCell" bundle:nil] forCellReuseIdentifier:@"headerCell"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"headerCell"];
        }
        
        if(ad_Array)
        {
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        
      
        
        [manager downloadImageWithURL:[NSURL URLWithString:[ad_Array valueForKey:@"img1"]] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize)
         
         {
             
             
         } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
             
             if(image){
                 
                 cell.addImg1_imageVIew.image = image;
                 NSLog(@"image=====%@",image);
             }
         }];
            
            [manager downloadImageWithURL:[NSURL URLWithString:[ad_Array valueForKey:@"img2"]] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize)
             
             {
                 
                 
             } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                 
                 if(image){
                     
                     cell.addImage2_imageView.image = image;
                     NSLog(@"image=====%@",image);
                 }
             }];
            
            cell.add1Desc_lbl.text =[ad_Array valueForKey:@"desc1"];
            cell.add2Desc_lbl.text =[ad_Array valueForKey:@"desc2"];

            

    }
        //cell1.delegate = self;
        // cell1.userArray = [testArray objectAtIndex:indexPath.row];
                
        // [cell1 testMeyhod:indexPath.row];
        return cell;
        
    }else{
        CustomTableViewCell *cell1 = (CustomTableViewCell *)  [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        //cell1.tag =indexPath.row;
        if (cell1 == nil)
        {
            cell1 =   [cell1 initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell1.delegate = self;
        cell1.flowCollectionView.tag =indexPath.row;
        cell1.tag =indexPath.section;
        NSDictionary *dic = [testArray objectAtIndex:indexPath.section];
        if (indexPath.section == 1) {
            cell1.userArray  = [dic valueForKey:@"Objects"];
            cell1.secCount = @"1";
        }else{
            cell1.userArray  = [dic valueForKey:@"sections"];
            cell1.secCount = @"2";
        }
        [cell1.flowCollectionView reloadData];
        // [_testtableView reloadData];
        //[cell1 cellConstruction];
        //  cell1.userArray
        
        return cell1;
        
    }
    
}

-(void)collectionViewSelected:(int )rowIndex sectionInd:(int)sec object:(NSDictionary *)selectedObj{
    
    user_data=[NSUserDefaults standardUserDefaults];
    user_id=[user_data valueForKey:@"user_id"];
    
    if ([user_id isEqualToString:@""]||[user_id isEqual:[NSNull null]]||[user_id isEqualToString:@"<nil>"]||user_id == nil||[user_id isEqualToString:@"0"])
    {//b2b change
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *myNewVC = (LoginViewController *)[storyboard instantiateViewControllerWithIdentifier:@"LoginViewControllerID"];
        myNewVC.From=@"listingPage";
        
        if (selectedObj) {
            myNewVC.product_id=[selectedObj valueForKey:@"id"];
        }
        
        [self.navigationController pushViewController:myNewVC animated:YES];
        
    }
    else{
        if (selectedObj) {
            [self Products_list:[selectedObj valueForKey:@"id"] Type:[selectedObj valueForKey:@"type"]];
        }
    }
  

    
    
}
#pragma mark SarchTable
- (IBAction)returnExit:(id)sender {
    
}

-(void)searchItems:(UITextField *)textField{
    if(textField.text.length>0)
    {
        searchView.hidden =NO;
        
        if (mainSearchArry.count==0) {
            
            [self searchWebserviceCall];
            
        }else{
            
            NSPredicate *pred  = [NSPredicate predicateWithFormat:@"(name CONTAINS[c] %@)",textField.text];
            searchResultArray =[NSMutableArray arrayWithArray:[mainSearchArry filteredArrayUsingPredicate:pred]];
            
            if (searchResultArray.count==0) {
                // searchResultArray = mainSearchArry;
                
            }
            searchItemsArray = searchResultArray;
            [searchView relaodSearchTable];
            
            
        }
        
        
        
    }else{
        //  [searchItemsArray removeAllObjects];
       
        selectedDic = [[NSDictionary alloc]init];
        searchView.hidden =YES;
    }
}
-(void)tapped{
    
//    _searchTextField.text =@"";
//    selectedDic = [[NSDictionary alloc]init];
//    searchView.hidden =YES;
    [self.view endEditing:YES];
    
}
-(void)searchWebserviceCall
{
    [[STParsing sharedWebServiceHelper]requesting_GET_ServiceWithString:@"search" requestNumber:WS_Search showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             if (data) {
                 
                 searchItemsArray = [[NSMutableArray alloc]init];
                 mainSearchArry = [[NSMutableArray alloc]init];
                 [searchItemsArray  addObjectsFromArray:data];
                 [ mainSearchArry addObjectsFromArray:data];
                 
                 [searchView relaodSearchTable];
                 //archive
                 
             }
             
         }
         
         
     }];
    
}

#pragma mark Search delegate methods
-(float)setHeighForSearchTable:(UITableView *)tableView{
    
    return 40;
}

-(NSInteger )numberOffRowsInSearchTableView:(UITableView *)tableView{
    
    return searchItemsArray.count;
    
}
- (JMOTableViewCell *)cellforRowAtSearchINdex:(UITableView*)tableVIew viewAtIndex:(NSIndexPath *)index{
    
    JMOTableViewCell *cell = [tableVIew dequeueReusableCellWithIdentifier:@"searchCell"];
    if (cell==nil)
    {
        [tableVIew registerNib:[UINib nibWithNibName:@"JMOTableViewCell" bundle:nil] forCellReuseIdentifier:@"searchCell"];
        cell = [tableVIew dequeueReusableCellWithIdentifier:@"searchCell"];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.labelName.text =[[searchItemsArray objectAtIndex:index.row] valueForKey:@"name"];
    
        
    return cell;
    
}
-(void)searchTableViewSelected:(UITableView *)table IndexPath:(NSIndexPath * )indexPath {
    selectedDic = [[NSDictionary alloc]init];
    selectedDic =[searchItemsArray objectAtIndex:indexPath.row];
    _searchTextField.text =[selectedDic valueForKey:@"name"];
    searchView.hidden =YES;
    
    
}


- (IBAction)searchProductActionClicked:(id)sender {
    
    /*
     id = 13293;
     name = "75X32 MS Flats";
     type = product;
     
     */
    
    
   _searchTextField.text= [_searchTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (_searchTextField.text.length == 0) {
        
        ALERT_DIALOG(@"alert",@"Pleace enter item name ");
        
    }else{
        
        if(selectedDic){
            [self Products_list:[selectedDic valueForKey:@"id"] Type:[selectedDic valueForKey:@"type"]];
        _searchTextField.text =@"";
        selectedDic = nil;
        searchView.hidden =YES;
            
        }else{
            
              ALERT_DIALOG(@"alert",@"Pleace select an item ");
        }
        
    }
    
}
-(void)Products_list:(NSString *)productId Type:(NSString *)type
{
    Products_List * newView = [[Products_List alloc] initWithNibName:@"Products_List" bundle:nil];
    newView.product_id=productId;
    newView.product_type=type;
    [self.navigationController pushViewController:newView animated:YES];
}
-(void)recieveMenuAction:(NSNotification*)notification
{
    if ([user_id isEqualToString:@""]||[user_id isEqual:[NSNull null]]||[user_id isEqualToString:@"<nil>"]||user_id == nil||[user_id isEqualToString:@"0"])
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *myNewVC = (LoginViewController *)[storyboard instantiateViewControllerWithIdentifier:@"LoginViewControllerID"];
        myNewVC.From=@"listingPage";
        
       
            myNewVC.product_id=[notification.userInfo valueForKey:@"id"];
      
        [self.navigationController pushViewController:myNewVC animated:YES];
    }else{
    
         [self Products_list:[notification.userInfo valueForKey:@"id"] Type:[notification.userInfo valueForKey:@"type"]];
    }
    
}


#pragma mark Right menu
- (IBAction)optionsMenuClicked:(id)sender
{
    _optionsMenu_bgVIew .frame = self.view.frame;
    
    NSString *user =[[ NSUserDefaults standardUserDefaults]valueForKey:@"user_id"];
    //73[[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"ckeckLOGIN"];
   // BOOL isCheck = [[ NSUserDefaults standardUserDefaults]boolForKey:@"ckeckLOGIN"];
    
    if ([user_id isEqualToString:@""]||[user_id isEqual:[NSNull null]]||[user_id isEqualToString:@"<nil>"]||user_id == nil||[user_id isEqualToString:@"0"])
    {
        
        _signOutHeightConstarint.constant = 0;
        _signOutBtn.hidden =YES;
        _signOutIcon.hidden =YES;
        _yourOrdersIcon.hidden =YES;
        _yourOrdersHeightConstraint.constant = 0 ;
        _yourOrders_btn.hidden =YES;

        
        
    }else{
        _yourOrdersIcon.hidden =NO;
        _yourOrdersHeightConstraint.constant = 44 ;
        _signOutHeightConstarint.constant = 44;
        _signOutBtn.hidden =NO;
        _signOutIcon.hidden =NO;
        _yourOrders_btn.hidden =NO;

        
    }
    [_optionsMenu_containerView layoutIfNeeded];
    
     _optionsMenu_containerView.frame = CGRectMake(_optionsMenu_containerView.frame.origin.x, -250, _optionsMenu_containerView.frame.size.width, _optionsMenu_containerView.frame.size.height);
    [self.view addSubview:_optionsMenu_bgVIew];
    _optionsMenu_bgVIew.alpha = 0;

    
    
    [UIView animateWithDuration:0.5 animations:^{
        _optionsMenu_containerView.frame = CGRectMake( _optionsMenu_containerView.frame.origin.x, 0, _optionsMenu_containerView.frame.size.width, _optionsMenu_containerView.frame.size.height);
        _optionsMenu_bgVIew.alpha = 1;

    }];
 
}

- (IBAction)rightMenuActions:(UIButton *)sender
{
    switch (sender.tag)
    {
        case 0:
        {
            // your orders
            if ([user_id isEqualToString:@""]||[user_id isEqual:[NSNull null]]||[user_id isEqualToString:@"<nil>"]||user_id == nil||[user_id isEqualToString:@"0"])
            {
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                LoginViewController *myNewVC = (LoginViewController *)[storyboard instantiateViewControllerWithIdentifier:@"LoginViewControllerID"];
                myNewVC.From=@"orders";
                [self.navigationController pushViewController:myNewVC animated:YES];
            }
            else//go to cart page
            {
            YourOrdersViewController *define = [[YourOrdersViewController alloc]initWithNibName:@"YourOrdersViewController" bundle:nil];
            [self.navigationController pushViewController:define animated:YES];
            }
        }
        break;
        case 1:
        {
            if ([user_id isEqualToString:@""]||[user_id isEqual:[NSNull null]]||[user_id isEqualToString:@"<nil>"]||user_id == nil||[user_id isEqualToString:@"0"])
            {
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                LoginViewController *myNewVC = (LoginViewController *)[storyboard instantiateViewControllerWithIdentifier:@"LoginViewControllerID"];
                myNewVC.From=@"management";
                [self.navigationController pushViewController:myNewVC animated:YES];
            }
            else//go to cart page
            {
            // account management
            AccountManageViewController *ac = [[AccountManageViewController alloc]initWithNibName:@"AccountManageViewController" bundle:nil];
            [self.navigationController pushViewController:ac animated:YES];
            }
        }
            break;
        case 2:
        {
            /*
             //1155115857 eweels
             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=374892313&onlyLatestVersion=false&type=Purple+Software"]];
             */

//            NSString * theUrl = [NSString  stringWithFormat:@"https://itunesconnect.apple.com/WebObjects/iTunesConnect.woa/ra/ng/app/1155115857"];
//
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:theUrl]];
        }
            break;
        case 3:
        {
            // sign out
              [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"ckeckLOGIN"];
            user_data=[NSUserDefaults standardUserDefaults];
            [user_data setValue:@"0" forKey:@"user_id"];
            [user_data setValue:@"0" forKey:@"cart_count"];
            [self Alert:@"Your A/C has been signed out!"];
            _Cart_count.text=@"0";
            user_id = @"0";
            
          

        }
            break;
        case 4:
        {
            // close menu
        }
            break;
            
        default:
            break;
    }

   [UIView animateWithDuration:0.5 animations:^{
       _optionsMenu_containerView.frame = CGRectMake(_optionsMenu_containerView.frame.origin.x, -250, _optionsMenu_containerView.frame.size.width, _optionsMenu_containerView.frame.size.height);
       _optionsMenu_bgVIew.alpha = 0;
   } completion:^(BOOL finished) {
       
       [_optionsMenu_bgVIew removeFromSuperview];
       
   }
     ];
}

- (IBAction)Cart_click:(id)sender
{
    user_data=[NSUserDefaults standardUserDefaults];
    user_id=[user_data valueForKey:@"user_id"];
    
    if ([user_id isEqualToString:@""]||[user_id isEqual:[NSNull null]]||[user_id isEqualToString:@"<nil>"]||user_id == nil||[user_id isEqualToString:@"0"])
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *myNewVC = (LoginViewController *)[storyboard instantiateViewControllerWithIdentifier:@"LoginViewControllerID"];
        [self.navigationController pushViewController:myNewVC animated:YES];
    }
    else//go to cart page
    {
        My_Cart *define = [[My_Cart alloc]init];
        [self.navigationController pushViewController:define animated:YES];
    }
}
-(void)Alert:(NSString *)Msg
{
    NSDictionary *options = @{kCRToastNotificationTypeKey:@(CRToastTypeNavigationBar),
                              
                              kCRToastTextKey : Msg,
                              
                              kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                              
                              kCRToastBackgroundColorKey : [UIColor colorWithRed:44.0/255.0 green:52.0/255.0 blue:75.0/255.0 alpha:1],
                              kCRToastTimeIntervalKey: @(2),
                              //                              kCRToastFontKey:[UIFont fontWithName:@"PT Sans Narrow" size:23],
                              kCRToastInteractionRespondersKey:@[[CRToastInteractionResponder interactionResponderWithInteractionType:CRToastInteractionTypeSwipeUp
                                                                  
                                                                                                                 automaticallyDismiss:YES
                                                                  
                                                                                                                                block:^(CRToastInteractionType interactionType){
                                                                                                                                    
                                                                                                                                    NSLog(@"Dismissed with %@ interaction", NSStringFromCRToastInteractionType(interactionType));
                                                                                                                                }]],
                              kCRToastAnimationInTypeKey : @(CRToastAnimationTypeGravity),
                              
                              kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeGravity),
                              
                              kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionTop),
                              
                              kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionTop)
                              
                              };
    
    [CRToastManager showNotificationWithOptions:options
     
                                completionBlock:^{
                                    
                                    NSLog(@"Completed");
                                    
                                }];
}

- (IBAction)relaodAction:(id)sender {
    
    [self callInitialWebservice];
    [self performSelector:@selector(getAddImagesFromServer) withObject:nil afterDelay:0.2];
    [self performSelector:@selector(loadAdds) withObject:nil afterDelay:0.0];
    
}



@end
