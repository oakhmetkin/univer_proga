from pulp import LpVariable, lpSum, LpMinimize, LpProblem, value, PULP_CBC_CMD
import random
from estimator import estimate


def solve_jsp(n, m, processing_times, verbose=False):
    problem = LpProblem("Job_Shop_Scheduling", LpMinimize)
    times = n

    x = LpVariable.dicts(
        "x", ((j, i, k) \
              for j in range(n)
              for i in range(m) \
              for k in range(times)), 
        cat="Binary"
        )

    # target function for minimization problem
    problem += lpSum(
        processing_times[j][i] * x[j, i, k] \
            for j in range(n) for i in range(m) for k in range(times)
        ), "Objective"

    # each job j on each machine i is being done only once
    for j in range(n):
        for i in range(m):
            problem += lpSum(
                x[j, i, k] for k in range(times)
                ) == 1, f"Job_{j}_one_time_on_Machine_{i}_constraint"

    # each machine i at each moment k does only 1 job
    for i in range(m):
        for k in range(times):
            problem += lpSum(
                x[j, i, k] for j in range(n)
                ) == 1, f"Machine_{i}_Job_{k}_constraint"

    problem.solve(PULP_CBC_CMD(msg=0))

    # results
    if value(problem.objective) is not None:
        sol = []
        
        if verbose:
            print("Optimal Schedule:")

        for j in range(n):
            for i in range(m):
                for k in range(times):
                    if (j, i, k) not in x:
                        continue

                    if value(x[j, i, k]) == 1:
                        if verbose:
                            print(f"Job {j} on Machine {i} at Time {k} --- {processing_times[j][i]}")
                        sol.append((k, j, i, processing_times[j][i]))

        
        # вернем решение в привычном формате
        if sol:
            sol.sort(key=lambda x: x[0])
            sol = [s[1:] for s in sol]
        return sol
    else:
        if verbose:
            print('No optimal solution')
        return None


if __name__ == '__main__':
    n, m = 7, 2

    # generate random Job Shop scheduling task
    random.seed(42)
    sol = []
    processing_times = []

    for j in range(n):
        l = []
        for i in range(m):
            t = random.randint(1, 7)
            sol.append((j, i, t))
            l.append(t)
        processing_times.append(l)
    
    print(len(sol), sol)

    # not optimal solution
    print('Old time:', estimate(sol, n, m))

    # solution from MILP
    random.seed(42)
    best_sol = solve_jsp(n, m, processing_times, verbose=True)
    if not best_sol:
        print('No optimal solution')
    print('Best time:', estimate(best_sol, n, m))
    print(len(best_sol), best_sol)
    print()
