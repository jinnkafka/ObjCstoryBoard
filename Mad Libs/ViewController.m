//
//  ViewController.m
//  Mad Libs
//
//  Created by Chen Jin on 2/4/15.
//  Copyright (c) 2015 Chen Jin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIAlertViewDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *
    numKidsTextField;
@property (weak, nonatomic) IBOutlet UIView *moreLessView;
@property (weak, nonatomic) IBOutlet UILabel *numAgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *numJobLabel;
@property (weak, nonatomic) IBOutlet UILabel *endingLabel;
@property (weak, nonatomic) IBOutlet UISwitch *happyEndingSwitch;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)firstNameDismissKeyboard:(id)sender {
    [sender resignFirstResponder];
}
- (IBAction)lastNameDismissKeyboard:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)numKidsDismissKeyboard:(id)sender {
    [sender resignFirstResponder];
}


- (IBAction) backgroundButtonTouched {
    [self.firstNameTextField resignFirstResponder];
    [self.lastNameTextField resignFirstResponder];
    [self.numKidsTextField resignFirstResponder];
}


- (IBAction)lessMoreSegmentedControlChanged:(id)sender {
    UISegmentedControl *segControl = (UISegmentedControl *) sender;
    NSInteger segment = segControl.selectedSegmentIndex;
    if (segment == 0) {
        //hide view
        self.moreLessView.hidden = YES;
    } else {
        //show view
        self.moreLessView.hidden = NO;
    }
}

- (IBAction)sliderValueChanged: (id)sender {
    UISlider *slider = (UISlider *)sender;
    NSString *age = [ [NSString alloc]
                     initWithFormat: @"%d", (int) slider.value];
    self.numAgeLabel.text = age;
}

- (IBAction)stepperValueChanged: (id)sender {
    UIStepper *stepper = (UIStepper *)sender;
    NSString *job = [ [NSString alloc]
                     initWithFormat: @"%d", (int) stepper.value];
    self.numJobLabel.text = job;
}

- (IBAction)switchButtonChanged:(id)sender {
    UISwitch *switchButton = (UISwitch *)sender;
    if(switchButton.isOn)
        self.endingLabel.text = @"Yes";
    else
        self.endingLabel.text = @"No";
}

- (IBAction)createStoryButtonTouched: (id)sender {
    UIActionSheet *actionSheet =[[UIActionSheet alloc] initWithTitle:@"Ready for your story?"
                delegate:self
                cancelButtonTitle:@"Not Yet"
                destructiveButtonTitle:nil
                otherButtonTitles:@"Absolutely", nil];
    [actionSheet showInView:self.view];
    
}



- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != [actionSheet cancelButtonIndex]) {
        [self createStory];
    }
}


- (void) createStory {
    NSMutableString *message;
    NSString *ending;
    NSString *title;
    
    if (self.lastNameTextField.text.length == 0 ||
        self.firstNameTextField.text.length == 0 ||
        self.numKidsTextField.text.length == 0){
        title = @"Error";
        message = [ [NSMutableString alloc] initWithString: @"Enter information in the text fields."];
    }
    else {
    message = [ [NSMutableString alloc] initWithFormat:
               @"%@ %@ is %@ years old. %@ has %@ kid(s) and works %@ job(s). %@",
               self.firstNameTextField.text, self.lastNameTextField.text,
               self.numAgeLabel.text, self.firstNameTextField.text, self.numKidsTextField.text,
               self.numJobLabel.text, self.firstNameTextField.text];
    
    if(self.happyEndingSwitch.isOn){
        ending = @" earns a lot of money.";
    } else {
        ending = @" earns little money.";
    }
    
    [message appendString:ending];
    title = @"Your MadLibs Story";
        
    }

    
    UIAlertView *alert = [ [UIAlertView alloc] initWithTitle:title
        message:message
        delegate: self
        cancelButtonTitle:@"Done"
        otherButtonTitles: nil];
    [alert show];
}















@end
