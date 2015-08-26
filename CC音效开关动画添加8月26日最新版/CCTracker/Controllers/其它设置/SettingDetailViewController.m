//
//  SettingDetailViewController.m
//  CCTravker
//
//  Created by LWB on 15/8/16.
//  Copyright (c) 2015年 Lvwenbin. All rights reserved.
//

#import "SettingDetailViewController.h"
#import "CCData.h"
#import "SettingEditViewController.h"
#import <StoreKit/StoreKit.h>
@interface SettingDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,SKStoreProductViewControllerDelegate>
{
    NSMutableArray * _dataArray;
    UIScrollView * _sc;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addItem;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *inputView;
@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputBottomConstraint;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputHeightConstraint;


@end

@implementation SettingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CATransition * ani1 = [CATransition animation];
    
    ani1.type = @"cube";
    
    
    ani1.duration = 0.5;
    [self.navigationController.view.layer addAnimation:ani1 forKey:nil];
    
    
    

    _inputHeightConstraint.constant = 1;
  
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     _dataArray = [NSMutableArray array];
    if (self.num1 == 0 && self.num2 == 1 ) {
        [self loadData];
        self.title = @"定时提醒";
        
        [self.tableView reloadData];
    }
    
    
    
    
    
    
    
    if (self.num1 == 1 && self.num2 == 0){
        
        self.title = @"给我评分";
    
        
        if([[[UIDevice currentDevice]systemVersion]compare:@"8.0" options:NSNumericSearch]){
        
                 NSString *str = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d",1032903809];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
        
        }else{
            
            
            [self evaluate];
            
        }
        
        
    }
    

    
      

    
    
    
    
    if(self.num1 == 1 && self.num2 == 1){
        self.title = @"关于健身";
        _tableView.hidden = YES;
        
        _sc = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        _sc.contentSize = CGSizeMake(self.view.frame.size.width, 2*self.view.frame.size.height);
        [self.view addSubview:_sc];
        
        
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0,0,_sc.contentSize.width,_sc.contentSize.height)];
        _sc.backgroundColor = [UIColor yellowColor];
        _sc.alpha = 0.6;
        
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor purpleColor];
        
        
        label.text = @"《囚徒健身》——关于健身非常好的一本的书 ，有些“无器械”健身方法，其实就是用生活用品代替器械，动作还是器械那套。与之相比，这本书是利用自己的体重进行训练，对物品的依赖比较小，当然引体向上那是没办法……对环境依赖小，这也是自重训练的一大好处。就算是最简单的跑步，也有场地、天气的限制，至于跑步机贵不说，又单调到爆，而自重训练只要自己体力有富余，真真正正的随时随地。合理的梯度，循序渐进。最低难度谁都可以做，最高难度也足够难，让人有长远的目标，对无基础者非常友好，有足够的良性反馈，引用一下豆瓣上的评论（http://book.douban.com/review/6611226/）：“每个动作的第一式都很容易，可以说人人都能做到，但依然需要锻炼到一个程度才能升级。这样的话，你每次都能做到，每次都有进步，给自己的成就感会大大加强了坚持下去的信心，直到你爱上健身” （http://book.douban.com/review/6368877/）：“除此之外，很多人不能坚持健身是因为他们在健身的初期没有得到良性的反馈。《囚徒健身》就在这6种动作上，每种划分了十个等级，比如俯卧撑就是：墙壁俯卧撑、矮台俯卧撑、半俯卧撑、膝盖俯卧撑、标准俯卧撑、单臂俯卧撑等等。不仅让你知道你离最终目标有多远，也让你知道你离刚开始健身的时候进步了多少” 这款app可以使我们更轻松的按照囚徒健身的指导自己来管理自己的锻炼进度";
        label.font = [UIFont systemFontOfSize:15];
        label.numberOfLines = 0;
        
        
        
        [_sc addSubview:label];
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    if (self.num1 == 1 && self.num2 == 2) {
        self.title = @"关于我们";
        _tableView.hidden = YES;
        
        _sc = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        _sc.contentSize = CGSizeMake(self.view.frame.size.width, 2*self.view.frame.size.height);
        [self.view addSubview:_sc];
        
        
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0,0,_sc.contentSize.width,_sc.contentSize.height)];
        _sc.backgroundColor = [UIColor yellowColor];
        _sc.alpha = 0.6;
        
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor purpleColor];

        
        
        label.text = @"囚徒健身助手简体中文版是一款简单易用的健身记录软件，提供了《囚徒健身》书中的插图详解，可由用户自己设置动作间隔休息时间，和定时提醒锻炼的功能，并使用的本地持久化数据记录了用户对每套动作的锻炼历史记录，根据锻炼的熟练程度提升用户的等级，等级提升后方可解锁高难度动作。本作品由开发者吕文彬耗时11天独立设计开发完成，支持各种版本的iPhone屏幕适配，由于在开发过程中使用了iOS8新特性，在iPhone5以下的版本上运行时会出现闪退，或图片滚动与动作名称不匹配等状况，开发者随后将逐步修复这些bug，如果您在使用过程中存在任何疑问，请联系开发者1048031666@qq.com";
        label.font = [UIFont systemFontOfSize:17];
        label.numberOfLines = 0;
        
        
        
        [_sc addSubview:label];
    }
    
    if (self.num1 == 2){
        
        self.title = @"使用协议";
        _tableView.hidden = YES;
        
        _sc = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        _sc.contentSize = CGSizeMake(self.view.frame.size.width, 4*self.view.frame.size.height);
        [self.view addSubview:_sc];
        
        
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0,0,_sc.contentSize.width,_sc.contentSize.height)];
        _sc.backgroundColor = [UIColor yellowColor];
        _sc.alpha = 0.6;
        
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor purpleColor];
        label.text = @"以下协议根据《中华人民共和国合同法》、《中华人民共和国计算机信息网络国际互联网管理暂行规定》、邮电部《中国公用计算机互联网国际网管理办法》等有关规 定制定。     一、 承诺 1. 您确认，在您成为我们的用户之前已充分阅读、理解并接受本协议的全部内容，一旦您使用本服务，即表示您同意遵循本协议之所有约定。2. 您同意，本产品开发者有权随时对本协议内容进行单方面的变更，并以网站公告的方式予以公布，无需另行单独通知您；若您在本协议内容公告变更后继续使用本服务的，表示您已充分阅读、理解并接受修改后的协议内容，也将遵循修改后的协议内容使用本服务；若您不同意修改后的协议内容，您应停止使用本服务。        二、APP使用的责任和义务:1. 您在使用本服务时应遵守中华人民共和国相关法律法规、您所在国家或地区之法令及相关国际惯例，不将本服务用于任何非法目的，也不以任何非法方式使用本服务。2. 您不得利用本服务从事侵害他人合法权益之行为，否则本产品有权拒绝提供本服务，且您应承担所有相关法律责任，因此导致本产品或本产品用户受损的，您应承担赔偿责任。上述行为包括但不限于：(1)侵害他人名誉权、隐私权、商业秘密、商标权、著作权、专利权等合法权益。(2)违反依法定或约定之保密义务。(3)冒用他人名义使用本服务。(4)从事不法行为，如制作色情、赌博、病毒、挂马、反动、外挂、私服、钓鱼以及为私服提供任何服务(比如支付)的类似网站。(5)提供赌博资讯或以任何方式引诱他人参与赌博。(6)从事任何可能含有电脑病毒或是可能侵害本服务系统、资料之行为。(7)其他有正当理由认为不适当之行为。3. 您理解并同意，本产品不对因下述任一情况导致的任何损害赔偿承担责任，包括但不限于流量、访问、数据等方面的损失或其他无形损失的损害赔偿 (无论本公司是否已被告知该等损害赔偿的可能性)：(1) 本产品开发方有权基于单方判断，包含但不限于认为您已经违反本协议的明文规定及精神，暂停、中断或终止向您提供本服务或其任何部分，并移除您的资料。免责条款：因下列状况无法正常运作，使您无法使用各项服务时，本产品开发者不承担损害赔偿责任，该状况包括但不限于：1. 由于系统升级或调整期间需要停机维护且停机维护之前做过广告的。2. 用户违反本协议条款的约定，导致第三方主张的任何损失或索赔。3. 因台风、地震、海啸、洪水、停电、战争、恐怖袭击等不可抗力之因素，造成系统障碍不能执行业务的。4. 由于黑客攻击、电信部门技术调整或故障、网站升级、银行方面的问题等原因而造成的服务中断或者延迟。            四、 责任范围及责任限制：1. 本产品仅对本协议中列明的责任承担范围负责。       五、法律及争议解决：1.本协议适用中华人民共和国法律。如遇本协议有关的某一特定事项缺乏明确法律规定，则应参照通用国际商业惯例和（或）行业惯例。2.因双方就本协议的签订、履行或解释发生争议，双方应努力友好协商解决。如协商不成，任何一方均有权将争议递交人民法院。——本协议最终解释权归产品开发者所有";
        label.font = [UIFont systemFontOfSize:17];
        label.numberOfLines = 0;[_sc addSubview:label];
        
    }
   

    
    
}
-(void)endEdit:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}
-(void)keyboardShow:(NSNotification *)notifi{
    CGFloat height = [[notifi.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue].size.height;
    [UIView animateWithDuration:0.3 animations:^{
        _inputBottomConstraint.constant = height;
        
    }];
}




-(void)keyboardHide:(NSNotification *)notifi{
    [UIView animateWithDuration:0.3 animations:^{
        _inputBottomConstraint.constant = 0;
        
    }completion:^(BOOL finished) {
        if (_dataArray.count) {
            [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_dataArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
    }];
}


-(void)evaluate{
    SKStoreProductViewController * storeProductViewController = [[SKStoreProductViewController alloc]init];
    storeProductViewController.delegate = self;
    [storeProductViewController loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier:@"1032903809"} completionBlock:^(BOOL result, NSError *error) {
        
        if (error) {
            NSLog(@"%@",error);
            
        }else{
            [self presentViewController:storeProductViewController animated:YES completion:^{
                
                
            }];
        }
        
    }];
    
    
    
    
    
    
    
}
-(void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)loadData{
  [_dataArray addObjectsFromArray:[CCData tiptimeFromCC]];
    
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (IBAction)back:(id)sender {
    CATransition * ani1 = [CATransition animation];
    
    ani1.type = @"cube";
    
    
    ani1.duration = 0.5;
    [self.navigationController.navigationBar.layer addAnimation:ani1 forKey:nil];
    

    [self.navigationController popViewControllerAnimated:YES];
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SettingDetail" forIndexPath:indexPath];

    
    NSDictionary * dic = _dataArray[indexPath.row];
    if ([dic[@"close"] integerValue]) {
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.detailTextLabel.textColor = [UIColor darkGrayColor];
    }else{
        cell.textLabel.textColor = [UIColor cyanColor];
        cell.detailTextLabel.textColor = [UIColor cyanColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"提醒时间:%@",[[dic[@"alarm"]componentsSeparatedByString:@" "]lastObject]];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"每%@天提醒一次",dic[@"repeat"]];
    
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"editTip" sender:indexPath];
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
  //  UIViewController * vc = [segue destinationViewController];
    
    if ([segue.identifier isEqualToString:@"editTip"]) {
       
        SettingEditViewController* vc = [segue destinationViewController];

        
        NSIndexPath * indexPath = sender;
       
        vc.num = indexPath.row;
        
        
        
        
        
    }
    
    
}


@end
