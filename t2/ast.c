#include <ast.h>
#include <sintatico.tab.h>

void RPN_Walk(TreeNode* aux)
{
	puts("walking");
	if(aux)
	{
		RPN_Walk(aux->left);
		RPN_Walk(aux->right);
		switch(aux->node_type)
		{
			case PLUS:{printf("+ ");}break;
			case MINUS:{printf("- ");}break;
			case MULTIPLY:{printf("* ");}break;
			case DIV:{printf("/ ");}break;
			case EXP:{printf("^ ");}break;
			case REM:{printf("\% ");}break;
			case SEN:{printf("sen ");}break;
			case COS:{printf("cos ");}break;
			case TAN:{printf("tan ");}break;
			case ABS:{printf("add ");}break;
			case REAL:{printf("%f ",aux->value);};break;
			case X:{printf("X ");}break;
			default:{printf("ERROR: INVALID TYPE ");};break;
		}
	}
}

TreeNode *create_node(int t, int val, TreeNode *l, TreeNode *r) {
	TreeNode *aux = malloc(sizeof(struct node));
	aux->node_type = t;
	aux->value = val;
	aux->left = l;
	aux->right = r;
	return aux;
}