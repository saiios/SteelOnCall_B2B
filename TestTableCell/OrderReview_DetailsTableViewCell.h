//
//  OrderReview_DetailsTableViewCell.h
//  steelonCallThree
//
//  Created by nagaraj  kumar on 02/12/16.
//  Copyright © 2016 nagaraj  kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderReview_DetailsTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *order_Image;
@property (strong, nonatomic) IBOutlet UILabel *order_title_lbl;

@property (strong, nonatomic) IBOutlet UILabel *Tons_Lbl;
@property (strong, nonatomic) IBOutlet UILabel *pices_Lbl;

@end
