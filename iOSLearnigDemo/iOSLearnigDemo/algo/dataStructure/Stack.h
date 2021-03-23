//
//  Stack.h
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/3/23.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#ifndef Stack_h
#define Stack_h

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
typedef struct node{
    int value;
    struct Node *next;
}Node;

typedef struct stack{
     Node *top;
     Node *bottom;
}Stack;

void initStack(Stack **stack);
void push(Stack *stack, Node *node);
Node* pop(Stack *stack);
bool empty(Stack *stack);

int lenth(Stack *stack);
void clear(Stack *stack);

#endif /* Stack_h */
