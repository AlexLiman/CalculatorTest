//
//  ViewControllerIndicator.m
//  calculatorTest
//
//  Created by Admin on 8/5/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ViewControllerIndicator.h"
#import "ViewController.h"
@interface ViewControllerIndicator ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@end

@implementation ViewControllerIndicator

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self performSelector:@selector(mymethod) withObject:nil afterDelay:3.5f];
}

- (void)mymethod {
    ViewController *add = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewControllerStoryboard"];
    [self presentViewController:add animated:YES completion:nil];
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

@end
