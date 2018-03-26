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
    // 1.结点个数
    Node *header = [self initALinkList];
//    NSLog(@"header1:%p",header);
    NSLog(@"list num = %d",_getNodeNum(header)); //考虑是否有环？、、
//    NSLog(@"header2:%p",header);
    // 2. 反转链表
//    invertListNode(header);
    // 3. k个结点
    Node *kNode = NodeOfIndex(2, header);
    NSLog(@"倒数第 %d 个结点值为:%d",2,kNode? kNode->value : -1);
    // 4.中间结点
    Node *middleNode = nodeOfMiddleIndex(header);
    NSLog(@"中间结点值为:%d",middleNode?middleNode->value:-1);
    // 5.是否有环
    NSLog(@"是否有环:%d",nodeHasCircle(header));
}
#pragma mark -- 指针学习
- (void)_test_pointer{
    int *p = NULL;
    int a = 5;
    p = &a;
    NSLog(@"%p,%p",p,&p);
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
        Node *tempNode = currentHeadNode;
        // 3.当前头结点指针后移
        currentHeadNode = currentHeadNode->next;
        // 2.当前头结点指向新头结点
        tempNode->next = NewHeaderNode; //这个时候currentHeadNode->next变成NULL，所以要赶紧把currentHeadNode指走
        // 4.新头结点指针后移
        NewHeaderNode = tempNode;
        
    }
    // 3. 输出一遍
    Node *headerNode = NewHeaderNode;
    while (headerNode != NULL ) {
        printf("value:%d",headerNode->value);
        headerNode = headerNode ->next;
    }
}
// 双指针法，判断有环、倒数第n个结点、第一个相交的结点
#pragma mark --
// 倒数第k个结点
// 思路：用双指针解法，头指针先向前移动k个结点，然后头尾指针一起移动，头指针移动到尾部时，尾指针指向的就是
Node *NodeOfIndex(int k, Node *header){
    if(header == NULL || k < 0) return NULL;
    Node *before = header;
    while (before && k > 0) { // 移动k个结点
        before = before -> next;
        k--;
    }
    if(k > 0) return NULL; //说明没这么多结点
    Node *behind = header;
    while (before) {
        before = before->next;
        behind = behind->next;
    }
    return behind;
}

// 中间结点
Node *nodeOfMiddleIndex(Node *header){
    if(header == NULL) return NULL;
    if(header->next == NULL) return header;  //只有一个结点
    if(header->next->next == NULL) return header; //只有两个结点
    Node *before = header;
    Node *behind = header;
    while (before->next) { //一个走两步，一个走一步
        before = before->next;
        behind = behind->next;
        if(before) before = before->next;
    }
    return behind;
}
// 链表有环
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
// 链表相交：
// 1.两个链表都无环
// 2.有一个链表有环
// 3.两个链表都有环

// 有序链表合并
Node* mergeTwoSortNode(Node *header1, Node *header2){
    
    return NULL;
}

//
@end
