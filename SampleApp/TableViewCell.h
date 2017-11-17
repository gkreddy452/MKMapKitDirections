//
//  TableViewCell.h
//  SampleApp
//
//  Created by kasturi gopal on 16/11/17.
//  Copyright © 2017 kasturi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *mainTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTextLabel;

@end
