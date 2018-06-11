//
//  UITableViewCell+Extension.h
//  ShuangKuai-iOS
//
//  Created by 宇中 on 2017/12/14.
//  Copyright © 2017年 com.shuangkuaimai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (Extension)

+ (void)registerToTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier;

+ (void)registerToTableView:(UITableView *)tableView;

@end
