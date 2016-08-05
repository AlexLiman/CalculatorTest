//
//  ViewControllerLogIn.m
//  Calculator
//
//  Created by Admin on 8/4/16.
//  Copyright © 2016 lindeman. All rights reserved.
//

#import "ViewControllerLogIn.h"
static NSString* kSettingsLogin           = @"login";
static NSString* kSettingsPassword        = @"password";
@interface ViewControllerLogIn () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textFieldLogIn;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;

@end

@implementation ViewControllerLogIn

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textFieldLogIn.textColor = [UIColor whiteColor];
    self.textFieldPassword.textColor = [UIColor whiteColor];
    
    self.textFieldLogIn.delegate = self;
    self.textFieldPassword.delegate = self;
    [self loadSettings];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([textField isEqual:self.textFieldLogIn]) {
        
        [self.textFieldPassword becomeFirstResponder];
        
    }
    return [textField resignFirstResponder];
  
}

- (void) loadSettings {
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    
    //    self.loginField.text = [userDefaults objectForKey:kSettingsLogin];
    //    self.passwordField.text = [userDefaults objectForKey:kSettingsPassword];
    if ([[userDefaults objectForKey:kSettingsPassword] isEqualToString:self.textFieldLogIn.text ]&& [[userDefaults objectForKey:kSettingsLogin] isEqualToString:self.textFieldPassword.text]) {
        NSLog(@"Yes");
        
    }
    //
    //    self.levelControl.selectedSegmentIndex = [userDefaults integerForKey:kSettingsLevel];
    //    self.shadowsSwitch.on = [userDefaults boolForKey:kSettingsShadows];
    //    self.detalizationControl.selectedSegmentIndex = [userDefaults integerForKey:kSettingsDetalization];
    //
    //    self.soundSlider.value = [userDefaults doubleForKey:kSettingsSound];
    //    self.musicSlider.value = [userDefaults doubleForKey:kSettingsMusic];
    
}
- (IBAction)actionb:(id)sender {
    [self loadSettings];
}


@end
