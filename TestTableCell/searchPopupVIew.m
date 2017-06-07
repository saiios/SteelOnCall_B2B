//
//  searchPopupVIew.m
//  SteelonCall
//
//  Created by Venkat on 02/12/16.
//  Copyright © 2016 com.way2online. All rights reserved.
//

#import "searchPopupVIew.h"
#import "JMOTableViewCell.h"

@interface searchPopupVIew () <UITableViewDelegate,UITableViewDataSource>
@end

@implementation searchPopupVIew 

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithRed:44/255.0f green:52/255.0f blue:75/255.0f alpha:1.0];
        // the coverImage has a 5 pixels margin from its frame
        searchTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStyleGrouped];
       // searchTableView.frame = CGRectMake(0, 0,frame.size.width,frame.size.height);
        
        searchTableView.delegate =self;
        searchTableView.dataSource =self;
        self.layer.cornerRadius =5.0;
        self.layer.masksToBounds =YES;
        searchTableView.showsVerticalScrollIndicator =YES;
        [self addSubview:searchTableView];
        [searchTableView reloadData];
        searchTableView.backgroundColor =[UIColor clearColor];
    }
    return self;
}
-(void)updateInstaceFrame:(CGRect)frame{
    
    searchTableView.frame = CGRectMake(0, 0,frame.size.width,frame.size.height);

    [self layoutIfNeeded];
}
#pragma mark TableView Delegate
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    return [_delegate setHeighForSearchTable:tableView];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_delegate numberOffRowsInSearchTableView:tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // JMOTableViewCell *cell = [searchTableView dequeueReusableCellWithIdentifier:@"JMOTableViewCell"];
   // JMOTableViewCell *cell = ;
    
    
    return [_delegate cellforRowAtSearchINdex:tableView viewAtIndex:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_delegate searchTableViewSelected:tableView IndexPath:indexPath];
    
}



-(void)relaodSearchTable{

    [searchTableView reloadData];
}



@end
