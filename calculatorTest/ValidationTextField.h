//
//  Validation.h
//  calculatorTest
//
//  Created by Admin on 8/6/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ValidationTextField : NSObject
@property (assign, nonatomic) BOOL isCorrect;
- (void)regExp:(UITextField *)field;
- (BOOL)validate;


@end
