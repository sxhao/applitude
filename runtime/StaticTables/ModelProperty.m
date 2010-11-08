#import "ModelProperty.h"


@implementation ModelProperty

- (id) initWithObject:(NSObject *) obj property:(NSString *) propertyName {
	self = [super init];
	if (self != nil) {
		fObject = [obj retain];
		fPropertyName = [propertyName retain];
	}
	return self;
}

+ (id) propertyForObject:(NSObject *) object property:(NSString *) propertyName {
	return [[[ModelProperty alloc] initWithObject:object property:propertyName] autorelease];
}

- (void) bindTo:(NSObject *) object property:(NSString *) property {
	[self unbind];
	fBoundToObject = object;
	fBoundToProperty = property;
	[fBoundToObject retain];
	[fBoundToProperty retain];
	NSLog(@"%@.%@ -bind-> %@.%@", fObject, fPropertyName, fBoundToObject, fBoundToProperty);
	[fBoundToObject addObserver:self forKeyPath:fBoundToProperty options:NSKeyValueObservingOptionNew context:NULL];
}

- (void) setValue:(NSObject *) newValue {
	[fObject setValue:newValue forKey:fPropertyName];
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	NSObject *newValue = [change valueForKey:NSKeyValueChangeNewKey];
	NSLog(@"==> %@.%@ setValue: %@", fObject, fPropertyName, newValue);
	[fObject setValue:newValue forKey:fPropertyName];
}

- (void) unbind {
	if (fBoundToObject) {
		[fBoundToObject removeObserver:self forKeyPath:fBoundToProperty];
		[fBoundToObject release];
		[fBoundToProperty release];
		fBoundToObject = nil;
		fBoundToProperty = nil;
	}
}

- (void) dealloc {
	[self unbind];
	[fObject release];
	[fPropertyName release];
	[super dealloc];
}


@end
