//
//  HomeViewController.h
//  TestTableCell
//
//  Created by administrator on 29/11/16.
//  Copyright © 2016 com.SteelonCall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"
#import "DEMONavigationController.h"
#import "UIViewController+REFrostedViewController.h"
#import "LeftPanelViewController.h"
#import "CustomTableViewCell.h"
#import "HeaderTableViewCell.h"
#import "Products_List.h"
#import "searchPopupVIew.h"
#import "Detail_Order_View.h"

@interface HomeViewController : UIViewController<cellSelectDelegate,UINavigationControllerDelegate,searchTableViewDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    searchPopupVIew *searchView;
    NSMutableArray *searchItemsArray;
    NSMutableArray *searchResultArray;
    NSMutableArray *mainSearchArry;

    NSDictionary *selectedDic;
    NSUserDefaults *user_data;
    NSString *user_id;
    NSMutableDictionary *ad_Array;
    
}
@property (strong, nonatomic) IBOutlet UILabel *Cart_count;
@property (strong, nonatomic) IBOutlet UIView *cart_view;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
- (IBAction)rightMenuActions:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIView *optionsMenu_bgVIew;
@property (strong, nonatomic) IBOutlet UIView *optionsMenu_containerView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *optionsRightContarint;
- (IBAction)Cart_click:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *searchBtn;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *signOutHeightConstarint;

@property (strong, nonatomic) IBOutlet UIButton *signOutBtn;

@property (strong, nonatomic) IBOutlet UIImageView *signOutIcon;
@property (strong, nonatomic) IBOutlet UIButton *reloadBtn;
@property (strong, nonatomic) IBOutlet UILabel *errorLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yourOrdersHeightConstraint;

@property (weak, nonatomic) IBOutlet UIImageView *yourOrdersIcon;
@property (weak, nonatomic) IBOutlet UIButton *yourOrders_btn;



@end
