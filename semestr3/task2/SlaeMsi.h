#pragma once
#include "Slae.h"

class SlaeMsi : public Slae
{
public:
	SlaeMsi(int n, double mu_eps=10e-3, double eps = 10e-3, int iters_threshold = 1000, bool is_warn = false);
	void read_slae_from_file(const char* filename) override;
	void solve_slae() override;

	// вывести на экран матрицу B
	void print_B();

	// вывести на экран параметры (норма матрицы B, вектор c, mu_eps)
	void print_params();
protected:
	// макс. кол-во итераций
	int iters_threshold;
	bool is_need_warn;

	// величины для итераций
	double mu_epsilon = 10e-3;
	double** B = nullptr;
	double* c = nullptr;

	// позволенная погрешность отклоенения от правильного ответа
	double eps = 10e-3;
	
	// норма-1 матрицы
	double matrix_norm(double** mtx);

	// инициализировать значения (матрицу B, вектор c)
	void init_values();

	// возвращает приближение корня
	double* iter();

	// норма-1 вектора (a - b)
	double vec_sub(double* a, double* b);

	// транспонирование матрицы
	double** transponate(double** mtx);
};
