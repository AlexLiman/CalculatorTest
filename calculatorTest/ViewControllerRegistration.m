//
//  ViewControllerRegistration.m
//  calculatorTest
//
//  Created by Admin on 8/4/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ViewControllerRegistration.h"


static NSString* kSettingsLogin           = @"login";
static NSString* kSettingsPassword        = @"password";

@interface ViewControllerRegistration () <UITextFieldDelegate>

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *registrationTextFields;

@end

@implementation ViewControllerRegistration

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    for (int i = 0; i < [self.registrationTextFields count]; i++) {
        
        UITextField *field = [self.registrationTextFields objectAtIndex:i];
        field.attributedPlaceholder = [[NSAttributedString alloc]   initWithString:field.placeholder
                                                                        attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    }
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

#pragma mark - RegularExeption

- (IBAction)regExp:(UIButton *)sender {
    [self saveSettings];
    
    for (int i = 0; i < [self.registrationTextFields count]; i++) {
        
        UITextField *field = [self.registrationTextFields objectAtIndex:i];
        
        switch (field.tag) {
            case 1:
                
                break;
            case 2:
                
                break;
            case 3:
                if(![self validateEmail:field.text]) {
                    field.text = @"";
                    field.placeholder = @"Неверный формат";
                    field.attributedPlaceholder = [[NSAttributedString alloc]   initWithString:@"Неверный формат!"
                                                                                    attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
                    
                }
                break;
            case 4:
                
                break;
            case 5:
                
                break;
            case 6:
                
                break;
            case 7:
                if ([field.text length] < 6) {
                    field.text = @"";
                    field.attributedPlaceholder = [[NSAttributedString alloc]   initWithString:@"Пароль меньше шести символов!"
                                                                                    attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
                    
                }
                break;
            case 8:
                
                break;
                
            default:
                break;
        }
        
    }
    
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


#pragma mark - Save and Load

- (void) saveSettings {
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:[[self.registrationTextFields objectAtIndex:6] text] forKey:kSettingsLogin];
    [userDefaults setObject:[[self.registrationTextFields objectAtIndex:7] text] forKey:kSettingsPassword];

    
    [userDefaults synchronize];
}




@end


