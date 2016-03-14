//
//  MyLogInViewController.m
//  LogInAndSignUpDemo
//
//  Created by Mattieu Gamache-Asselin on 6/15/12.
//  Copyright (c) 2013 Parse. All rights reserved.
//

#import "MyLogInViewController.h"
#import "CMVLogInFieldsBG.h"
#import <QuartzCore/QuartzCore.h>
#import "CMVDiciottoPiu.h"
#import "CMVDiciottoPiu.h"
#import <ParseUI/PFTextField.h>


@interface MyLogInViewController ()
@property (nonatomic, strong) UIImageView *fieldsBackground;
@property(strong,nonatomic)UIImageView *line;
@property(strong,nonatomic)UIImageView *line2;
@property(strong,nonatomic)UILabel *divietoiPAD;
@property(strong, nonatomic)CMVLogInFieldsBG *myBG;
@property(strong,nonatomic)UIImageView *myBackgroundView;
@property(strong, nonatomic)CMVLogInFieldsBG *fieldsBG;
@end

@implementation MyLogInViewController

@synthesize fieldsBackground;

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"LogInImage.png"]];
 
        [self.logInView.passwordForgottenButton setBackgroundImage:nil forState:UIControlStateNormal];
        [self.logInView.passwordForgottenButton setBackgroundImage:nil forState:UIControlStateHighlighted];
        [self.logInView.passwordForgottenButton setTitle:NSLocalizedString(@"FORGOT?", nil) forState:UIControlStateNormal];
        self.logInView.passwordForgottenButton.titleLabel.minimumScaleFactor=0.5;
        self.logInView.passwordForgottenButton.titleLabel.adjustsFontSizeToFitWidth=YES;
        [self.logInView.passwordForgottenButton.titleLabel setFont:GOTHAM_Medium(10)];
        
        // Set buttons appearance
        [self.logInView.dismissButton setImage:[UIImage imageNamed:@"CloseButtonRaster.png"] forState:UIControlStateNormal];
        [self.logInView.dismissButton setImage:[UIImage imageNamed:@"CloseButtonRaster.png"] forState:UIControlStateHighlighted];
      
        if (iPHONE) {
            UILabel *diciotto =[[UILabel alloc] init];
            diciotto.text= @"18+";
            diciotto.textColor = [UIColor whiteColor];
            diciotto.frame=CGRectMake(30, 26, 30, 21);
            [self.view addSubview:diciotto];
            CMVDiciottoPiu *divieto =[[CMVDiciottoPiu alloc] init];
            [self.view addSubview:divieto];
        }

        [self.logInView.logInButton setBackgroundImage:nil forState:UIControlStateNormal];
        [self.logInView.logInButton setBackgroundImage:nil forState:UIControlStateHighlighted];
        [self.logInView.signUpButton setBackgroundImage:nil forState:UIControlStateNormal];
        [self.logInView.signUpButton setBackgroundImage:nil forState:UIControlStateHighlighted];
        
        
        self.fieldsBG = [[CMVLogInFieldsBG alloc] init];
        self.fieldsBG.backgroundColor = [UIColor clearColor];
        self.fieldsBG.alpha = 0.3f;
        [self.logInView addSubview:self.fieldsBG];
        [self.logInView sendSubviewToBack:self.fieldsBG];
        
        UIImageView *ombraBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Ombra.png"]];
        [self.view addSubview:ombraBackground];
        [self.view sendSubviewToBack:ombraBackground];
        self.line =ombraBackground;
        
        UIImageView *ombraBackground2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Ombra.png"]];
        self.line2 =ombraBackground2;
        [self.view addSubview:ombraBackground2];
        [self.view sendSubviewToBack:ombraBackground2];

        
        [self.logInView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CasinoLabel.png"]]];
      


}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
     [self.logInView.usernameField setValue:[NSNumber numberWithInt:0] forKey:@"separatorStyle"];
    [self.logInView.passwordField setValue:[NSNumber numberWithInt:0] forKey:@"separatorStyle"];
    self.logInView.usernameField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"USERNAME", nil) attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    self.logInView.passwordField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"PASSWORD", nil) attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [self.logInView.logInButton setBackgroundImage:[UIImage imageNamed:@"SignUpLogInBK.png"] forState:UIControlStateNormal];
    [self.logInView.signUpButton setBackgroundImage:[UIImage imageNamed:@"SignUpLogInBK.png"] forState:UIControlStateNormal];
    self.logInView.usernameField.textColor =[UIColor whiteColor];
    self.logInView.usernameField.backgroundColor = [UIColor clearColor];
    self.logInView.passwordField.backgroundColor = [UIColor clearColor];
    self.logInView.passwordField.textColor =[UIColor whiteColor];

        self.logInView.dismissButton.frame = CGRectMake(5, 25, 25, 25);
        UIImage *myGradient = [UIImage imageNamed:@"LogInColorPattern"];
        [self.logInView.logInButton setTitleColor:[UIColor colorWithPatternImage:myGradient] forState:UIControlStateNormal];
        [self.logInView.signUpButton setTitleColor:[UIColor colorWithPatternImage:myGradient] forState:UIControlStateNormal];
        self.logInView.logInButton.titleLabel.font = GOTHAM_XLight(20);
        self.logInView.signUpButton.titleLabel.font = GOTHAM_XLight(20);
        
        [self.logInView.usernameField setFrame:CGRectMake(self.view.center.x-250/2, 155.0f, 250.0f, 50.0f)];
        self.logInView.usernameField.font = GOTHAM_BOOK(14);
        
        [self.logInView.passwordField setFrame:CGRectMake(self.view.center.x-250/2, 196.0f, 250.0f, 50.0f)];
        self.logInView.passwordField.font = GOTHAM_BOOK(14);
        
        [self.logInView.logInButton setFrame:CGRectMake(self.view.center.x-250/2, 250.0f, 250.0f, 40.0f)];
        self.logInView.logInButton.layer.cornerRadius = 2;
        [self.fieldsBackground setFrame:CGRectMake(self.view.center.x-250/2, 145.0f, 250.0f, 100.0f)];
       self.fieldsBG.frame = CGRectMake(self.view.center.x-250/2, 160, 250, 80);
        self.line.frame = CGRectMake(self.view.center.x-300/2, 135, 300, 4);
         self.line2.frame = CGRectMake(self.view.center.x-300/2, 300, 300, 4);

        
        [self.logInView.passwordForgottenButton setFrame:CGRectMake(self.view.center.x-160/2, 300.0f, 160.0f, 20.0f)];
     
        if (self.logInView.bounds.size.height > 480.0f) {
            self.line2.frame = CGRectOffset(self.line2.frame, 0, 30);
            [self.logInView.logo setFrame:CGRectMake(self.view.center.x-270/2, 85.0f, 270.0f, 28.0f)];
            [self.logInView.facebookButton setFrame:CGRectMake(self.view.center.x-125, 383.0f, 120.0f, 40.0f)];
            [self.logInView.twitterButton setFrame:CGRectMake(self.view.center.x-125+130.0f, 383.0f, 120.0f, 40.0f)];
            [self.logInView.signUpButton setFrame:CGRectMake(self.view.center.x-250/2, 475.0f, 250.0f, 40.0f)];

          
        } else {

            [self.logInView.logo setFrame:CGRectMake(self.view.center.x-270/2, 85.0f, 270.0f, 28.0f)];
            [self.logInView.facebookButton setFrame:CGRectMake(self.view.center.x-125, 330.0f, 120.0f, 40.0f)];
            [self.logInView.twitterButton setFrame:CGRectMake(self.view.center.x-125+130.0f, 330.0f, 120.0f, 40.0f)];
            [self.logInView.signUpButton setFrame:CGRectMake(self.view.center.x-250/2, 420.0f, 250.0f, 40.0f)];

            
        }

    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



@end
