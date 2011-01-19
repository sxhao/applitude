// © 2010 Ralf Ebert
// Made available under Eclipse Public License v1.0, http://www.eclipse.org/legal/epl-v10.html

#import <Foundation/Foundation.h>

#import "StaticSection.h"
#import "Placeholder.h"
#import "TextFieldCell.h"
#import "BoxCell.h"

@interface TableBuilder : NSObject {

	StaticSection *lastSection;
	NSMutableArray *fSections;

}

@property (readonly, nonatomic) NSArray *sections;

+ (TableBuilder *) builder;

- (void) section:(NSString *) text;
- (void) section;
- (void) sections:(NSObject<Placeholder> *)placeholder;

- (void) cell:(id)cell;
- (void) cells:(NSObject<Placeholder> *)placeholder;

- (BoxCell *) text:(NSString *) text;
- (BoxCell *) link:(NSString *) text;
- (TextFieldCell *) textFieldWithLabel:(NSString *) label;

@end