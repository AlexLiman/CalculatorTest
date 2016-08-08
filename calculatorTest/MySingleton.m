//
//  MySingleton.m
//  calculatorTest
//
//  Created by Admin on 8/4/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "MySingleton.h"


@implementation MySingleton

@synthesize example;

//+ (MySingleton *)sharedMySingleton {
//    
//    if (!sharedMySingleton || sharedMySingleton == NULL) {
//        sharedMySingleton = [MySingleton new];
//    }
//    
//    return sharedMySingleton;
//}

+(MySingleton *)sharedMySingleton {
    
    static dispatch_once_t once;
    static MySingleton *sharedSingleton;
    dispatch_once(&once, ^{
        sharedSingleton = [[self alloc] init];
    });
    return sharedSingleton;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reachabilityChanged:)
                                                     name:kReachabilityChangedNotification
                                                   object:nil];
        self.hostReach = [Reachability reachabilityWithHostName:@"www.apple.com"];
        [self.hostReach startNotifier];
        [self updateInterfaceWithReachability: self.hostReach];
        if (self.netStatus == 0) {
            NSLog(@"%@", @"NotReachable");
        } else if(self.netStatus == 1) {
            NSLog(@"%@", @"ReachableViaWiFi");
        } else if(self.netStatus == 2) {
            NSLog(@"%@", @"ReachableViaWWAN");
        }
        
    
    }
    return self;
}



- (void)dealloc {
    self.example = nil;
}

#pragma mark - NetWork

- (void) updateInterfaceWithReachability: (Reachability*) curReach {
    self.netStatus = [curReach currentReachabilityStatus];
}

- (void) reachabilityChanged: (NSNotification* )note {
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    [self updateInterfaceWithReachability: curReach];
}

@end