//
//  RhythmButton.m
//  RelayRhythmMarine
//
//  Created by hirauchi.shinichi on 2016/11/26.
//  Copyright © 2016年 SAPPOROWORKS. All rights reserved.
//

#import "RhythmButton.h"
#import "UIColor+ColorExtensions.h"

@implementation RhythmButton

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame label:(NSString *)title identifire:(NSInteger)identifire
{
    self = [super initWithFrame:frame];
    if(self){
        
        self.identifitr = identifire;
        self.isActive = false;
        
        self.backgroundColor = [UIColor darkColor];
        [self.layer setCornerRadius:(frame.size.width / 2)];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [self setTitle:title forState:UIControlStateNormal];
    
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        [self setTitleShadowColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.titleLabel.shadowOffset = CGSizeMake(1, 1);
        self.clipsToBounds = true;
        self.layer.masksToBounds = NO;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowRadius = 3;
        self.layer.shadowOpacity = 0.5;
    }
    return self;
}

- (void)toggle{
    if (self.isActive) {
        self.isActive = false;
        self.backgroundColor = [UIColor darkColor];
    }
    else{
        self.isActive = true;
        self.backgroundColor = [UIColor activeColor];
    }
}

- (void)blink{
    self.backgroundColor = self.isActive ? [UIColor activeBlinkColor] : [UIColor darkBlinkColor];
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.backgroundColor = self.isActive ? [UIColor activeColor] : [UIColor darkColor];
                     }
                     completion:nil];
}

@end
