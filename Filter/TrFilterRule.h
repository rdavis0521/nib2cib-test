#import <Cocoa/Cocoa.h>

@interface TrFilterRule : NSObject {
    IBOutlet NSView *m_filterView;
    IBOutlet NSButton *m_delete;
    IBOutlet NSPopUpButton *m_rule1;
    IBOutlet NSPopUpButton *m_rule2;
}
- (IBAction)deleteRule:(id)sender;
@end
