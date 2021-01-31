//
//  ViewController.m
//  CounterGame
//
//  Created by CrazyMind90 on 30/01/2021.
//

#import "ViewController.h"
#import "CMManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"Hola");
    
    CurrentScore = 0;
    SelectedSega = 0;
    DidAlloc_InitCurrentScoreLabel = NO;
    DidAlloc = NO;
    
    [self InitBestScore];
    [self InitStart_Button_Image];

}


#pragma GameModes

-(void) GameMode {
    
    NSLog(@"GameMode");
    
    [self CreateMath];
    [self CalculationLabel];
    [self Yes_No_ButtonsView];
    
    StartButton.hidden = YES;
    StartImage.hidden = YES;
    BestScoreLabel.hidden = YES;
    CurrentScoreLabel.hidden = YES;
    SegamentControl.hidden = YES;
    
    YESImage.hidden = NO;
    YESButton.hidden = NO;
    NOImage.hidden = NO;
    NOButton.hidden = NO;
    Math.hidden = NO;
    
}

-(void) HomeMode {
    
    NSLog(@"HomeMode");
    if (!DidAlloc_InitCurrentScoreLabel) {
    [self InitCurrentScoreLabel];
    DidAlloc_InitCurrentScoreLabel = YES;
    }
    
    StartButton.hidden = NO;
    StartImage.hidden = NO;
    BestScoreLabel.hidden = NO;
    CurrentScoreLabel.hidden = NO;
    SegamentControl.hidden = NO;
    CurrentScoreLabel.text = [NSString stringWithFormat:@"Current : %lu",CurrentScore];
    
    BestScoreString = [[NSUserDefaults standardUserDefaults] objectForKey:@"Best"];
    if (!BestScoreString)
    BestScoreString = @"0";
    BestScoreLabel.text = [NSString stringWithFormat:@"Best : %@",BestScoreString];
    CurrentScore = 0;
    YESImage.hidden = YES;
    YESButton.hidden = YES;
    NOImage.hidden = YES;
    NOButton.hidden = YES;
    Math.hidden = YES;
    AnswerResultLabel.hidden = YES;

}

 


#pragma Drawing
-(void) InitBestScore {
    
    BestScoreString = [[NSUserDefaults standardUserDefaults] objectForKey:@"Best"];
    if (!BestScoreString)
    BestScoreString = @"0";
    
    
    BestScoreLabel = [CMManager InitLabelWithName:[NSString stringWithFormat:@"Best : %@",BestScoreString] Frame:CGRectNull InView:self.view];
    
    BestScoreLabel.font = [UIFont boldSystemFontOfSize:30];
    BestScoreLabel.textAlignment = NSTextAlignmentCenter;
    BestScoreLabel.layer.backgroundColor = UIColorFromHEX(0x202020).CGColor;
    BestScoreLabel.layer.cornerRadius = 20;
    BestScoreLabel.textColor = UIColor.whiteColor;

    [BestScoreLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [NSLayoutConstraint activateConstraints:@[
    
    [BestScoreLabel.topAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:-100],
    [BestScoreLabel.leadingAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:-100],
    [BestScoreLabel.trailingAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:100],
    [BestScoreLabel.bottomAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:0],
    
    ]];
}

-(void) InitCurrentScoreLabel {
    

    
    CurrentScoreLabel = [CMManager InitLabelWithName:[NSString stringWithFormat:@"Current : %lu",CurrentScore] Frame:CGRectNull InView:self.view];
    
    CurrentScoreLabel.font = [UIFont boldSystemFontOfSize:30];
    CurrentScoreLabel.textAlignment = NSTextAlignmentCenter;
    CurrentScoreLabel.layer.backgroundColor = UIColorFromHEX(0x202020).CGColor;
    CurrentScoreLabel.layer.cornerRadius = 20;
    CurrentScoreLabel.textColor = UIColor.whiteColor;
    
    [CurrentScoreLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [NSLayoutConstraint activateConstraints:@[
    
    [CurrentScoreLabel.topAnchor constraintEqualToAnchor:BestScoreLabel.topAnchor constant:-105],
    [CurrentScoreLabel.leadingAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:-100],
    [CurrentScoreLabel.trailingAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:100],
    [CurrentScoreLabel.bottomAnchor constraintEqualToAnchor:BestScoreLabel.topAnchor constant:-5],
    
    ]];
    
}



-(void) InitStart_Button_Image {
    
    StartImage = [CMManager InitImage:[UIImage imageNamed:@"Sv"] Frame:CGRectNull InView:self.view];
    
    [StartImage setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [NSLayoutConstraint activateConstraints:@[
    
    [StartImage.topAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-198],
    [StartImage.leadingAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:-80],
    [StartImage.trailingAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:80],
    [StartImage.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-40],
    
    ]];
    
    
    
    StartButton = [CMManager InitButtonWithName:@"" Frame:CGRectNull InView:self.view Target:self Action:@selector(GameMode)];
    
    [StartButton addTarget:self action:@selector(Zoom) forControlEvents:UIControlEventTouchDown];

    [StartButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [NSLayoutConstraint activateConstraints:@[
     
    [StartButton.topAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-198],
    [StartButton.leadingAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:-70],
    [StartButton.trailingAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:70],
    [StartButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-40],
    
    ]];
    
    
    SegamentControl = [[CMManager alloc] InitSegamentWithSections:@[@"+",@"x",@"-"] Action:@selector(SelectedSegament) InView:self.view];
    
    UIFont *Font = [UIFont boldSystemFontOfSize:30.0f];
    
    NSDictionary *Attributes = [NSDictionary dictionaryWithObjects:@[Font,[UIColor whiteColor]] forKeys:@[NSFontAttributeName,NSForegroundColorAttributeName]];
    
    [SegamentControl setTitleTextAttributes:Attributes forState:UIControlStateNormal];
    
    if (@available(iOS 13.0, *))
    [SegamentControl setSelectedSegmentTintColor:UIColorFromHEX(0x606060)];
 
    
    [SegamentControl setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [NSLayoutConstraint activateConstraints:@[
     
    [SegamentControl.topAnchor constraintEqualToAnchor:StartButton.topAnchor constant:-100],
    [SegamentControl.leadingAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:-150],
    [SegamentControl.trailingAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:150],
    [SegamentControl.bottomAnchor constraintEqualToAnchor:StartButton.topAnchor constant:-40],
    
    ]];
}


-(void) SelectedSegament {
    
    switch (SegamentControl.selectedSegmentIndex) {
        case 0:
            SelectedSega = 0;
            break;
            
        case 1:
            SelectedSega = 1;
            break;
            
        case 2:
            SelectedSega = 2;
            break;
            
            
        default:
            break;
    }
}

-(void) CalculationLabel {
    

    Math = [CMManager InitLabelWithName:CalculationResult Frame:CGRectNull InView:self.view];
    
    Math.font = [UIFont boldSystemFontOfSize:70];
    Math.textAlignment = NSTextAlignmentCenter;
    Math.layer.backgroundColor = UIColorFromHEX(0x202020).CGColor;
    Math.layer.cornerRadius = 20;
    Math.textColor = UIColor.whiteColor;
    Math.numberOfLines = 1;
    Math.minimumScaleFactor = 0.01;
    Math.adjustsFontSizeToFitWidth = YES;
    
    [Math setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [NSLayoutConstraint activateConstraints:@[
    
    [Math.topAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:-200],
    [Math.leadingAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:-185],
    [Math.trailingAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:185],
    [Math.bottomAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:0],
    
    ]];
    
}


-(void) AnswerResult {
    
    AnswerResultLabel = [CMManager InitLabelWithName:AnswerResultText Frame:CGRectNull InView:self.view];
    
    AnswerResultLabel.font = [UIFont boldSystemFontOfSize:50];
    AnswerResultLabel.textAlignment = NSTextAlignmentCenter;
    AnswerResultLabel.layer.backgroundColor = UIColorFromHEX(0x202020).CGColor;
    AnswerResultLabel.layer.cornerRadius = 30;
    
    [AnswerResultLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [NSLayoutConstraint activateConstraints:@[
    
    [AnswerResultLabel.topAnchor constraintEqualToAnchor:YESImage.topAnchor constant:-100],
    [AnswerResultLabel.leadingAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:-100],
    [AnswerResultLabel.trailingAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:100],
    [AnswerResultLabel.bottomAnchor constraintEqualToAnchor:YESImage.topAnchor constant:-35],
    
    ]];
}

-(void) Yes_No_ButtonsView {
     
    
    YESImage = [CMManager InitImage:[UIImage imageNamed:@"T"] Frame:CGRectNull InView:self.view];
    
    [YESImage setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [NSLayoutConstraint activateConstraints:@[
    
    [YESImage.topAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-175],
    [YESImage.leadingAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:-165],
    [YESImage.trailingAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:-25],
    [YESImage.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-40],
    
    ]];
    
    

    
    YESButton = [CMManager InitButtonWithName:@"" Frame:CGRectNull InView:self.view Target:self Action:@selector(IF_Answer_IS_YES)];
        
    [YESButton addTarget:self action:@selector(ZoomYES) forControlEvents:UIControlEventTouchDown];

    [YESButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [NSLayoutConstraint activateConstraints:@[
     
    [YESButton.topAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-175],
    [YESButton.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:-165],
    [YESButton.trailingAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:-25],
    [YESButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-40],
    
    ]];
    
    
    
    NOImage = [CMManager InitImage:[UIImage imageNamed:@"F"] Frame:CGRectNull InView:self.view];
    
    [NOImage setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [NSLayoutConstraint activateConstraints:@[
    
    [NOImage.topAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-175],
    [NOImage.leadingAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:25],
    [NOImage.trailingAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:165],
    [NOImage.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-40],
    
    ]];
    
    
    NOButton = [CMManager InitButtonWithName:@"" Frame:CGRectNull InView:self.view Target:self Action:@selector(IF_Answer_IS_NO)];
    
    
    [NOButton addTarget:self action:@selector(ZoomNO) forControlEvents:UIControlEventTouchDown];

    [NOButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [NSLayoutConstraint activateConstraints:@[
     
    [NOButton.topAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-175],
    [NOButton.leadingAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:25],
    [NOButton.trailingAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:165],
    [NOButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-40],
    
    ]];
    
    
}




#pragma Animations

-(void) Zoom {
 
    [self animatedZoom:StartImage];
    
}
 

-(void)animatedZoom:(UIImageView *)zoomImage {
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionTransitionCurlDown animations:^{
        
        zoomImage.transform = CGAffineTransformMakeScale(0.9,0.9); //0.9*1.1,0.9*1.1 Lite
        
    } completion:^(BOOL finished){
        
        zoomImage.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
}


-(void) ZoomYES {
    
    [self animatedZoom:YESImage];
}

-(void) ZoomNO {
    
    [self animatedZoom:NOImage];
}








#pragma Calculations_AND_AnswerChecker

-(void) CreateMath {
    
    NSUInteger DPlay = [[CMManager Generator:1] integerValue];
    
    FirstNum = [[CMManager Generator:1] integerValue];
    SecondNum = [[CMManager Generator:1] integerValue];
    
 
    
    NSString *Mark = nil;
    
    if (SelectedSega == 0) {
        
    if (DPlay >= 5)
    Result = [[CMManager Generator:1] integerValue];
    else
    Result = FirstNum + SecondNum;
        
    Mark = @"+";
    }

    if (SelectedSega == 1) {
        
    if (DPlay >= 5)
    Result = [[CMManager Generator:1] integerValue];
    else
    Result = FirstNum * SecondNum;
        
    Mark = @"x";
    }

    if (SelectedSega == 2) {
    
    if (DPlay >= 5)
    Result = [[CMManager Generator:1] integerValue];
    else
    Result = FirstNum - SecondNum;
   
    Mark = @"-";
    }

    
    
    
    if (Result > 100)
        Result = 3;
        
    
    
    CalculationResult = [NSString stringWithFormat:@"%lu %@ %lu = %lu",FirstNum,Mark,SecondNum,Result];
    
    if (CalculationResult)
    Math.text = [NSString stringWithFormat:@"%lu %@ %lu = %lu",FirstNum,Mark,SecondNum,Result];
    
    
}
 



-(void) IF_Answer_IS_YES {
    
    if (!DidAlloc) {
    
    [self AnswerResult];

    DidAlloc = YES;
    }
    
    NSUInteger CResults = 0;
    
    if (SelectedSega == 0)
        CResults = FirstNum + SecondNum;
    
    if (SelectedSega == 1)
        CResults = FirstNum * SecondNum;
    
    if (SelectedSega == 2)
        CResults = FirstNum - SecondNum;
    
    
    AnswerResultLabel.hidden = NO;
    
    if (CResults == Result) {
        
        CurrentScore += 1;
        AnswerResultLabel.text = @"Great";
        AnswerResultLabel.textColor = UIColor.greenColor;
        
        NSLog(@"Great");

        [CMManager  ActivateTheFollowingCodeAfter:1 handler:^{
    
            [self CreateMath];
            self->AnswerResultLabel.hidden = YES;
        }];
      
    } else {
        
        AnswerResultLabel.text = @"Wrong";
        AnswerResultLabel.textColor = UIColor.redColor;
        NSLog(@"Wrong");
        
        if (CurrentScore > [[[NSUserDefaults standardUserDefaults] objectForKey:@"Best"] integerValue])
            [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInteger:CurrentScore] forKey:@"Best"];
        
        
        [self performSelector:@selector(HomeMode) withObject:nil afterDelay:1];
        
    }
    
    

}

-(void) IF_Answer_IS_NO {
    
    if (!DidAlloc) {
    
    [self AnswerResult];

    DidAlloc = YES;
    }
    
    
    NSUInteger CResults = 0;
    
    if (SelectedSega == 0)
        CResults = FirstNum + SecondNum;
    
    if (SelectedSega == 1)
        CResults = FirstNum * SecondNum;
    
    if (SelectedSega == 2)
        CResults = FirstNum - SecondNum;
    
    
    
    AnswerResultLabel.hidden = NO;
    
    if (CResults != Result) {
        
        CurrentScore += 1;
        AnswerResultLabel.text = @"Great";
        AnswerResultLabel.textColor = UIColor.greenColor;
        NSLog(@"Great");
      
        [CMManager  ActivateTheFollowingCodeAfter:1 handler:^{
    
            [self CreateMath];
            self->AnswerResultLabel.hidden = YES;
        }];
        
    } else {
        
        AnswerResultLabel.text = @"Wrong";
        AnswerResultLabel.textColor = UIColor.redColor;
        NSLog(@"Wrong");
        
        if (CurrentScore > [[[NSUserDefaults standardUserDefaults] objectForKey:@"Best"] integerValue])
            [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInteger:CurrentScore] forKey:@"Best"];
        
        [self performSelector:@selector(HomeMode) withObject:nil afterDelay:1];

    }
    
}







 


@end
