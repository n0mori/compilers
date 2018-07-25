#include <stdio.h>
#include <stdlib.h>

typedef struct node TreeNode;
struct node
{
	int node_type;
	double value;
	TreeNode* left;
	TreeNode* right;
};

TreeNode *create_node(int t, double val, TreeNode *l, TreeNode *r);

void RPN_Walk(TreeNode* aux);