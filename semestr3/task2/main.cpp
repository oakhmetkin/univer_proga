#include <iostream>
#include <fstream>
#include "SlaeGaussSolver.h"
#include "SlaeMsi.h"

using namespace std;

int main()
{
	SlaeGaussSolver slae(3);
	slae.read_slae_from_file("slae1.txt");
	slae.print_slae();
	slae.solve_slae();
	cout << "Gauss solution: ";
	slae.print_solution();

	cout << endl << endl;

	SlaeMsi msi(3, 0.001, 0.1, 100);
	msi.read_slae_from_file("slae1.txt");
	cout << "MSI parameters:" << endl;
	msi.print_params();

	msi.solve_slae();
	cout << "MSI solution: ";
	msi.print_solution();

	return 0;
}
