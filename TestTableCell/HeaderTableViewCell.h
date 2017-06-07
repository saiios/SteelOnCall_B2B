//
//  HeaderTableViewCell.h
//  TestTableCell
//
//  Created by administrator on 29/11/16.
//  Copyright © 2016 com.SteelonCall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderTableViewCell : UITableViewCell<UIScrollViewDelegate>
{
    UIPageControl *pageControl ;
}
@property (strong, nonatomic) IBOutlet UIScrollView *imageScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollHeightConstrain;

@property (strong, nonatomic) IBOutlet UIImageView *addImg1_imageVIew;

@property (strong, nonatomic) IBOutlet UIImageView *addImage2_imageView;
@property (strong, nonatomic) IBOutlet UILabel *add1Desc_lbl;
@property (strong, nonatomic) IBOutlet UILabel *add2Desc_lbl;

@end
