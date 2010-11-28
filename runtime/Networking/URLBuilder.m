// © 2010 Ralf Ebert
// Made available under Simplified BSD License, http://www.opensource.org/licenses/bsd-license.php

#import "URLBuilder.h"

@implementation URLBuilder

- (id) initWithString:(NSString*)url {
	self = [super init];
	if (self != nil) {
		fUrl = [[NSMutableString alloc] initWithString:url];
		fFirstParam = YES;
	}
	return self;
}

+ (id) urlWithString:(NSString*)url {
	return [[[URLBuilder alloc] initWithString:url] autorelease];
}

- (void) value:(NSString *)value forParameter:(NSString *)parameter {
	[fUrl appendString:(fFirstParam ? @"?" : @"&")];
	[fUrl appendFormat:@"%@=%@", parameter, [URLUtils encodeURLParameter:value]];
	fFirstParam = NO;
}

- (NSURL *) url {
	return [NSURL URLWithString:fUrl];
}

- (NSString *) description {
	return [NSString stringWithFormat:@"URL[%@]", fUrl];
}

- (void) dealloc {
	[fUrl release];
	[super dealloc];
}

@end
