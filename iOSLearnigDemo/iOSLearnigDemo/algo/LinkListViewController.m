//
//  LinkListViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/3/23.
//  Copyright © 2018年 George_luofz. All rights reserved.
//  链表学习
// 1.面试最常考的数据结构，链表的增删改查都只需要20行代码即可搞定，比较适合面试
// 2.链表是一个动态的数据结构，其操作要靠指针，需要较好的编程功底
// 3.链表数据结构很灵活
// 理解：可以理解成无左(右)子结点的树，树基本都是用递归解决的，所以链表常常可以用递归操作

#import "LinkListViewController.h"
#import "Stack.h"

struct Node{
    int value;
    struct Node *next;
};
struct Stack{
    struct Node *top;
    
};
@interface LinkListViewController ()

@end

@implementation LinkListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self _test_pointer];
//    [self _testPrintfLinkList];
    // 1. 结点个数
    Node *header = [self initALinkList];
//    NSLog(@"header1:%p",header);
    NSLog(@"list num = %d",_getNodeNum(header)); //考虑是否有环？、、
//    NSLog(@"header2:%p",header);
    // 2. 反转链表
    invertListNode(header);
    // 3. k个结点
//    Node *kNode = NodeOfIndex(2, header);
    Node *kNode = lastKNode(header, 2);
    NSLog(@"倒数第 %d 个结点值为:%d",2,kNode? kNode->value : -1);
    // 4. 中间结点
    Node *midNode = middleNode(header);
    NSLog(@"中间结点值为:%d",midNode?midNode->value:-1);
    // 5. 合并两个有序链表
    [self _test_merge_sortList];
    // 6. 是否有环
    NSLog(@"是否有环:%d",nodeHasCircle(header));
    
    // 7. 是否相交
    [self _test_twoListHasCross];
    // 8. 环入口
    [self _test_cirleStartNode];
}
#pragma mark -- 指针学习
- (void)_test_pointer{
    int *p = NULL;
    int a = 5;
    p = &a;
    NSLog(@"%p,%p",p,&p);
}
- (void)_test_merge_sortList{
    Node *node1 = malloc(sizeof(Node));
    node1->value = 1;
    Node *node2 = malloc(sizeof(Node));
    node2->value = 2;
    Node *node3= malloc(sizeof(Node));
    node3->value = 3;
    Node *node4 = malloc(sizeof(Node));
    node4->value = 6;
    Node *node5 = malloc(sizeof(Node));
    node5->value = 8;
    node1->next = node2;
    node2->next = node3;
    node3->next = node4;
    node4->next = node5;
    
    Node *node11 = malloc(sizeof(Node));
    node11->value = 3;
    Node *node22 = malloc(sizeof(Node));
    node22->value = 5;
    Node *node33= malloc(sizeof(Node));
    node33->value = 7;
    Node *node44 = malloc(sizeof(Node));
    node44->value = 9;
    Node *node55 = malloc(sizeof(Node));
    node55->value = 10;
    
    node11->next = node22;
    node22->next = node33;
    node33->next = node44;
    node44->next = node55;
    
    // 打印一下
    Node *newNode = mergeTwoSortList(node1, node11);
    if(newNode == NULL) return;
    while (newNode->next) {
        NSLog(@"node:%d",newNode->value);
        newNode = newNode->next;
    }
}

- (void)_test_twoListHasCross{
    Node *node1 = malloc(sizeof(Node));
    node1->value = 1;
    Node *node2 = malloc(sizeof(Node));
    node2->value = 2;
    Node *node3= malloc(sizeof(Node));
    node3->value = 3;
    node1->next = node2;
    node2->next = node3;
    
    Node *node11 = malloc(sizeof(Node));
    node11->value = 3;
    Node *node22 = malloc(sizeof(Node));
    node22->value = 5;
    Node *node33= malloc(sizeof(Node));
    node33->value = 7;
    
    node11->next = node22;
    node22->next = node33;
    node33->next = node2;
    
    // 判断相交
    if(nodeCross(node1, node11)){
        NSLog(@"has cross");
    }else{
        NSLog(@"has not crossed");
    }
    // 2.找交点
    Node *node = crossNode(node1, node11);
    if(node){
        NSLog(@"cross %d",node->value);
    }else{
        NSLog(@"cross null");
    }
}
// 测试入口点
- (void)_test_cirleStartNode{
    Node *node1 = malloc(sizeof(Node));
    node1->value = 1;
    Node *node2 = malloc(sizeof(Node));
    node2->value = 2;
    Node *node3= malloc(sizeof(Node));
    node3->value = 3;
    Node *node4 = malloc(sizeof(Node));
    node4->value = 4;
    Node *node5 = malloc(sizeof(Node));
    node5->value = 5;
    node1->next = node2;
    node2->next = node3;
    node3->next = node4;
    node4->next = node5;
    node5->next = node2; //入口点
    Node *node = circleStartNode(node1);
    if(node){
        NSLog(@"环入口:%d",node->value);
    }else{
        NSLog(@"无环");
    }
}
#pragma mark -- link
- (Node *)initALinkList{
    Node *node1 = malloc(sizeof(Node));
    node1->value = 1;
    Node *node2 = malloc(sizeof(Node));
    node2->value = 2;
    Node *node3= malloc(sizeof(Node));
    node3->value = 3;
    Node *node4 = malloc(sizeof(Node));
    node4->value = 4;
    Node *node5 = malloc(sizeof(Node));
    node5->value = 5;
    node1->next = node2;
    node2->next = node3;
    node3->next = node4;
    node4->next = node5;
//    node5->next = node1;
    return node1;
}
- (void)_testPrintfLinkList{
    Node *header = [self initALinkList];
    printLinkListWithOppositeSort(header);
}
#pragma mark -- 倒序打印链表

// 思路：
// 1. 若不用递归，则可以借助栈实现，先push再pop就实现了反转
// 2. 可以递归，因为递归其实也是一个栈结构，直接打印就行
// 指针的指针，一直不理解
void printLinkListWithOppositeSort(Node *header){
    if(header == NULL) return;
    Stack *stack = NULL;
    initStack(&stack);
    Node *node = header;
    // 入栈
    while (node != NULL) {
        push(stack,node);
        node = node->next;
    }
    // 出栈，并打印
    while (!empty(stack)) {
        struct Node *topNode = pop(stack);
        printf("value=%d",topNode->value);
    }
}
// 递归方式打印
void recursivlyprintLinkListWithOppositeSort(struct Node *header){
    if(header != NULL){
        if(header->next != NULL){
            recursivlyprintLinkListWithOppositeSort(header->next);
        }
        printf("%d",header->value);
    }
}
// 这tmd可是大一的知识啊

#pragma mark -- 链表基本操作
//题目列表：
//
//1. 求单链表中结点的个数
//2. 将单链表反转
//3. 查找单链表中的倒数第K个结点（k > 0）
//4. 查找单链表的中间结点
//5. 从尾到头打印单链表
//6. 已知两个单链表pHead1 和pHead2 各自有序，把它们合并成一个链表依然有序
//7. 判断一个单链表中是否有环
//8. 判断两个单链表是否相交
//9. 求两个单链表相交的第一个节点
//10. 已知一个单链表中存在环，求进入环中的第一个节点
//11. 给出一单链表头指针pHead和一节点指针pToBeDeleted，O(1)时间复杂度删除节点pToBeDeleted

int _getNodeNum(Node * header){
    if(header == NULL) return 0;
    int num = 0;
    Node *node = header; //此处引用一下好像多此一举
    while (header != NULL) {
        num++;
        header = header->next; //此处为何不用*header;
    }
    return num;
}
#pragma mark -- 反转链表
void invertListNode(Node *header){
    // 1.如果是空或者如果只有一个，直接return
    if(header == NULL || header->next == NULL){
        return;
    }
    // 2.开始遍历，将新下一个结点放在头结点的前边
    Node *NewHeaderNode = NULL;
    Node *currentHeadNode = header;
    while (currentHeadNode != NULL) {
        // 1.取当前头结点
//        Node *tempNode = currentHeadNode;
//        // 2. 头结点指向下一个结点
//        currentHeadNode = currentHeadNode->next;
//        // 3. 当前头结点指向新结点
//        tempNode->next = NewHeaderNode; //???
//        // 4. 新结点指向当前头结点
//        NewHeaderNode = tempNode;
        
//         1.取当前头结点  ？？？为啥2和3要调换顺序
//        Node *tempNode = currentHeadNode;
//        // 3.当前头结点指针后移
//        currentHeadNode = currentHeadNode->next;
//        // 2.当前头结点指向新头结点
//        tempNode->next = NewHeaderNode; //这个时候currentHeadNode->next变成NULL，所以要赶紧把currentHeadNode指走
//        // 4.新头结点指针后移
//        NewHeaderNode = tempNode;
        Node *tempNode = currentHeadNode;
        tempNode->next = NewHeaderNode;
        currentHeadNode = currentHeadNode->next;
        NewHeaderNode = tempNode;
        
        //
        `1NFDÅQ=[]\
       ?˘ b. 输出一遍
    Node *headerNode = NewHeaderNode;
    while (headerNode != NULL ) {
        printf("value:%d",headerNode->value);
        headerNode = headerNode ->next;
    }
}

#pragma mark -- 倒数第k个结点
Node *lastKNode(Node *header, int k){
    if(k < 0 || header == NULL) return NULL;
    // 1.先遍历到第k个结点
    Node *tempHeader = header;
    while (tempHeader && k > 0) {
        k--;
        tempHeader = tempHeader->next;
    }
    if(k > 0) return NULL;
    // 2.再来一个指针从头遍历，第一个遍历完毕，第二个就是
    Node *tempHeader2 = header;
    while (tempHeader) {
        tempHeader = tempHeader->next;
        tempHeader2 = tempHeader2->next;
    }
    return tempHeader2;
}
#pragma mark -- 中间结点
Node *middleNode(Node *header){
    // 1.合法性判断
    if(header == NULL) return NULL;
    if(header->next == NULL) return header;
    if(header->next->next == NULL) return header;
    // 2.使用快慢指针
    Node *before = header;
    Node *behind = header;
    while (before->next) {
        before = before->next;
        behind = behind->next;
        if(before){
            before = before->next;
        }
    }
    return behind;
}
#pragma mark -- 合并两个有序链表
// 思路：从头到尾遍历两个链表，谁的值小新链表的当前结点就是谁
Node * mergeTwoSortList(Node *header1, Node *header2){
    // 1.判断
    if(header1 == NULL) return header2;
    if(header2 == NULL) return header1;
    
    // 2.准备合并，先找第一个节点，要不然还得在while循环中判断；所以单拿出来操作
    Node *newHeader = NULL;
    if(header1->value < header2->value){
        newHeader = header1;
        header1 = header1->next;
    }else if(header1->value > header2->value){
        newHeader = header2;
        header2 = header2->next;
    }else{
        newHeader = header1;
        newHeader->next = header2;
        header1 = header1->next;
        header2 = header2->next;
    }
    Node *tempNode = newHeader;
    // 3.开始合并
    while (header1->next && header2->next) {
        if(header1->value < header2->value){
            tempNode->next = header1;
            tempNode = tempNode->next;
            header1 = header1->next;
        }else if(header1->value > header2->value){
            tempNode->next = header2;
            tempNode = tempNode->next;
            header2 = header2 -> next;
        }else{
            // 新链表指向header1结点
            tempNode->next = header1;
            // header1下移
            header1 = header1->next;
            // 新链表头指针下移
            tempNode = tempNode->next;
            // 同上，操作header2头结点
            tempNode->next = header2;
            header2 = header2->next;
            tempNode = tempNode->next;
        }
    }
    // 4. 合并剩余的部分
    if(header1){
        tempNode->next = header1;
    }
    if(header2){
        tempNode->next = header2;
    }
    return newHeader;
}
#pragma mark -- 链表有环
bool nodeHasCircle(Node *header){
    if(header == NULL) return false;
    Node *before = header;
    Node *behind = header;
    while (before) {
        before = before->next;
        if(before){
            before = before->next;
        }
        behind = behind->next;
        if(before == behind) return true;
    }
    return false;
}
#pragma mark -- 链表相交
// 链表相交：
// 1.两个链表都无环
// 2.有一个链表有环
// 3.两个链表都有环
bool nodeCross(Node *node1,Node *node2){
    // 1.合法判断
    if(node1 == NULL || node2 == NULL) return false;
    // 2.分别遍历到尾部，比较尾部是否相等
    Node *header1 = node1;
    Node *header2 = node2;
    while (header1->next) { //判断尾部
        header1 = header1->next;
    }
    while (header2->next) {
        header2 = header2->next;
    }
    if(header1 == header2){
        return true;
    }
    
    return false;
//    // 3. 将第二个链表指向第一个连标点尾部
//    Node *header1 = node1;
//    while (header1->next) {
//        header1 = header1->next;
//    }
//    header1->next = node2;
//    return nodeHasCircle(node2);
}

#pragma mark -- 链表第一个交点
// 思路：
// 由于两个链表相交，则从交点到尾部都相等；链表的长度之差为：len1-len2 = k，则长链表先走k部之后，再同时走，必然相遇
Node *crossNode(Node *node1,Node *node2){
    if(node1 == NULL || node2 == NULL) return NULL;
    // 1.计算长度
    int len1 = 0;
    int len2 = 0;
    Node *header1 = node1;
    Node *header2 = node2;
    while (header1) {
        header1 = header1->next;
        len1++;
    }
    while (header2) {
        header2 = header2->next;
        len2++;
    }
    // 长度为k
    int k = len2>len1? len2-len1:len1-len2;
    // 2.分情况遍历
    if(len2 > len1){
        // 2.1 长链表先走k部
        while (k > 0) {
            node2 = node2->next;
            k--;
        }
        // 2.2 两个链表同时走，啥时候相等啥时候就是交点
        while (node1 && node2) {
            if(node1 == node2){
                return node1;
            }
            node2 = node2->next;
            node1 = node1->next;
        }
    }else{
        while (k > 0) {
            node1 = node1->next;
            k--;
        }
        while (node1 && node2) {
            if(node1 == node2){
                return node2;
            }
            node2 = node2->next;
            node1 = node1->next;
        }
    }
    return NULL;
}
#pragma mark -- 链表环入口
Node *circleStartNode(Node *header){
    if(header == NULL) return NULL;
    // 1.找到相遇点
    Node *before = header;
    Node *behind = header;
    BOOL flag = false;//标记是否有环
    while (before) {
        before = before->next;
        if(before){
            before = before->next;
        }
        behind = behind->next;
        if(before == behind){
            flag = true;
            break;
        }
    }
    // 无环，直接返回
    if(flag == false) return NULL;
    // 2.定义两个指针，再次遍历
    Node *startNode = header;
    Node *meetNode = before;
    while (startNode) {
        if(startNode == meetNode){
            return startNode;
        }
        startNode = startNode->next;
        meetNode = meetNode->next;
    }
    return NULL;
}

@end
