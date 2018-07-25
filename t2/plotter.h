#ifndef PLOT__H
#define PLOT__H

#include "ast.h"
#include "settings.h"

char graph[25][80];

void plot(TreeNode *function);
void start_graph();
void draw_line();

#endif