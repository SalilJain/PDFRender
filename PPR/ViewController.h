//
//  ViewController.h


#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIWebViewDelegate>
{
    IBOutlet UIWebView * pdfView;
}

-(IBAction)createPDF:(id)sender;
@end
