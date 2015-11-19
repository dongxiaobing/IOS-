//
//  ViewController.m
//  IOS游戏下载
//
//  Created by dxb on 15/11/19.
//  Copyright (c) 2015年 dxb. All rights reserved.
//
#import <UIKit/UIKitDefines.h>
#import "ViewController.h"

@interface ViewController ()
//定义app.plist中得属性
@property (nonatomic,strong) NSArray *appInfos;


@end

@implementation ViewController
//重写get方法，在获取_appinfos数据的时候，使用懒加载,如果没有才获取，如果有则直接返回
- (NSArray *) appInfos
{
    if (_appInfos == nil) {
        //1.1 bundle
        NSBundle *bundle = [NSBundle mainBundle];
        //1.2 获取plist的路径
        NSString *path = [bundle pathForResource:@"app" ofType:@"plist"];
        //1.3 加载plist
        _appInfos = [NSArray arrayWithContentsOfFile:path];
    }
    return _appInfos;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //1.测试get 数据
    NSLog(@"%@",self.appInfos);
    
    
    NSInteger count=self.appInfos.count;
    
    //每个子ciew的宽高
    CGFloat viewW=100;
    CGFloat viewH=100;
    //横向间距和纵向间距
    CGFloat maginX=(self.view.frame.size.width-viewW*3)/4;
    CGFloat maginY=20;
    
    
    
    
    for(int i=0;i<count;i++)
    {
        //有几个数据，则加载一个view
        
        UIView *subView=[[UIView alloc] init];
        [self.view addSubview:subView];

        //行
        int row=i/3;
        //列
        int columns=i%3;
        //子view的 x y坐标
        CGFloat viewX=maginX+columns*(maginX+viewW);
        CGFloat viewY=maginY+row*(maginY+viewH);
        subView.frame=CGRectMake(viewX, viewY, viewW, viewH);
        
        //测试
//        subView.backgroundColor=[UIColor redColor];
 //      [subView setBackgroundColor:[UIColor blackColor]];
        
        
        //往subView中添加图片、标题、下载按钮
        NSDictionary *dict=self.appInfos[i];
        UIImageView *image=[[UIImageView alloc] initWithImage:[UIImage imageNamed:dict[@"icon"]]];
        [subView addSubview:image];
        //image坐标
        CGFloat imageH=60;
        CGFloat imageW=60;
        
        CGFloat imageX=(viewW-imageW)/2;
        CGFloat imageY=0;
        
        image.frame=CGRectMake(imageX, imageY, imageW, imageH);
        
        //lable
        UILabel *uiLable=[[UILabel alloc] init];
        uiLable.text=dict[@"name"];
        uiLable.font=[UIFont systemFontOfSize:15];
        uiLable.textAlignment=NSTextAlignmentCenter;
        [subView addSubview:uiLable];
        //lable坐标
        CGFloat lableH=20;
        CGFloat lableW=viewW;
        
        CGFloat lableX=0;
        CGFloat lableY=imageH;
        
        uiLable.frame=CGRectMake(lableX, lableY, lableW, lableH);
        
        //下载按钮
        
        UIButton *downloadView = [UIButton buttonWithType:UIButtonTypeCustom];
        [subView addSubview:downloadView];
        //计算frame
        CGFloat downloadW = 40;
        CGFloat downloadH = 20;
        CGFloat downloadX = viewX;
        //获得label的最大y值
        CGFloat downloadY = CGRectGetMaxY(uiLable.frame);
        downloadView.frame = CGRectMake(downloadX, downloadY, downloadW, downloadH);
        
        [downloadView setTitle:@"下载" forState:UIControlStateNormal];
        
        [downloadView setBackgroundImage:[UIImage imageNamed:@"buttongreen"] forState:UIControlStateNormal];
        [downloadView setBackgroundImage:[UIImage imageNamed:@"buttongreen_highlighted"] forState:UIControlStateHighlighted];
        //设置按钮文字的大小
        downloadView.titleLabel.font = [UIFont systemFontOfSize:15];
        //给按钮注册事件
        [downloadView addTarget:self action:@selector(downloadClick) forControlEvents:UIControlEventTouchUpInside];
        
        //    downloadView.tag = i;
    }
    
    
        
        
}
    

- (void)downloadClick
{
    NSLog(@"==");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
