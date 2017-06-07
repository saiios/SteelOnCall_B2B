//
//  CateGoryTableViewCell.m
//  SteelonCall
//
//  Created by Manoyadav on 03/12/16.
//  Copyright © 2016 com.way2online. All rights reserved.
//

#import "CateGoryTableViewCell.h"

@implementation CateGoryTableViewCell

- (void)drawRect:(CGRect)rect
{
    CGRect cellFrame = self.cellLabel.frame;
    CGRect buttonFrame = self.cellButton.frame;
    int indentation = (int)self.treeNode.nodeLevel * 25;
    cellFrame.origin.x = buttonFrame.size.width + indentation + 10;
    buttonFrame.origin.x = 2 + indentation;
    self.cellLabel.frame = cellFrame;
    self.cellButton.frame = buttonFrame;
    
    
}

- (void)setTheButtonBackgroundImage:(UIImage *)backgroundImage
{
    [self.cellButton setBackgroundImage:backgroundImage forState:UIControlStateNormal];
}

- (IBAction)cellClicked:(id)sender {
}

- (IBAction)expand:(UIButton *)sender
{
    if (sender.selected) {
        [sender setSelected:NO];
        self.treeNode.isExpanded = !self.treeNode.isExpanded;
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"ProjectTreeNodeButtonClicked" object:self];
    }else{
        [sender setSelected:YES];
        if (self.treeNode.nodeLevel == 0) {
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"close" object:self];
        }
        self.treeNode.isExpanded = !self.treeNode.isExpanded;
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"ProjectTreeNodeButtonClicked" object:self];
        
    }
}

@end
