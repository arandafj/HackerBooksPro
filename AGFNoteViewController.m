//
//  AGFNoteViewController.m
//  HackerBooksPro
//

#import "AGFNoteViewController.h"
#import "AGFLocationViewController.h"
#import "AGFPhotoViewController.h"
#import "AGFBook.h"
#import "AGFAnnotation.h"
#import "AGFImage.h"
#import "AGFSnap.h"
#import "AGFLocation.h"

@interface AGFNoteViewController ()<UITextFieldDelegate, UITextViewDelegate>
@property (nonatomic, strong) AGFAnnotation *model;
@property (nonatomic) BOOL new;
@property (nonatomic) BOOL deleteNote;
@end

@implementation AGFNoteViewController

#pragma mark - Init
-(id) initWithModel:(id) model{
    
    if (self = [super initWithNibName:nil bundle:nil]) {
        _model = model;
    }
    return self;
}
-(id) initForNewAnnotationInBook: (AGFBook *) book{
    
    AGFAnnotation *annotation = [AGFAnnotation annotationWithTitle:@""
                                                              book:book
                                                           context:book.managedObjectContext];
    
    _new = YES;
    return [self initWithModel:annotation];
}

#pragma mark - View Lifecycle
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // Sincronizar vista
    NSDateFormatter *fmt = [NSDateFormatter new];
    fmt.dateStyle = NSDateFormatterLongStyle;
    
    self.creationDate.text = [fmt stringFromDate:self.model.creationDate];
    
    self.titleView.text = self.model.title;
    self.text.text = self.model.text;
    
    UIImage *img = self.model.image.img;
    if (!img) {
        img = [UIImage imageNamed:@"noImage.png"];
    }
    
    self.image.image = img;
    
    // Snapshot
    img = self.model.location.snap.image;
    self.mapSnapshot.userInteractionEnabled = YES;
    if (!img) {
        img = [UIImage imageNamed:@"noSnapshot.png"];
        self.mapSnapshot.userInteractionEnabled = NO;
    }
    self.mapSnapshot.image = img;
    
    // Observación del snapshot
    [self startObservingSnapshot];
    
    [self startObservingKeyboard];
    
    [self setupInputAccessoryView];
    
    if (self.new) {
        // Add the cancel button
        UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                target:self
                                                                                action:@selector(cancel:)];
        self.navigationItem.rightBarButtonItem = cancel;
    }
    
    // Delegados
    self.titleView.delegate = self;
    self.text.delegate = self;
    
    
    // Añadimos un gesture recognizer a la foto
    self.image.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(displayDetailPhoto:)];
    [self.image addGestureRecognizer:tap];
    
    
    // Gesture recog para vista de location
    UITapGestureRecognizer *snapTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(displayDetailLocation:)];
    [self.mapSnapshot addGestureRecognizer:snapTap];
    
    
    // Botón de compartir
    UIBarButtonItem *share = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(displayActions:)];
    self.navigationItem.rightBarButtonItem = share;
    
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    if (self.deleteNote) {
        [self.model.managedObjectContext deleteObject:self.model];
    }else{
        // Sincronizar Modelo
        self.model.text = self.text.text;
        self.model.title = self.titleView.text;
        self.model.image.img = self.image.image;
    }
    
    
    [self stopObservingKeyboard];
    [self stopObservingSnapshot];
}

#pragma mark -  TextView
-(void) setupInputAccessoryView{
    
    UIToolbar *textBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, self.text.frame.size.width, 44)];
    
    UIToolbar *nameBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, self.text.frame.size.width, 44)];
    
    // Buttons
    UIBarButtonItem *sep = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *done = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(hideKeyboard:)];
    
    UIBarButtonItem *done2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(hideKeyboard:)];
    
    [textBar setItems: @[sep, done]];
    [nameBar setItems:@[sep, done2]];
    
    self.text.inputAccessoryView = textBar;
    self.titleView.inputAccessoryView = nameBar;
}

-(void)hideKeyboard:(id) sender{
    [self.view endEditing:YES];
}

#pragma mark - Keyboard
-(void) startObservingKeyboard{
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self
           selector:@selector(notifyThatKeyboardWillAppear:)
               name:UIKeyboardWillShowNotification
             object:nil];
    
    [nc addObserver:self
           selector:@selector(notifyThatKeyboardWillDissappear:)
               name:UIKeyboardWillHideNotification
             object:nil];
}

-(void) stopObservingKeyboard{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}

// UIKeyboardWillShowNotification
-(void) notifyThatKeyboardWillAppear:(NSNotification *) notification{
    
    if ([self.text isFirstResponder]) {
        // UserInfo
        NSDictionary *dict = notification.userInfo;
        
        
        double duration = [[dict objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        
        [UIView animateWithDuration:duration
                              delay:0
                            options:0
                         animations:^{
                             
                             self.text.frame = CGRectMake(self.creationDate.frame.origin.x, self.creationDate.frame.origin.y, self.view.frame.size.width, self.text.frame.size.height);
                         } completion:nil];
        
        [UIView animateWithDuration:duration
                              delay:0
                            options:0
                         animations:^{
                             
                             self.text.alpha = 0.8;
                         } completion:nil];
        
    }
    
}

// UIKeyboardWillShowNotification
-(void) notifyThatKeyboardWillDissappear:(NSNotification *) notification{
    
    if ([self.text isFirstResponder]) {
        // UserInfo
        NSDictionary *dict = notification.userInfo;
        
        
        double duration = [[dict objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        
        [UIView animateWithDuration:duration
                              delay:0
                            options:0
                         animations:^{
                             
                             self.text.frame = CGRectMake(0, 323, self.view.frame.size.width, self.text.frame.size.height);
                         } completion:nil];
        
        [UIView animateWithDuration:duration
                              delay:0
                            options:0
                         animations:^{
                             
                             self.text.alpha = 1;
                         } completion:nil];
    }
    
}

#pragma mark - Utils
-(void) cancel:(id)sender{
    self.deleteNote = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    // Podríamos comprobar el texto
    [textField resignFirstResponder];
    return YES;
}


-(void) textFieldDidEndEditing:(UITextField *)textField{
    // Guardamos
    self.model.title = self.titleView.text;
}

#pragma mark - UITextViewDelegate
-(void) textViewDidEndEditing:(UITextView *)textView{
    
    // Guardamos
    self.model.text = textView.text;
}

#pragma mark - Actions
-(void)displayDetailLocation:(id) sender{
    
    AGFLocationViewController *locVC  = [[AGFLocationViewController alloc] initWithLocation:self.model.location];
    
    [self.navigationController pushViewController:locVC
                                         animated:YES];
}


-(void)displayDetailPhoto:(id) sender{
    
    
    if (self.model.image == nil) {
        self.model.image = [AGFImage annotationPhotoWithImage:nil
                                                                context:self.model.managedObjectContext];
    }
    AGFPhotoViewController *pVC = [[AGFPhotoViewController alloc] initWithModel:self.model.image];
    
    [self.navigationController pushViewController:pVC
                                         animated:YES];
    
    
}

-(void) displayActions:(id) sender{
    
    UIActivityViewController *aVC = [[UIActivityViewController alloc] initWithActivityItems:[self arrayOfNoteItems] applicationActivities:nil];
    
    [self presentViewController:aVC
                       animated:YES
                     completion:nil];
}

-(NSArray *) arrayOfNoteItems{
    
    NSMutableArray *items = [NSMutableArray array];
    if (self.model.title) {
        [items addObject:self.model.title];
    }
    if (self.model.text) {
        [items addObject:self.model.text];
    }
    if (self.model.image.img) {
        [items addObject:self.model.image.img];
    }
    
    return items;
    
}


#pragma mark -  KVO
-(void) startObservingSnapshot{
    
    [self.model addObserver:self
                    forKeyPath:@"location.snap.snapshotData"
                    options:NSKeyValueObservingOptionNew
                    context:NULL];
    
}

-(void) stopObservingSnapshot{
    [self.model removeObserver:self
                    forKeyPath:@"location.snap.snapshotData"];
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context{
    
    UIImage *img = self.model.location.snap.image;
    self.mapSnapshot.userInteractionEnabled = YES;
    if (!img) {
        img = [UIImage imageNamed:@"noSnapshot.png"];
        self.mapSnapshot.userInteractionEnabled = NO;
    }
    self.mapSnapshot.image = img;
    
}
@end
