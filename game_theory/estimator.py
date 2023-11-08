from typing import List


def estimate(sol: List[tuple], n: int, m: int):
    '''
    Estimate solution for Job Shop Scheduling problem

    Params:
        sol - solution
        n - jobs count
        m - machines count
    '''

    k = 0
    time = 0

    while k < len(sol):
        step_time = 0
        jobs = [False for _ in range(n)]
        machines = [False for _ in range(m)]

        while k < len(sol):
            j, i, dur = sol[k]

            if jobs[j] or machines[i]:
                break
            
            jobs[j] = True
            machines[i] = True

            step_time = max(step_time, dur)
            k += 1

        time += step_time
    
    return time


if __name__ == '__main__':
    # (j, i, d) - job_j on machine_i for d time units
    solution_example = [(0, 0, 2), (0, 1, 4), (0, 0, 3), (1, 0, 1), (1, 1, 2)]
    time_est = estimate(solution_example, 2, 2)
    print(time_est)
