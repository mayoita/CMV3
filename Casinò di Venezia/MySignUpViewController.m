//
//  MySignUpViewController.m
//  LogInAndSignUpDemo
//
//  Created by Mattieu Gamache-Asselin on 6/15/12.
//  Copyright (c) 2013 Parse. All rights reserved.
//

#import "MySignUpViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "CMVLogInFieldsBGThree.h"
#import "CMVDiciottoPiu.h"
#import <ParseUI/PFTextField.h>


@interface MySignUpViewController ()
@property (nonatomic, strong) UIImageView *fieldsBackground;
@property(strong,nonatomic)UIImageView *line;
@property(strong,nonatomic)UIImageView *line2;
@property(strong,nonatomic)UILabel *divietoiPAD;
@property(strong, nonatomic)CMVLogInFieldsBGThree *myBG;
@end

@implementation MySignUpViewController

@synthesize fieldsBackground;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (iPHONE ) {
        UILabel *diciotto =[[UILabel alloc] init];
        diciotto.text= @"18+";
        diciotto.textColor = [UIColor whiteColor];
        diciotto.frame=CGRectMake(30, 26, 30, 21);
        [self.view addSubview:diciotto];
        
        CMVDiciottoPiu *divieto =[[CMVDiciottoPiu alloc] init];
        [self.view addSubview:divieto];
    }
    
        [self.signUpView.signUpButton setBackgroundImage:nil forState:UIControlStateNormal];
        [self.signUpView.signUpButton setBackgroundImage:nil forState:UIControlStateHighlighted];
        [self.signUpView.dismissButton setImage:[UIImage imageNamed:@"CloseButtonRaster.png"] forState:UIControlStateNormal];
        [self.signUpView.dismissButton setImage:[UIImage imageNamed:@"CloseButtonRaster.png"] forState:UIControlStateHighlighted];
        
        UIImage *myGradient = [UIImage imageNamed:@"LogInColorPattern"];
        [self.signUpView.signUpButton setTitleColor:[UIColor colorWithPatternImage:myGradient] forState:UIControlStateNormal];
        
        CMVLogInFieldsBGThree *fieldsBG = [[CMVLogInFieldsBGThree alloc] init];
        fieldsBG.backgroundColor = [UIColor clearColor];
        fieldsBG.alpha = 0.3f;
        
        self.myBG = fieldsBG;
        [self.signUpView addSubview:fieldsBG];
        [self.signUpView sendSubviewToBack:fieldsBG];
        
        UIImageView *ombraBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Ombra.png"]];
        self.line =ombraBackground;
        [self.view addSubview:ombraBackground];
        [self.view sendSubviewToBack:ombraBackground];
        
        UIImageView *ombraBackground2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Ombra.png"]];
        self.line2 =ombraBackground2;
        [self.view addSubview:ombraBackground2];
        [self.view sendSubviewToBack:ombraBackground2];
        
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"LogInImage.png"]];
        [self.signUpView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CasinoLabel.png"]]];


}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.signUpView.usernameField setValue:[NSNumber numberWithInt:0] forKey:@"separatorStyle"];
    [self.signUpView.passwordField setValue:[NSNumber numberWithInt:0] forKey:@"separatorStyle"];
    [self.signUpView.emailField setValue:[NSNumber numberWithInt:0] forKey:@"separatorStyle"];
    
    [self.signUpView.signUpButton setBackgroundImage:[UIImage imageNamed:@"SignUpLogInBK.png"] forState:UIControlStateNormal];
 
       self.signUpView.signUpButton.titleLabel.font = GOTHAM_XLight(20);
        self.signUpView.dismissButton.frame = CGRectMake(5, 25, 25, 25);
        [self.signUpView.usernameField setFrame:CGRectMake(self.view.center.x-250/2, 155.0f, 250.0f, 50.0f)];
        self.signUpView.usernameField.font = GOTHAM_BOOK(12);
        self.signUpView.usernameField.textColor =[UIColor whiteColor];
        self.signUpView.usernameField.backgroundColor = [UIColor clearColor];
       
        self.signUpView.usernameField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"USERNAME", nil) attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
        [self.signUpView.passwordField setFrame:CGRectMake(self.view.center.x-250/2, 196.0f, 250.0f, 50.0f)];
        self.signUpView.passwordField.font = GOTHAM_BOOK(12);
        self.signUpView.passwordField.textColor =[UIColor whiteColor];
        self.signUpView.passwordField.backgroundColor = [UIColor clearColor];
      
        self.signUpView.passwordField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"PASSWORD", nil) attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
        [self.signUpView.emailField setFrame:CGRectMake(self.view.center.x-250/2, 236.0f, 250.0f, 50.0f)];
        self.signUpView.emailField.font = GOTHAM_BOOK(12);
        self.signUpView.emailField.textColor =[UIColor whiteColor];
        self.signUpView.emailField.backgroundColor = [UIColor clearColor];
        self.signUpView.emailField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"EMAIL", nil) attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
       
        [self.fieldsBackground setFrame:CGRectMake(self.view.center.x-250/2, 145.0f, 250.0f, 100.0f)];
        self.myBG.frame = CGRectMake(self.view.center.x-250/2, 160, 250, 118);
        self.line.frame = CGRectMake(self.view.center.x-300/2, 135, 300, 4);
        self.line2.frame = CGRectMake(self.view.center.x-300/2, 300, 300, 4);
        
    

        
        if (self.signUpView.bounds.size.height > 480.0f) {
    
            [self.signUpView.logo setFrame:CGRectMake(self.view.center.x-270/2, 85.0f, 270.0f, 28.0f)];
           
            [self.signUpView.signUpButton setFrame:CGRectMake(self.view.center.x-250/2, 475.0f, 250.0f, 40.0f)];
        
        
        } else {
            
            self.signUpView.signUpButton.titleLabel.font = GOTHAM_XLight(35);
   
            [self.signUpView.logo setFrame:CGRectMake(self.view.center.x-270/2, 85.0f, 270.0f, 28.0f)];
        }



}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
