import random
from pulp import LpVariable, lpSum, LpMaximize, LpProblem, LpStatus


def solve_jsp(num_jobs, processing_times):
    num_machines = len(processing_times[0])  # Количество машин

    # Создаем LP проблему
    problem = LpProblem("Job_Shop_Scheduling", LpMaximize)

    # Создаем переменные решения
    x = LpVariable.dicts("x", ((i, j, k) for i in range(num_jobs) for j in range(num_machines) for k in range(num_jobs)),
                         cat="Binary")

    # Определение целевой функции
    problem += lpSum(x[i, j, k] for i in range(num_jobs) for j in range(num_machines) for k in range(num_jobs)), "Objective"

    # Ограничения для каждой задачи
    for i in range(num_jobs):
        problem += lpSum(x[i, j, k] for j in range(num_machines) for k in range(num_jobs)) == 1, f"Job_{i}_constraint"

    # Ограничения для каждой машины
    for j in range(num_machines):
        for k in range(num_jobs):
            problem += lpSum(x[i, j, k] for i in range(num_jobs)) == 1, f"Machine_{j}_Job_{k}_constraint"

    # Ограничения времени выполнения
    M = num_jobs * sum(max(processing_times[i][j] for j in range(num_machines)) for i in range(num_jobs))
    for i in range(num_jobs):
        for j in range(num_machines):
            for k in range(num_jobs):
                problem += k - lpSum(t * x[i, j, t] for t in range(num_jobs)) >= processing_times[i][j] - M * (1 - x[i, j, k]), f"Job_{i}_Machine_{j}_time_constraint_{k}"

    # Решение проблемы
    problem.solve()

    # Вывод результатов
    if LpStatus[problem.status] == 'Optimal':
        schedule = [[[int(x[i, j, k].varValue) for k in range(num_jobs)] for j in range(num_machines)] for i in range(num_jobs)]
        return schedule
    else:
        print("Решение не найдено.")


n, m = 10, 2
# generate random Job Shop scheduling task
random.seed(42)
sol = []
processing_times = []

for j in range(n):
    pj = []
    for i in range(m):
        r = random.randint(1, 7)
        pj.append(r)
        sol.append((j, i, r))
    processing_times.append(pj)

result = solve_jsp(n, processing_times)
print(result)
