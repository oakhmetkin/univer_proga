#include <iostream>
#include <fstream>

using namespace std;

class SLAE
{
public:
	SLAE(int n)
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

	~SLAE()
	{
		for (size_t i = 0; i < n; i++)
			delete[] A[i];

		delete[] A;

		delete[] x;
		delete[] y;
	}

	// прочитать матрицу (и столбец y после матрицы) системы из файла
	void read_slae_from_file(const char* filename)
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

	// распечатать расширенную матрицу системы
	void print_slae()
	{
		cout << "Extended matrix of SLAE:" << endl;

		for (size_t i = 0; i < n; i++)
		{
			for (size_t j = 0; j < n; j++)
			{
				cout << A[i][j] << "  ";
			}

			cout << "|  " << y[i] << endl;
		}

		cout << endl;
	}

	// решить систему точным методом Гаусса
	void solve_gauss()
	{
		for (size_t i = 0; i < n; i++)
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
			multiply_row(i, 1.0/A[i][i]);

			// вычитаем из строк ниже iую строку
			for (size_t j = i + 1; j < n; j++)
				add_row(j, i, -A[j][i]);
		}

		// на данном этапе имеем верхнетреугольную матрицу A

		// нужно пройтись снизу вверх и вычесть из всех строк последнюю, предпоследнюю, ...
		for (int i = n - 1; i >= 0; i--) // >= можно заменить на >
			for (size_t j = 0; j < i; j++)
				add_row(j, i, -A[j][i]);

		// на данном этапе имеем диагональную матрицу A

		// записываем ответ
		for (size_t i = 0; i < n; i++)
			x[i] = y[i];
	}

	// распечатать решение
	void print_solution()
	{
		cout << "x = (";

		for (size_t i = 0; i < n; i++)
		{
			cout << x[i];

			if (i < n - 1)
				cout << ", ";
		}

		cout << ")" << endl;
	}

//private:
	double** A = nullptr; // матрица системы
	double* x = nullptr; // столбец-решение системы
	double* y = nullptr; // столбец свободных членов системы
	int n = 0; // размер квадратной матрицы A

	// поменять i, j строчки местами
	void change_rows(int i, int j)
	{
		double* row1 = A[i];
		A[i] = A[j];
		A[j] = row1;

		double yrow1 = y[i];
		y[i] = y[j];
		y[j] = yrow1;
	}

	// домножить i строчку на скаляр
	void multiply_row(int i, double alpha)
	{
		for (size_t j = 0; j < n; j++)
			A[i][j] *= alpha;

		y[i] *= alpha;
	}

	// прибавить к i строчке j строчку, домжноженную на скаляр
	void add_row(int i, int j, double alpha)
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

	// возвращает индекс строки (среди [s; n-1]), в которой в столбце s макс. значение
	int get_maxabs_row(int s)
	{
		int mr = s;

		for (size_t i = s + 1; i < n; i++)
			if (abs(A[i][s]) > abs(A[mr][s]))
				mr = i;

		return mr;
	}
};

int main()
{
	SLAE slae(3);

	// считаем систему из файла
	slae.read_slae_from_file("slae1.txt");
	slae.print_slae();

	// решаем систему
	slae.solve_gauss();
	slae.print_slae();
	slae.print_solution();

	return 0;
}
