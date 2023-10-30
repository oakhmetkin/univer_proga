#pragma once
#include <iostream>
#include "SlaeGaussSolver.h"

using namespace std;

void SlaeGaussSolver::solve_slae()
{
	for (int i = 0; i < n; i++)
	{
		// ставим строку с максимальным iым элементом на iое место
		int mr = get_maxabs_row(i);
		if (mr != i)
			change_rows(i, mr);

		// если максимальный (по модулю) элемент нулевой,
		// то и все элементы столбца ниже нулевые, ранг A < n
		if (A[i][i] == 0)
		{
			cout << "det(A) = 0" << endl << "No defined solution!" << endl;
			return;
		}

		// делим все элементы строки
		multiply_row(i, 1.0 / A[i][i]);

		// вычитаем из строк ниже iую строку
		for (int j = i + 1; j < n; j++)
			add_row(j, i, -A[j][i]);
	}

	// на данном этапе имеем верхнетреугольную матрицу A

	// нужно пройтись снизу вверх и вычесть из всех строк последнюю, предпоследнюю, ...
	for (int i = n - 1; i >= 0; i--) // >= можно заменить на >
		for (int j = 0; j < i; j++)
			add_row(j, i, -A[j][i]);

	// на данном этапе имеем диагональную матрицу A

	// записываем ответ
	for (size_t i = 0; i < n; i++)
		x[i] = y[i];
}

// возвращает индекс строки (среди [s; n-1]), в которой в столбце s макс. значение
int SlaeGaussSolver::get_maxabs_row(int s)
{
	int mr = s;

	for (int i = s + 1; i < n; i++)
		if (abs(A[i][s]) > abs(A[mr][s]))
			mr = i;

	return mr;
}