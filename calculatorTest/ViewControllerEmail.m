//
//  ViewControllerEmail.m
//  Calculator
//
//  Created by Admin on 8/4/16.
//  Copyright © 2016 lindeman. All rights reserved.
//

#import "ViewControllerEmail.h"


@interface ViewControllerEmail () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textFieldEmail;

@end

@implementation ViewControllerEmail

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textFieldEmail.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    return [textField resignFirstResponder];
    
}
@end
