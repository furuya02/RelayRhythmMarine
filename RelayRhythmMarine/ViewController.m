//
//  ViewController.m
//  RelayRhythmMarine
//
//  Created by hirauchi.shinichi on 2016/11/26.
//  Copyright © 2016年 SAPPOROWORKS. All rights reserved.
//

#import "ViewController.h"
#import "Konashi.h"
#import "RhythmButton.h"
#import "UIColor+ColorExtensions.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UISwitch *mainSwitch;
@property (nonatomic, strong) NSTimer* blinkTimer;
@property (nonatomic) NSInteger counter;

@property(nonatomic,strong) NSMutableArray *buttons;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[Konashi shared] setReadyHandler:^{
        [Konashi pinModeAll:KonashiPinModeOutput];
        [Konashi pinMode:KonashiDigitalIO5 mode:KonashiPinModePullup];
        [Konashi pinMode:KonashiDigitalIO4 mode:KonashiPinModePullup];
        [Konashi pinMode:KonashiDigitalIO3 mode:KonashiPinModePullup];
    }];
    
    [[Konashi shared] setConnectedHandler:^{
        self.mainSwitch.enabled = true;
    }];
    
    self.view.backgroundColor = [UIColor darkColor];
    self.mainSwitch.tintColor = [UIColor darkBlinkColor];
    self.mainSwitch.onTintColor = [UIColor activeBlinkColor];
    self.mainSwitch.thumbTintColor = [UIColor darkBlinkColor];
    self.slider.tintColor = [UIColor activeBlinkColor];
    self.slider.maximumTrackTintColor = [UIColor darkBlinkColor];
    self.slider.thumbTintColor = [UIColor darkBlinkColor];

    int topMargin = 30;
    int leftMargin = 20;
    CGRect screenSize = [[ UIScreen mainScreen] bounds];
    int width = (screenSize.size.width - leftMargin * 2) / 5;
    self.counter = 0;
    
    self.buttons = [[NSMutableArray alloc] init];
    for(int y = 0; y < 8; y++){
        NSMutableArray *ar = [[NSMutableArray alloc] init];
        for(int x = 0; x < 5; x++){
            CGRect rect = CGRectMake(leftMargin + (x * width), topMargin + (y * width), width - 7, width - 7);
            RhythmButton *button = [[RhythmButton alloc] initWithFrame:rect label:@"R" identifire:x + y * 10];
            [button addTarget:self action:@selector(tapped:) forControlEvents:UIControlEventTouchUpInside];
            [[self view] addSubview:button];
            [ar addObject:button];
        }
        [self.buttons addObject:ar];
    }

    [Konashi find];
}

-(void)tapped: (RhythmButton *)sender
{
    long x = sender.identifitr % 10;
    long y = sender.identifitr / 10;
    [self.buttons[y][x] toggle];
}

- (void)blink
{
    for(int x=0; x<5; x++){
        [self.buttons[self.counter][x] blink];
        if ([self.buttons[self.counter][x] isActive]) {
            [Konashi digitalWrite:KonashiDigitalIO3 + x value:KonashiLevelHigh];
            usleep(30000);
            [Konashi digitalWrite:KonashiDigitalIO3 + x value:KonashiLevelLow];
        }
    }
    self.counter += 1;
    if (self.counter > 7) {
        self.counter = 0;
    }

}

- (IBAction)changeSlider:(id)sender {
    [self.blinkTimer invalidate];
    self.blinkTimer = [NSTimer scheduledTimerWithTimeInterval:self.interval target:self selector:@selector(blink) userInfo:nil repeats:YES];
}

- (IBAction)changeMainSwitch:(id)sender {
    if (self.mainSwitch.isOn) {
        self.counter = 0;
        self.blinkTimer = [NSTimer scheduledTimerWithTimeInterval:self.interval target:self selector:@selector(blink) userInfo:nil repeats:YES];
    }
    else{
        [self.blinkTimer invalidate];
        [Konashi digitalWrite:KonashiDigitalIO3 value:KonashiLevelLow];
        [Konashi digitalWrite:KonashiDigitalIO4 value:KonashiLevelLow];
        [Konashi digitalWrite:KonashiDigitalIO5 value:KonashiLevelLow];
    }
}

- (float)interval {
    float value = self.slider.value;
    //0.1〜0.7
    value = 0.6 * value;
    return  0.7 - (value);
}

- (IBAction)find:(id)sender {
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
