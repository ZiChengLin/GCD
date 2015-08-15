//
//  ViewController.m
//  Lesson-UI-GCD
//
//  Created by 林梓成 on 15/6/11.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

#pragma mark 1.NSObject开辟子线程在后台
    [self performSelectorInBackground:@selector(doThread1:) withObject:@"123"];
    
/*
 
#pragma mark 2.NSOperationQueue开辟多线程（线程队列：管理线程）
    // 一、创建一个线程队列
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    // 二、在线程队列里面创建多线程
    [operationQueue addOperationWithBlock:^{
        // 在这个block内部就是一个子线程
        NSLog(@"block = %d", [[NSThread currentThread] isMainThread]);
        // 返回主线程 如果waitUntilDone设置为YES,则表示当前线程执行完才会执行方法
        //[self performSelectorOnMainThread:@selector(<#selector#>) withObject:<#(id)#> waitUntilDone:<#(BOOL)#>];
    }];
*/
    
/*
 
#pragma mark 3.NSInvocationOperation开辟多线程（它也必须放在线程队列里面）
    // 一、创建一个线程队列
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    // 二、创建子线程对象
    NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(doOperation1:) object:nil];
    invocationOperation.queuePriority = NSOperationQueuePriorityVeryLow;  // 设置线程优先级（效果不明显）
    
    NSInvocationOperation *invocationOperation2 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(doOperation2:) object:nil];
    invocationOperation2.queuePriority = NSOperationQueuePriorityVeryHigh;
    
    // 三、将子线程添加到线程队列里面
    [operationQueue addOperation:invocationOperation];
    [operationQueue addOperation:invocationOperation2];
    
*/
    
    
/*
    
#pragma mark 4.GCD（基于C语言）
    // 一、创建一个线程队列 参数1是线程队列的名字 参数2是什么类型的队列（串行、并行）
    dispatch_queue_t queue = dispatch_queue_create("GCD", NULL);
    
    // 二、在线程队列里面创建子线程 参数1子线程放在哪个队列里 参数2的block里面就是子线程
    dispatch_async(queue, ^{
       
        NSLog(@"queue = %d", [[NSThread currentThread] isMainThread]);
        
        // 回到主线程 参数1是得到主线程队列
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"sync = %d", [[NSThread currentThread] isMainThread]);
        });
        
    });
    
*/
    
/*
#pragma mark 5.GCD（线程队列的串行）
    // 一、创建一个线程队列（默认的就是串行队列）
    dispatch_queue_t serailQueue = dispatch_queue_create("SERAIL", DISPATCH_QUEUE_SERIAL);
    
    // 二、同上（串行队列的特点：队列里面的子线程是顺序执行的）
    dispatch_async(serailQueue, ^{
       
        for (int i = 0; i < 10; i++) {
            
            NSLog(@"1****************");
        }
    });
    
    // 三、开辟第二个子线程
    dispatch_async(serailQueue, ^{
       
        for (int i = 0; i < 10; i++) {
            
            NSLog(@"2***************");
        }
    });
    
*/
    
    /*
#pragma mark 6.GCD（线程队列的并行）
    // 一、创建一个线程队列（并行队列）
    dispatch_queue_t concurrentQueue = dispatch_queue_create("CONCURRENT", DISPATCH_QUEUE_CONCURRENT);
    // 二、在线程队列里面创建子线程（并行队列的特点：受队列管理的子线程是并发执行的）
    dispatch_async(concurrentQueue, ^{
        for (int i = 0; i < 10; i++) {
            
            NSLog(@"1*****************");
        }
    });
    
    // 第二个子线程
    dispatch_async(concurrentQueue, ^{
        for (int i = 0; i < 10; i++) {
            
            NSLog(@"2*****************");
        }
    });
     
     */
    
}



- (void)doThread1:(id)object {
    
    NSLog(@"%d", [[NSThread currentThread] isMainThread]);  // 打印1表示是主线程 0是子线程
}

- (void)doOperation1:(id)object {
    
    for (int i = 0; i < 100; i++) {
        
        NSLog(@"op1~~~~~~~~~~~~~~");
    }
    
}

- (void)doOperation2:(id)object {
    
    for (int i = 0; i < 100; i++) {
        
        NSLog(@"op2--------------");
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
