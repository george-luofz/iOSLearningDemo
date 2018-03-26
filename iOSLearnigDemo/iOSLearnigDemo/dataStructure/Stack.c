//
//  Stack.c
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/3/23.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#include "Stack.h"

void initStack(Stack **stack){
//    Node *node = (Node *)malloc(sizeof(Node));
//    if(NULL == node){
//        return;
//    }
//    stack->top = node;
//    stack->bottom = stack->top;
    Stack *mallocStack = malloc(sizeof(Stack));
    mallocStack->top = NULL;
    mallocStack->bottom = NULL;
    *stack = mallocStack;
}
void push(Stack *stack, Node *node){
    if(node == NULL) return;
    Node *top = stack->top;
    if(top == NULL){
        stack->bottom = node;
    }else{
        node->next = top;
    }
    stack->top = node;
}
Node* pop(Stack *stack){
    if(stack == NULL) return NULL;
    Node *top = stack->top;
    if(top->next == NULL){
        stack->bottom = NULL;
    }
    return top;
}
bool empty(Stack *stack){
    if(stack == NULL) return true;
    if(stack->top == stack->bottom) return true;
    return false;
}
int lenth(Stack *stack){
    if(stack == NULL) return 0;
    Node *top = stack->top;
    int length = 0;
    while (top != stack->bottom) {
        length++;
        top = top->next;
    }
    return length;
}
void clear(Stack *stack){
    if(stack == NULL) return;
    Node *node = stack->top;
    while (node != NULL) {
        Node *freeNode = node;
        node = node->next;
        free(freeNode);
    }
}
