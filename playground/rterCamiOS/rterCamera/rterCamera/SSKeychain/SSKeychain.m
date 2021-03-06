//
//  SSKeychain.m
//  SSKeychain
//
//  Created by Sam Soffes on 5/19/10.
//  Copyright (c) 2010-2013 Sam Soffes. All rights reserved.
//

#import "SSKeychain.h"

NSString *const kSSKeychainErrorDomain = @"com.samsoffes.sskeychain";
NSString *const kSSKeychainAccountKey = @"acct";
NSString *const kSSKeychainCreatedAtKey = @"cdat";
NSString *const kSSKeychainClassKey = @"labl";
NSString *const kSSKeychainDescriptionKey = @"desc";
NSString *const kSSKeychainLabelKey = @"labl";
NSString *const kSSKeychainLastModifiedKey = @"mdat";
NSString *const kSSKeychainWhereKey = @"svce";

#if __IPHONE_4_0 && TARGET_OS_IPHONE
    CFTypeRef SSKeychainAccessibilityType = NULL;
#endif

@implementation SSKeychain

+ (NSString *)passwordForService:(NSString *)serviceName account:(NSString *)account {
    SSKeychainQuery *query = [[SSKeychainQuery alloc] init];
    query.service = serviceName;
    query.account = account;
    [query fetch:nil];
    return query.password;
}


+ (BOOL)deletePasswordForService:(NSString *)serviceName account:(NSString *)account {
    SSKeychainQuery *query = [[SSKeychainQuery alloc] init];
    query.service = serviceName;
    query.account = account;
    return [query delete:nil];
}


+ (BOOL)setPassword:(NSString *)password forService:(NSString *)serviceName account:(NSString *)account {
    SSKeychainQuery *query = [[SSKeychainQuery alloc] init];
    query.service = serviceName;
    query.account = account;
    query.password = password;
    return [query save:nil];
}


+ (NSArray *)allAccounts {
    return [self accountsForService:nil];
}


+ (NSArray *)accountsForService:(NSString *)serviceName {
    SSKeychainQuery *query = [[SSKeychainQuery alloc] init];
    query.service = serviceName;
    return [query fetchAll:nil];
}


#if __IPHONE_4_0 && TARGET_OS_IPHONE
+ (CFTypeRef)accessibilityType {
	return SSKeychainAccessibilityType;
}


+ (void)setAccessibilityType:(CFTypeRef)accessibilityType {
	CFRetain(accessibilityType);
	if (SSKeychainAccessibilityType) {
		CFRelease(SSKeychainAccessibilityType);
	}
	SSKeychainAccessibilityType = accessibilityType;
}
#endif

@end
