#pragma once
#include "Slae.h"

class SlaeMsi : public Slae
{
public:
	SlaeMsi(int n, double mu_eps, double eps, int iters_threshold = 1000);
	void solve_slae() override;
	void print_B();
	void read_slae_from_file(const char* filename) override;
	void print_params();
protected:
	int iters_threshold = 50;
	double mu_epsilon = 10e-3;
	double mu = 0;
	double** B = nullptr;
	double* c = nullptr;
	double eps = 0;

	double matrix_norm(double** mtx);
	void init_values();
	double* iter();
	double vec_norm(double* a, double* b);
};
