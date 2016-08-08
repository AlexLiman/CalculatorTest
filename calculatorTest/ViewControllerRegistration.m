//
//  ViewControllerRegistration.m
//  calculatorTest
//
//  Created by Admin on 8/4/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ViewControllerRegistration.h"
#import "ViewController.h"
#import "MySingleton.h"
#import "ValidationTextField.h"

static NSString* kSettingsLogin           = @"login";
static NSString* kSettingsPassword        = @"password";

@interface ViewControllerRegistration () <UITextFieldDelegate>

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *registrationTextFields;
@property (assign, nonatomic) BOOL isCorrect;
@property (weak, nonatomic) UITextField *currentTextField;
@property (strong, nonatomic) ValidationTextField *valid;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewControllerRegistration {
    UIDatePicker *datePicker;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.valid = [[ValidationTextField alloc] init];
    // Do any additional setup after loading the view.
    for (int i = 0; i < [self.registrationTextFields count]; i++) {
        
        UITextField *field = [self.registrationTextFields objectAtIndex:i];
        field.attributedPlaceholder = [[NSAttributedString alloc]   initWithString:field.placeholder
                                                                        attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    }

    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self selector:@selector(notificationKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [nc addObserver:self selector:@selector(notificationKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    for (int i = 0; i < [self.registrationTextFields count]; i++) {
        
        UITextField *field = [self.registrationTextFields objectAtIndex:i];
        
        switch (field.tag) {
            case 1:
                field.text = @"Alex";
                break;
            case 2:
                field.text = @"Liman";
                break;
            case 3:
                field.text = @"limanalex@mail.ru";
                break;
            case 4:
                field.text = @"+115 (555) 555-5555";
                break;
            case 5:
                field.text = @"Liman";
                break;
            case 6:
                field.text = @"June 13, 1995";
                break;
            case 7:
                field.text = @"Lindeman";
                break;
            case 8:
                field.text = @"1234567";
                break;
                
        }
        
    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



#pragma mark - RegularExeption

- (IBAction)regExp:(UIButton *)sender {
    [self saveSettings];
    
    for (int i = 0; i < [self.registrationTextFields count]; i++) {
        
        UITextField *field = [self.registrationTextFields objectAtIndex:i];
        
        [self.valid regExp:field];
        
    }
    
    
    
    MySingleton *singleton = [MySingleton sharedMySingleton];

    
    if ([self.valid validate] == YES) {
        
        if (singleton.netStatus == NotReachable) {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                           message:@"Нет доступа к интернету"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {
                                                                  
                                                    
                                                                  
                                                                  
                                                                  }];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            
        } else {
            ViewController *add = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewControllerIndicator"];
            [self presentViewController:add animated:YES completion:nil];
        }
       
    }
    self.valid.isCorrect = YES;
    
    
}

- (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}



#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    

//    for (int i = 0; i < [self.registrationTextFields count]; i++) {
//        
//        UITextField *field = [self.registrationTextFields objectAtIndex:i];
//        if ([textField isEqual:field] && textField.tag != 8) {
//            UITextField  *field =  [self.registrationTextFields objectAtIndex:i + 1];
//            return [field becomeFirstResponder];
//        }
//    }
    return [textField resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    //NSLog(@"textField text = %@", textField.text);
    //NSLog(@"shouldChangeCharactersInRange %@", NSStringFromRange(range));
    //NSLog(@"replacementString %@", string);
    
    if (textField.tag != 4 && textField.tag != 3) {
        //NSCharacterSet* validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        //NSArray* components = [string componentsSeparatedByCharactersInSet:validationSet];
        NSCharacterSet *myCharacters = [NSCharacterSet characterSetWithCharactersInString:@",./?'\"*()&^%$#@!~`><|\\;:[]{}-1234567890"];
        NSArray* components = [string componentsSeparatedByCharactersInSet:myCharacters];
        
        
        
        if ([components count] > 1) {
            return NO;
        }

    }
   
    if (textField.tag == 4) {
        NSCharacterSet* validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        NSArray* components = [string componentsSeparatedByCharactersInSet:validationSet];
        
        if ([components count] > 1) {
            return NO;
        }
        
        NSString* newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        //+XX (XXX) XXX-XXXX
        
        NSLog(@"new string = %@", newString);
        
        NSArray* validComponents = [newString componentsSeparatedByCharactersInSet:validationSet];
        
        newString = [validComponents componentsJoinedByString:@""];
        
        // XXXXXXXXXXXX
        
        NSLog(@"new string fixed = %@", newString);
        
        static const int localNumberMaxLength = 7;
        static const int areaCodeMaxLength = 3;
        static const int countryCodeMaxLength = 3;
        
        if ([newString length] > localNumberMaxLength + areaCodeMaxLength + countryCodeMaxLength) {
            return NO;
        }
        
        
        NSMutableString* resultString = [NSMutableString string];
        
        /*
         XXXXXXXXXXXX
         +XX (XXX) XXX-XXXX
         */
        
        NSInteger localNumberLength = MIN([newString length], localNumberMaxLength);
        
        if (localNumberLength > 0) {
            
            NSString* number = [newString substringFromIndex:(int)[newString length] - localNumberLength];
            
            [resultString appendString:number];
            
            if ([resultString length] > 3) {
                [resultString insertString:@"-" atIndex:3];
            }
            
        }
        
        if ([newString length] > localNumberMaxLength) {
            
            NSInteger areaCodeLength = MIN((int)[newString length] - localNumberMaxLength, areaCodeMaxLength);
            
            NSRange areaRange = NSMakeRange((int)[newString length] - localNumberMaxLength - areaCodeLength, areaCodeLength);
            
            NSString* area = [newString substringWithRange:areaRange];
            
            area = [NSString stringWithFormat:@"(%@) ", area];
            
            [resultString insertString:area atIndex:0];
        }
        
        if ([newString length] > localNumberMaxLength + areaCodeMaxLength) {
            
            NSInteger countryCodeLength = MIN((int)[newString length] - localNumberMaxLength - areaCodeMaxLength, countryCodeMaxLength);
            
            NSRange countryCodeRange = NSMakeRange(0, countryCodeLength);
            
            NSString* countryCode = [newString substringWithRange:countryCodeRange];
            
            countryCode = [NSString stringWithFormat:@"+%@ ", countryCode];
            
            [resultString insertString:countryCode atIndex:0];
        }
        
        
        textField.text = resultString;
        
        return NO;
        
        
        
        //NSCharacterSet* set = [NSCharacterSet characterSetWithCharactersInString:@" ,?"];
        /*
         NSCharacterSet* set = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
         NSArray* words = [resultString componentsSeparatedByCharactersInSet:set];
         NSLog(@"words = %@", words);
         
         
         return [resultString length] <= 10;
         */

    }
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
  
    self.currentTextField = textField;
    if (textField.tag == 6) {
        datePicker = [[UIDatePicker alloc] init];
        datePicker.datePickerMode = UIDatePickerModeDate;
        textField.inputView = datePicker;
        
        
        [datePicker addTarget:self action:@selector(datePicerChanged:) forControlEvents:UIControlEventValueChanged];
    }

    return YES;
}

- (void)datePicerChanged:(UIDatePicker *)sender {
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    formater.dateStyle = NSDateFormatterLongStyle;
    UITextField *email;
    for (int i = 0; i < [self.registrationTextFields count]; i++) {
        UITextField *field = [self.registrationTextFields objectAtIndex:i];
        if (field.tag == 6) {
            email = field;
        }
    }
    email.text = [formater stringFromDate:sender.date];
    
}


#pragma mark - Save and Load

- (void) saveSettings {
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:[[self.registrationTextFields objectAtIndex:6] text] forKey:kSettingsLogin];
    [userDefaults setObject:[[self.registrationTextFields objectAtIndex:7] text] forKey:kSettingsPassword];

    
    [userDefaults synchronize];
}


#pragma mark - Notifications

- (void) notificationKeyboardWillShow:(NSNotification*) notification {
    
    //NSLog(@"notificationKeyboardWillShow:\n%@", notification.userInfo);

        __block CGRect rectKeyboard1;
        [UIView animateWithDuration:0.25f animations:^{
            
            NSDictionary* info = [notification userInfo];
            CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
            UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
            self.scrollView.contentInset = contentInsets;
            self.scrollView.scrollIndicatorInsets = contentInsets;
            
            // If active text field is hidden by keyboard, scroll it so it's visible
            // Your application might not need or want this behavior.
            CGRect aRect = self.view.frame;
            aRect.size.height -= kbSize.height;
            if (!CGRectContainsPoint(aRect, self.currentTextField.frame.origin) ) {
                CGPoint scrollPoint = CGPointMake(0.0, self.currentTextField.frame.origin.y-kbSize.height);
                [self.scrollView setContentOffset:scrollPoint animated:YES];
            }
        }];
    
}

- (void) notificationKeyboardWillHide:(NSNotification*) notification {
    
    //NSLog(@"notificationKeyboardWillHide:\n%@", notification.userInfo);
    [UIView animateWithDuration:0.25f animations:^{
        UIEdgeInsets contentInsets = UIEdgeInsetsZero;
        self.scrollView .contentInset = contentInsets;
        self.scrollView .scrollIndicatorInsets = contentInsets;
    }];
}


@end


