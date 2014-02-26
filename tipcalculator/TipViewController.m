//
//  TipViewController.m
//  tipcalculator
//
//  Created by Eric Zou on 2/22/14.
//  Copyright (c) 2014 Eric Zou. All rights reserved.
//

#import "TipViewController.h"
#import "SettingViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property NSArray *tipValues;

- (IBAction)onTap:(id)sender;
- (void)updateValues;
- (void)onSettingsButton;
- (void)initTipPercentage;
- (void)setDefaults;
- (NSArray *)getTipValues;
- (void)initTipContrl;
- (NSString *)tipValueFormatter:(float)tipValue;

@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Tip Calculator";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    
    // init tip percentage setttings
    [self initTipPercentage];
    
    [self initTipContrl];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"view will appear");
}

- (void)viewDidAppear:(BOOL)animated {
    [self initTipPercentage];
    [self initTipContrl];
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"view will disappear");
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"view did disappear");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void) updateValues {
    float billAmount = [self.billTextField.text floatValue];
    float tipAmout = billAmount * [self.tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    float totalAmount = tipAmout + billAmount;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmout];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];

}

- (void)onSettingsButton {
    [self.navigationController pushViewController:[[SettingViewController alloc] init] animated:YES];
}

- (void) initTipPercentage {
    self.tipValues = [self getTipValues];
    if ([self.tipValues isEqualToArray:@[@(0), @(0), @(0)]]) {
        [self setDefaults];
        self.tipValues = [self getTipValues];
    }
}

- (void) setDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"0.1" forKey:@"first_tip_value"];
    [defaults setObject:@"0.15" forKey:@"second_tip_value"];
    [defaults setObject:@"0.20" forKey:@"third_tip_value"];
    [defaults synchronize];
}

- (NSArray *) getTipValues {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *firstTipValue = [defaults objectForKey:@"first_tip_value"];
    NSString *secondTipValue = [defaults objectForKey:@"second_tip_value"];
    NSString *thirdTipValue = [defaults objectForKey:@"third_tip_value"];
    
    return @[@([firstTipValue floatValue]), @([secondTipValue floatValue]), @([thirdTipValue floatValue])];
}

- (NSString *) tipValueFormatter:(float) tipValue{
    tipValue = tipValue * 100;
    NSString *text = [NSString stringWithFormat:@"%d%%", (int)tipValue];
    return text;
}

- (void) initTipContrl {
    float firstTipValue = [self.tipValues[0] floatValue];
    float secondTipValue = [self.tipValues[1] floatValue];
    float thirdTipValue = [self.tipValues[2] floatValue];
    NSLog(@"values %@", self.tipValues);
    [self.tipControl setTitle:[self tipValueFormatter:firstTipValue] forSegmentAtIndex:0];
    [self.tipControl setTitle:[self tipValueFormatter:secondTipValue] forSegmentAtIndex:1];
    [self.tipControl setTitle:[self tipValueFormatter:thirdTipValue] forSegmentAtIndex:2];
}

@end
