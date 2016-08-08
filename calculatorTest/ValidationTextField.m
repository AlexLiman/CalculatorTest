//
//  Validation.m
//  calculatorTest
//
//  Created by Admin on 8/6/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ValidationTextField.h"



@interface ValidationTextField ()

@end
@implementation ValidationTextField

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isCorrect = YES;
    }
    return self;
}

+ (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}

- (void)regExp:(UITextField *)field{
//
    //
        switch (field.tag) {
            case 1:
                if ([field.text length] == 0 ) {
                    
                    field.attributedPlaceholder = [[NSAttributedString alloc]   initWithString:@"Поле не заполнено!"
                                                                                    attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
                    self.isCorrect = NO;
                } else if ([field.text length] > 0 && [field.text length] < 4) {
                    field.text = @"";
                    field.attributedPlaceholder = [[NSAttributedString alloc]   initWithString:@"Длина имени меньше четырех символов!"
                                                                                    attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
                    self.isCorrect = NO;
                }
                break;
            case 2:
                if ([field.text length] == 0) {
                    
                    field.attributedPlaceholder = [[NSAttributedString alloc]   initWithString:@"Поле не заполнено!"
                                                                                    attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
                    self.isCorrect = NO;
                } else if ([field.text length] > 0 && [field.text length] < 4) {
                    field.text = @"";
                    field.attributedPlaceholder = [[NSAttributedString alloc]   initWithString:@"Длина фамилии меньше 4 симоволов!"
                                                                                    attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
                    self.isCorrect = NO;
                }
                break;
            case 3:
                if(![ValidationTextField validateEmail:field.text] && [field.text length] > 0) {
                    field.text = @"";
                    //field.placeholder = @"Неверный формат";
                    field.attributedPlaceholder = [[NSAttributedString alloc]   initWithString:@"Неверный формат!"
                                                                                    attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
                    self.isCorrect = NO;
                    
                } else if ([field.text length] == 0) {
                    
                    field.attributedPlaceholder = [[NSAttributedString alloc]   initWithString:@"Поле не заполнено!"
                                                                                    attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
                    self.isCorrect = NO;
                }
                break;
            case 4:
                if ([field.text length] == 0 || [field.text length] < 19) {
                    
                    field.text = @"";
                    
                    field.attributedPlaceholder = [[NSAttributedString alloc]   initWithString:@"Не коректный номер!"
                                                                                    attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
                    self.isCorrect = NO;
                }
                break;
            case 5:
                if ([field.text length] == 0) {
                    
                    field.attributedPlaceholder = [[NSAttributedString alloc]   initWithString:@"Поле не заполнено!"
                                                                                    attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
                    self.isCorrect = NO;
                }  else if ([field.text length] < 4) {
                    field.attributedPlaceholder = [[NSAttributedString alloc]   initWithString:@"Длина логина не подходит!"
                                                                                    attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
                    self.isCorrect = NO;
                }
                break;
            case 6:
                if ([field.text length] == 0) {
                    
                    field.attributedPlaceholder = [[NSAttributedString alloc]   initWithString:@"Поле не заполнено!"
                                                                                    attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
                    self.isCorrect = NO;
                }
                break;
            case 7:
                 if ([field.text length] == 0) {
                    
                     
                    field.attributedPlaceholder = [[NSAttributedString alloc]   initWithString:@"Поле не заполнено!"
                                                                                    attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
                    self.isCorrect = NO;
                 } else if ([field.text length] > 0 && [field.text length] < 4) {
                     
                     field.text = @"";
                     field.attributedPlaceholder = [[NSAttributedString alloc]   initWithString:@"Логин меньше четырех символов!"
                                                                                     attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
                     self.isCorrect = NO;
                 }
                break;
            case 8:
                if ([field.text length] > 0 && [field.text length] < 6) {
                    field.text = @"";
                    field.attributedPlaceholder = [[NSAttributedString alloc]   initWithString:@"Пароль меньше шести символов!"
                                                                                    attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
                    self.isCorrect = NO;
                    
                } else if ([field.text length] == 0) {
                    
                    field.attributedPlaceholder = [[NSAttributedString alloc]   initWithString:@"Поле не заполнено!"
                                                                                    attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
                    self.isCorrect = NO;
                    
                }
                break;
                
    }
}

- (BOOL)validate {
    
    return self.isCorrect;
    
}


@end
