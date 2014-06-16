//
//  LoginViewController.m
//  week2-homework
//
//  Created by Lei Bao on 6/11/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import "LoginViewController.h"
#import "ListViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputID;
@property (weak, nonatomic) IBOutlet UITextField *inputPassword;
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UIView *loginBlock;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;
@property (weak, nonatomic) IBOutlet UIButton *btnSignin;



- (IBAction)btnRegister:(id)sender;
- (IBAction)btnSignIn:(id)sender;
- (IBAction)onTap:(id)sender;
- (IBAction)onIDEditingChange:(id)sender;
- (IBAction)onPasswordEditingChange:(id)sender;

- (void)checkResponse;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;

- (void)willShowKeyboard:(NSNotification *)notification;
- (void)willHideKeyboard:(NSNotification *)notification;

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyboard:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.btnRegister.layer.cornerRadius = 15;
    
    self.btnSignin.layer.cornerRadius = 15;
    self.btnSignin.enabled = NO;
    self.btnSignin.alpha = 0.3;
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)checkResponse
{
    if ([self.inputID.text isEqualToString:@"lei"]&[self.inputPassword.text isEqualToString:@"password"]) {
        NSLog(@"success");
        // load list view
        
        
        
        //UIViewController *listViewController = [[ListViewController alloc] init];
        
        //listViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        
        //[self presentViewController:listViewController animated:YES completion:nil];

        //load nav bar on listview
        ListViewController *feedNavVC = [[ListViewController alloc] init];
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:feedNavVC];
        
       // UITabBarController *tabBarController = [[UITabBarController alloc] initWithNibName:@"tabBarController" bundle:nil];
        
       // tabBarController.tabBar.frame = CGRectMake(0, 524, 320, 320);
        
       // tabBarController.tabBar.backgroundImage = [UIImage imageNamed:@"TabBar"];
        
      //  tabBarController.viewControllers = @[nav];
        
               
        [self presentViewController:nav animated:YES completion: nil];
        
        
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Wrong login info" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [alertView show];
    }
}

- (IBAction)btnRegister:(id)sender {
}

- (IBAction)btnSignIn:(id)sender {
    [self.view endEditing:YES];
    [self.loadingView startAnimating];
    
    [self performSelector:@selector(checkResponse) withObject:nil afterDelay:2];
    
    
    

}

- (IBAction)onTap:(id)sender {
        [self.view endEditing:YES];
}


- (IBAction)onIDEditingChange:(id)sender {
    if ([self.inputID.text isEqualToString:@""])
    {
        self.btnSignin.enabled = NO;
        self.btnSignin.alpha = 0.3;
    }else {
        self.btnSignin.enabled = YES;
        self.btnSignin.alpha = 1;}
}

- (IBAction)onPasswordEditingChange:(id)sender {
    if ([self.inputPassword.text isEqualToString:@""])
    { self.btnSignin.alpha = 0.3;} else { self.btnSignin.alpha = 1;}

}

- (void)willShowKeyboard:(NSNotification *)notification {

    
    NSDictionary *userInfo = [notification userInfo];
    

    
    // Get the keyboard height and width from the notification
    // Size varies depending on OS, language, orientation
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    NSLog(@"Height: %f Width: %f", kbSize.height, kbSize.width);
    NSLog(@"loginblock y: %f", self.loginBlock.frame.origin.y);
    NSLog(@"ID field y: %f", self.inputID.frame.origin.y);
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         //self.loginBlock.frame = CGRectMake(0, self.view.frame.size.height - kbSize.height - self.loginBlock.frame.size.height, self.loginBlock.frame.size.width, self.loginBlock.frame.size.height);
                         //self.logo.frame = CGRectMake(0, self.view.frame.size.height - kbSize.height - self.logo.frame.size.height, self.logo.frame.size.width, self.logo.frame.size.height);
                         self.loginBlock.frame = CGRectMake(0, self.loginBlock.frame.origin.y - kbSize.height + 150, self.loginBlock.frame.size.width, self.loginBlock.frame.size.height);
                         self.logo.frame = CGRectMake(0, self.logo.frame.origin.y - kbSize.height + 150, self.logo.frame.size.width, self.logo.frame.size.height);
                         
                             NSLog(@"loginblock y2: %f", self.loginBlock.frame.origin.y);
                     }
                     completion:nil];
}

- (void)willHideKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         //self.loginBlock.frame = CGRectMake(0, self.view.frame.size.height - self.loginBlock.frame.size.height, self.loginBlock.frame.size.width, self.loginBlock.frame.size.height);
                         //self.logo.frame = CGRectMake(0, self.view.frame.size.height - self.logo.frame.size.height, self.logo.frame.size.width, self.logo.frame.size.height);
                         self.loginBlock.frame = CGRectMake(0, self.loginBlock.frame.origin.y + kbSize.height - 150, self.loginBlock.frame.size.width, self.loginBlock.frame.size.height);
                         self.logo.frame = CGRectMake(0, self.logo.frame.origin.y + kbSize.height - 150, self.logo.frame.size.width, self.logo.frame.size.height);
                         
                     }
                     completion:nil];
}


@end
