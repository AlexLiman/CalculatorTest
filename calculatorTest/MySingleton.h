//
//  MySingleton.h
//  calculatorTest
//
//  Created by Admin on 8/4/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
@interface MySingleton : NSObject  
{
    NSString *example;
}
@property (nonatomic, retain) NSString *example;
@property (assign, nonatomic) NetworkStatus netStatus;
@property (strong, nonatomic) Reachability  *hostReach;


+(MySingleton *)sharedMySingleton;

- (void)updateInterfaceWithReachability: (Reachability*) curReach;
@end