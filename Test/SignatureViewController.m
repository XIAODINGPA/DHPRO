//
//  SignatureViewController.m
//  Test
//
//  Created by Rillakkuma on 2016/11/29.
//  Copyright © 2016年 Rillakkuma. All rights reserved.
//

#import "SignatureViewController.h"
#import "PJRSignatureView.h"

@interface SignatureViewController ()
{
	PJRSignatureView *signatureView;
}
@end

@implementation SignatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	signatureView= [[PJRSignatureView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 300)];
	signatureView.layer.borderColor = [UIColor lightGrayColor].CGColor;
	signatureView.layer.borderWidth = 0.3;
	signatureView.layer.cornerRadius = 3;
	[self.view addSubview:signatureView];    // Do any additional setup after loading the view.
	
	
	UIButton *signaturebutton = [UIButton buttonWithType:UIButtonTypeCustom];
	[signaturebutton setFrame:CGRectMake(10, 350, 80,30)];
	[signaturebutton setTitle:@"生成" forState:(UIControlStateNormal)];
	[signaturebutton setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
	[signaturebutton addTarget:self action:@selector(aaaa) forControlEvents:(UIControlEventTouchUpInside)];
	signaturebutton.backgroundColor = [UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:0.00];       //背景颜色
	[self.view addSubview:signaturebutton];

	
}
- (void)aaaa{
	UIImageView *i = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-100)/2, self.view.frame.size.height-240, 100, 100)];
	i.image =[signatureView getSignatureImage];
	i.layer.borderColor = [UIColor lightGrayColor].CGColor;
	i.layer.borderWidth = 0.3;
	i.layer.cornerRadius = 3;
	[self.view addSubview:i];
	[self bbbb:i.image];
	
}

- (void)bbbb : (UIImage*)im{
	NSString *API_URL_ = @"http://kaifa.homesoft.cn/WebService/jsonInterface.ashx?json=RepairCommit";
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
	[manager POST:API_URL_ parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
		
			NSInteger imgCount = 0;
			NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
			formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss:SSS";
			NSString *fileName = [NSString stringWithFormat:@"%@%@.png",[formatter stringFromDate:[NSDate date]],@(imgCount)];
			NSLog(@"我的图片：%@",fileName);
			[formData appendPartWithFileData:UIImagePNGRepresentation(im) name:@"file" fileName:fileName mimeType:@"image/png"];
			imgCount++;
			
		}
	 progress:^(NSProgress * _Nonnull uploadProgress) {
		NSLog(@"进度-%.2f",uploadProgress.fractionCompleted);
		
	} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		NSLog(@"responseObject%@",responseObject);
		
		
		
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		NSLog(@"获取数据失败原因%@",error.localizedFailureReason);
	}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end