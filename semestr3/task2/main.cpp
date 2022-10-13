#include <iostream>
#include <fstream>
#include "SlaeGaussSolver.h"
#include "SlaeMsi.h"
#include <Windows.h>

using namespace std;

int main()
{
	// GOOD CONDITIONAL matrix
	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), 11);
	cout << "Solution for GOOD CONDITIONAL matrix:" << endl;
	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), 15);

	SlaeGaussSolver gauss1(3);
	gauss1.read_slae_from_file("slae1.txt");
	gauss1.print_slae();
	gauss1.solve_slae();
	cout << "Gauss solution: ";
	gauss1.print_solution();

	cout << endl;

	SlaeMsi msi1(3, 1e-3, 1e-4, 100);
	msi1.read_slae_from_file("slae1.txt");
	msi1.solve_slae();
	cout << "MSI solution: ";
	msi1.print_solution();


	
	// POOR CONDITIONAL matrix
	cout << "\n\n\n\n";
	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), 11);
	cout << "Solution for POOR CONDITIONAL matrix:" << endl;
	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), 15);

	double eps = 1e-3;

	SlaeGaussSolver gauss2(4);
	gauss2.read_slae_from_file("slae2.txt");
	gauss2.add_mtx(eps);
	gauss2.print_slae();
	gauss2.solve_slae();
	cout << "Gauss solution: ";
	gauss2.print_solution();

	cout << endl;

	SlaeMsi msi2(4, -0.12, 1e-5, 1000);
	msi2.read_slae_from_file("slae2.txt");
	msi2.add_mtx(eps);
	msi2.solve_slae();
	cout << "MSI solution: ";
	msi2.print_solution();

	cout << "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n";
	return 0;
}
