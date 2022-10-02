#pragma once
#include "Slae.h"

class SlaeGaussSolver : public Slae
{
public:
	SlaeGaussSolver(int n) : Slae(n) {}
	void solve_slae() override;

private:
	// возвращает индекс строки (среди [s; n-1]), в которой в столбце s макс. значение
	int get_maxabs_row(int s);
};
