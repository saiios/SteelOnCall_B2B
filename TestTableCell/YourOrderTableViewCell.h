//
//  YourOrderTableViewCell.h
//  SteelonCall
//
//  Created by Manoyadav on 06/12/16.
//  Copyright © 2016 com.way2online. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YourOrderTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *order_date_lbl;
@property (strong, nonatomic) IBOutlet UIImageView *order_imageView;
@property (strong, nonatomic) IBOutlet UILabel *order_title_lbl;
@property (strong, nonatomic) IBOutlet UILabel *order_status_lbl;
@property (strong, nonatomic) IBOutlet UILabel *order_service_status;

@end
