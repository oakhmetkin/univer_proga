#include <iostream>
#include <fstream>
#include <Windows.h>
#include "Slae.h"

using namespace std;

Slae::Slae(int n)
{
	if (n <= 0)
		n = 1;

	this->n = n;

	A = new double* [n];
	for (size_t i = 0; i < n; i++)
	{
		A[i] = new double[n];

		for (size_t j = 0; j < n; j++)
			A[i][j] = 0;
	}

	y = new double[n];
	for (size_t i = 0; i < n; i++)
		y[i] = 0;

	x = new double[n];
	for (size_t i = 0; i < n; i++)
		x[i] = 0;
}

Slae::~Slae()
{
	for (size_t i = 0; i < n; i++)
		delete[] A[i];

	delete[] A;

	delete[] x;
	delete[] y;
}

void Slae::read_slae_from_file(const char* filename)
{
	ifstream fin(filename);

	if (!fin.is_open())
	{
		cout << "Open file error!" << endl;
		return;
	}

	try
	{
		// A:
		for (size_t i = 0; i < n; i++)
			for (size_t j = 0; j < n; j++)
				fin >> A[i][j];

		// y:
		for (size_t i = 0; i < n; i++)
			fin >> y[i];
	}
	catch (const std::exception&)
	{
		cout << "Read file error!" << endl;

		for (size_t i = 0; i < n; i++)
			for (size_t j = 0; j < n; j++)
				A[i][j] = 0;

		for (size_t i = 0; i < n; i++)
			y[i] = 0;
	}

	fin.close();
}

void Slae::print_slae(bool format_on)
{
	cout << "Extended matrix of SLAE:" << endl;

	for (size_t i = 0; i < n; i++)
	{
		for (size_t j = 0; j < n; j++)
		{
			if (format_on)
				printf("% 6.2f", A[i][j]);
			else
				cout << A[i][j] << "  ";
		}

		cout << "|  " << y[i] << endl;
	}

	cout << endl;
}

void Slae::print_solution()
{
	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), 10);

	cout << "x = (";

	for (size_t i = 0; i < n; i++)
	{
		cout << x[i];

		if (i < n - 1)
			cout << ", ";
	}

	cout << ")" << endl;

	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), 15);
}

void Slae::change_rows(int i, int j)
{
	double* row1 = A[i];
	A[i] = A[j];
	A[j] = row1;

	double yrow1 = y[i];
	y[i] = y[j];
	y[j] = yrow1;
}

void Slae::multiply_row(int i, double alpha)
{
	for (size_t j = 0; j < n; j++)
		A[i][j] *= alpha;

	y[i] *= alpha;
}

void Slae::add_row(int i, int j, double alpha)
{
	if (i < 0 || j < 0 || i >= n || j >= n)
	{
		cout << "Matrix size: " << n << 'x' << n << ", but (i; j) = (" << i << "; " << j << ")" << endl;
		return;
	}

	for (size_t k = 0; k < n; k++)
		A[i][k] += alpha * A[j][k];

	y[i] += alpha * y[j];
}

void Slae::add_mtx(double k)
{
	int N = 13; // индивидуальное число для каждого студента
	
	for (size_t i = 0; i < n; i++)
		for (size_t j = 0; j < n; j++)
			A[i][j] += k * N * (-1 + 2 * (i >= j));
}
