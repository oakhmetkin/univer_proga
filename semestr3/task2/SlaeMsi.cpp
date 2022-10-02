#pragma once
#include <iostream>
#include <windows.h>
#include "Slae.h"
#include "SlaeMsi.h"

using namespace std;

SlaeMsi::SlaeMsi(int n, double mu_eps, double eps, int iters_threshold) : Slae(n)
{
	this->iters_threshold = iters_threshold;
	this->eps = eps;
	this->mu_epsilon = mu_eps;

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
	int iters = 1;
	double* x_prev = x;
	x = iter();

	double m = matrix_norm(B) / (1 - matrix_norm(B));

	while (vec_norm(x_prev, x) * m > eps && iters < iters_threshold)
	{
		delete[] x_prev;
		x_prev = x;
		x = iter();
		
		iters++;
	}

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
			sum += abs(mtx[i][j]);

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

	init_values();
}

void SlaeMsi::init_values()
{
	mu = 2 / (matrix_norm(A) + mu_epsilon);

	for (size_t i = 0; i < n; i++)
		c[i] = mu * y[i];

	for (size_t i = 0; i < n; i++)
		for (size_t j = 0; j < n; j++)
			B[i][j] -= mu * A[i][j];
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

double SlaeMsi::vec_norm(double* a, double* b)
{
	double sum = 0;

	for (size_t i = 0; i < n; i++)
		sum += abs(a[i] - b[i]);

	return sum;
}

void SlaeMsi::print_params()
{
	cout << "\tmu = " << mu << endl;

	cout << "\tc = (";
	for (size_t i = 0; i < n; i++)
		if (i < n - 1) cout << c[i] << ", ";
		else cout << c[i] << ")" << endl;

	cout << "\t||B|| = " << matrix_norm(B) << endl;
	cout << "\tmu_eps = " << mu_epsilon << endl;
	cout << "\teps = " << eps << endl << endl;
}