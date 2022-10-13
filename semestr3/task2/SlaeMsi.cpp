#pragma once
#include <iostream>
#include <windows.h>
#include "Slae.h"
#include "SlaeMsi.h"

using namespace std;

SlaeMsi::SlaeMsi(int n, double mu_eps, double eps, int iters_threshold, bool is_warn) : Slae(n)
{
	this->iters_threshold = iters_threshold;
	this->eps = eps;
	this->mu_epsilon = mu_eps;
	this->is_need_warn = is_warn;

	B = new double* [n];

	for (size_t i = 0; i < n; i++)
	{
		B[i] = new double[n];

		for (size_t j = 0; j < n; j++)
			B[i][j] = (i == j);
	}

	c = new double[n];
}

void SlaeMsi::solve_slae()
{
	SlaeMsi::init_values();

	double b_norm = matrix_norm(B);

	// проверка нормы матрицы B
	if (b_norm >= 1 && is_need_warn)
	{
		SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), 12);
		cout << "Warning:  ||B|| = " << b_norm << endl;
		SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), 15);
	}

	int iters = 0;
	double* x_prev = x;
	x = iter();

	double m = b_norm / (1 - b_norm);
	//cout << "stop crit: " << m << endl;

	// продолжаем итерационный процесс пока не достигнем нужной точности
	// или не превысим порог кол-ва итераций
	while (iters < iters_threshold &&
		(vec_sub(x_prev, x) * m > eps || // условие, если матрица B "хорошая"
		b_norm >= 1 && vec_sub(x_prev, x) > eps)) // условие, если матрица B плохо обусловленная
	{
		delete[] x_prev;
		x_prev = x;
		x = iter();

		iters++;
	}

	// сообщаем о превышении кол-ва итераций
	if (iters >= iters_threshold)
	{
		SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), 12);
		cout << "Too many iterations (" << iters_threshold << ")!!!" << endl;
		SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), 15);
	}
	else
		cout << "iters: " << iters << endl;
}

double SlaeMsi::matrix_norm(double** mtx)
{
	double max_sum = 0;

	for (size_t j = 0; j < n; j++)
	{
		double sum = 0;

		for (size_t i = 0; i < n; i++)
			sum += abs(mtx[i][j]); // [i][j] - 1, [j][i] - inf

		max_sum = max(max_sum, sum);
	}

	return max_sum;
}

void SlaeMsi::print_B()
{
	for (size_t i = 0; i < n; i++)
	{
		for (size_t j = 0; j < n; j++)
		{
			cout << B[i][j] << "  ";
		}

		cout << endl;
	}
}

void SlaeMsi::read_slae_from_file(const char* filename)
{
	Slae::read_slae_from_file(filename);

	/*init_values();*/
}

void SlaeMsi::init_values()
{
	double mu = 1 / (matrix_norm(A) + mu_epsilon);

	for (int i = 0; i < n; i++)
		for (int j = 0; j < n; j++)
			B[i][j] = (i == j) - mu * A[i][j];

	for (size_t i = 0; i < n; i++)
		c[i] = mu * y[i];
	

	bool not_simm = false;

	for (size_t i = 0; i < n; i++)
		for (size_t j = i + 1; j < n; j++)
			if (A[i][j] != A[j][i])
			{
				not_simm = true;
				break;
			}

	// если матрица A не явл. симметрической, то нужно выполнить преобразования
	if (not_simm)
	{
		double** AT = transponate(A); // A транспонированное

		double** res = new double* [n];
		for (size_t i = 0; i < n; i++)
			res[i] = new double[n];

		for (size_t i = 0; i < n; i++)
			for (size_t j = 0; j < n; j++)
			{
				double s = 0;

				for (size_t k = 0; k < n; k++)
					s += AT[i][k] * A[k][j];

				res[i][j] = s;
			}

		double* new_y = new double[n];
		for (size_t i = 0; i < n; i++)
		{
			double s = 0;

			for (size_t k = 0; k < n; k++)
				s += AT[i][k] * y[k];

			new_y[i] = s;
		}
		delete[] y;
		y = new_y;

		for (size_t i = 0; i < n; i++)
		{
			delete[] AT[i];
			delete[] A[i];
		}
		delete[] A;
		delete[] AT;

		A = res;


		mu = 1 / (matrix_norm(A) + mu_epsilon);

		for (int i = 0; i < n; i++)
			for (int j = 0; j < n; j++)
				B[i][j] = (i == j) - mu * A[i][j];

		for (size_t i = 0; i < n; i++)
			c[i] = mu * y[i];
	}
}

double* SlaeMsi::iter()
{
	double* x_new = new double[n];

	// x_new = B*x + c
	for (size_t i = 0; i < n; i++)
	{
		double s = 0;

		for (size_t j = 0; j < n; j++)
			s += B[i][j] * x[j];

		x_new[i] = s + c[i];
	}

	return x_new;
}

double SlaeMsi::vec_sub(double* a, double* b)
{
	double sum = 0;

	for (size_t i = 0; i < n; i++)
		sum += abs(a[i] - b[i]);

	return sum;
}

void SlaeMsi::print_params()
{
	cout << "MSI parameters:" << endl;

	cout << "\tc = (";
	for (size_t i = 0; i < n; i++)
		if (i < n - 1) cout << c[i] << ", ";
		else cout << c[i] << ")" << endl;

	cout << "\t||B|| = " << matrix_norm(B) << endl;
	cout << "\tmu_eps = " << mu_epsilon << endl;
	cout << "\teps = " << eps << endl << endl;
}

double** SlaeMsi::transponate(double** mtx)
{
	double** t = new double* [n];

	for (size_t i = 0; i < n; i++)
	{
		t[i] = new double[n];

		for (size_t j = 0; j < n; j++)
			t[i][j] = mtx[j][i];
	}

	return t;
}