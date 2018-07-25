#include "ast.h"
#include <sintatico.tab.h>
#include <math.h>

void RPN_Walk(TreeNode* aux)
{
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

double eval(TreeNode* aux, double xval)
{
	if(aux)
	{
		double l = eval(aux->left, xval);
		double r = eval(aux->right, xval);
		switch(aux->node_type)
		{
			case PLUS:{return l + r;}break;
			case MINUS:{return l - r;}break;
			case MULTIPLY:{return l * r;}break;
			case DIV:{return l / r;}break;
			case EXP:{return pow(l, r);}break;
			case REM:{return (double) ((int) round(l) % (int) round(r));}break;
			case SEN:{return sin(l);}break;
			case COS:{return cos(l);}break;
			case TAN:{return tan(l);}break;
			case ABS:{return fabs(l);}break;
			case REAL:{return aux->value;};break;
			case X:{return xval;}break;
			default:{return 0.0;}break;
		}
	}
	return 0.0;
}

TreeNode *create_node(int t, double val, TreeNode *l, TreeNode *r) {
	TreeNode *aux = malloc(sizeof(struct node));
	aux->node_type = t;
	aux->value = val;
	aux->left = l;
	aux->right = r;
	return aux;
}