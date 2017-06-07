//
//  Pay_ProductDetailsTableViewCell.h
//  steelonCallThree
//
//  Created by nagaraj  kumar on 03/12/16.
//  Copyright © 2016 nagaraj  kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Pay_ProductDetailsTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *seller_NameLbl;
@property (strong, nonatomic) IBOutlet UILabel *product_NameLbl;
@property (strong, nonatomic) IBOutlet UILabel *brand_NameLbl;
@property (strong, nonatomic) IBOutlet UILabel *grade_nameLbl;
@property (strong, nonatomic) IBOutlet UILabel *price_per_tonLbl;
@property (strong, nonatomic) IBOutlet UILabel *Quantity_Lbl;
@property (strong, nonatomic) IBOutlet UILabel *sub_toatal;

@end
