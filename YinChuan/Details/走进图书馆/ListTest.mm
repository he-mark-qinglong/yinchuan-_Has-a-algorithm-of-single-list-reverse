//
//  ListTest.m
//  YinChuan
//
//  Created by mark on 14-6-12.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "ListTest.h"

struct Node{
    struct Node *next;
//    struct Node *last;
    int data;
};


static Node *header;

void initList()
{
    header = new Node;
    Node *p = header;
    p->data = 0;
    
    for(int i = 1; i < 6; i++){
        p->next = new Node;
        p = p->next;
        p->data = i;
    }
    p->next = nil;
}
/*
void pointBackList()
{
    auto itr = header;
    itr->last = nil;
    
    for( ; itr->next != nil; itr = itr->next){
        itr->next->last = itr;
    }
    header = itr;
}
*/
Node* reverse_getNext(Node *lastHeader, Node **_p1, Node **_p2)
{
    Node *tmp = *_p2; //保存p2的地址
    (*_p2)->next = (*_p1);  //更新指针
    (*_p1)->next = lastHeader;
    return tmp;//返回旧的
}

Node * reverseList(Node* header)
{
    Node *tail = nullptr;
    Node *newHeader = header->next->next;
    tail = reverse_getNext(tail , &header, &(header->next));  //首次，头为空.扭转前两个节点，返回第2个节点
    
    while(newHeader->next){
        Node *newHeaderTmp = newHeader->next->next;  //拿到第三个节点
        if(newHeaderTmp == nil){
            Node *lastNode = newHeader->next;
            lastNode->next = newHeader; //最后一个元素指向倒数第二个元素
            //更新后，倒数第二个元素指向反向列表的头部
            newHeader->next= tail;
            tail = lastNode;
            break;
        }
        tail = reverse_getNext(tail , &newHeader, &(newHeader->next));  //扭两个节点，返回第2个节点
        newHeader = newHeaderTmp;
    }
    
    return tail;
}

@implementation ListTest

- (void)run
{
    initList();
    
    for(auto itr = header; itr != nil; itr = itr->next){
        NSLog(@"%d", itr->data);
    }
    
    header = reverseList(header);
    NSLog(@"\n");
    for(auto itr = header; itr != nil; itr = itr->next){
        NSLog(@"%d", itr->data);
    }
}
@end
