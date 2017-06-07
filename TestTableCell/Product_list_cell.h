//
//  Product_list_cell.h
//  SteelonCall
//
//  Created by Manoyadav on 29/11/16.
//  Copyright © 2016 Manoyadav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Product_list_cell : UITableViewCell<UITextFieldDelegate>
- (IBAction)check_click:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *checkbox;
@property (strong, nonatomic) IBOutlet UITextField *tonnes;
@property (strong, nonatomic) IBOutlet UITextField *pieces;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UIImageView *product_img;

@end
