//
//  SettingViewController.m
//  tipcalculator
//
//  Created by Eric Zou on 2/23/14.
//  Copyright (c) 2014 Eric Zou. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()
@property (weak, nonatomic) IBOutlet UILabel *firstTipPercent;
@property (weak, nonatomic) IBOutlet UILabel *secondTipPercent;
@property (weak, nonatomic) IBOutlet UILabel *thirdTipPercent;

@property (weak, nonatomic) IBOutlet UISlider *firstTipSlider;
@property (weak, nonatomic) IBOutlet UISlider *secondTipSlider;
@property (weak, nonatomic) IBOutlet UISlider *thirdTipSlider;

-(void) resetTipLabels;
-(void) resetTipSliders;
- (NSArray *) getTipValues;
- (NSString *) tipValueFormatter:(float) tipValue;

- (IBAction)onValueChanged:(id)sender;
@end

@implementation SettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.firstTipSlider.minimumValue = 0;
    self.firstTipSlider.maximumValue = 100;
    self.secondTipSlider.minimumValue = 0;
    self.secondTipSlider.maximumValue = 100;
    self.thirdTipSlider.minimumValue = 0;
    self.thirdTipSlider.maximumValue = 100;
    
    [self resetTipLabels];
    [self resetTipSliders];

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [self resetTipLabels];
    [self resetTipSliders];
}

- (NSString *) tipValueFormatter:(float) tipValue{
    tipValue = tipValue * 100;
    NSString *text = [NSString stringWithFormat:@"%d%%", (int)tipValue];
    return text;
}

- (void) resetTipLabels {
    NSArray *tipValues = self.getTipValues;
    float firstTipPercent = [tipValues[0] floatValue];
    float secondTipPercent = [tipValues[1] floatValue];
    float thirdTipPercent = [tipValues[2] floatValue];
    self.firstTipPercent.text = [self tipValueFormatter:firstTipPercent];
    self.secondTipPercent.text = [self tipValueFormatter:secondTipPercent];
    self.thirdTipPercent.text = [self tipValueFormatter:thirdTipPercent];
}

- (void) resetTipSliders {
    NSArray *tipValues = self.getTipValues;
    self.firstTipSlider.value = [tipValues[0] floatValue]*100;
    self.secondTipSlider.value = [tipValues[0] floatValue]*100;
    self.thirdTipSlider.value = [tipValues[0] floatValue]*100;
    
}

- (NSArray *) getTipValues {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *firstTipValue = [defaults objectForKey:@"first_tip_value"];
    NSString *secondTipValue = [defaults objectForKey:@"second_tip_value"];
    NSString *thirdTipValue = [defaults objectForKey:@"third_tip_value"];
    
    return @[@([firstTipValue floatValue]), @([secondTipValue floatValue]), @([thirdTipValue floatValue])];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onValueChanged:(id)sender {
    UISlider *slider = (UISlider *)sender;
    NSInteger val = lround(slider.value);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //oh, well
    if (slider == self.firstTipSlider) {
        self.firstTipPercent.text = [NSString stringWithFormat:@"%d%%",val];
        [defaults setObject:[NSString stringWithFormat:@"%.02f", val/100.00f] forKey:@"first_tip_value"];
    } else if (slider == self.secondTipSlider) {
        self.secondTipPercent.text = [NSString stringWithFormat:@"%d%%",val];
//        NSLog(@"value: %.02f", (float)val/100);
        [defaults setObject:[NSString stringWithFormat:@"%.02f", val/100.00f] forKey:@"second_tip_value"];

    } else {
        self.thirdTipPercent.text = [NSString stringWithFormat:@"%d%%",val];
        [defaults setObject:[NSString stringWithFormat:@"%.02f", val/100.00f] forKey:@"third_tip_value"];
    }

}
@end
