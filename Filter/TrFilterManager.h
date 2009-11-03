#import <Cocoa/Cocoa.h>

@interface TrFilterManager : NSObject {
    IBOutlet NSView  *m_documentView;
    IBOutlet NSScrollView *m_scroller;
    IBOutlet NSView *m_containerView;
    IBOutlet NSWindow *m_window;
    IBOutlet NSTextField *m_description;
    IBOutlet NSPopUpButton *m_qualifier;
    IBOutlet NSButton *m_addrule;
    IBOutlet NSButton *m_cancel;
    IBOutlet NSButton *m_save;
}
- (IBAction)addRule:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;
@end
