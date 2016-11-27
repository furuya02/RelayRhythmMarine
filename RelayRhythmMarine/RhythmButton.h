//
//  RhythmButton.h
//  RelayRhythmMarine
//
//  Created by hirauchi.shinichi on 2016/11/26.
//  Copyright © 2016年 SAPPOROWORKS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RhythmButton : UIButton

@property (nonatomic) NSUInteger identifitr;
@property (nonatomic) Boolean isActive;

- (id)initWithFrame:(CGRect)frame label:(NSString *)title identifire:(NSInteger)identifire;
- (void)blink;
- (void)toggle;

@end
