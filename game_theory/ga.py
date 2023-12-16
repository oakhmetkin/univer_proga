from math import ceil
import random
from functools import cmp_to_key
from estimator import estimate


def lst_sum(lists):
    '''
    sum of lists
    '''
    l = []

    for lst in lists:
        l += lst

    return l


def full_shuffle(lst):
    '''
    return new list with shuffled items
    '''
    return sorted(lst, key=lambda x: random.random())


def parts_shuffle(lst, size, count=5):
    '''
    lst - list
    size - size of one part
    count - count of shuffles
    '''

    l = len(lst)
    parts_count = ceil(l / size)
    parts = []

    for i in range(parts_count):
        st = i*size
        end = min((i+1)*size, l)
        parts.append(lst[st:end])
    
    shuffled_sols = [lst_sum(full_shuffle(parts)) for _ in range(count)]

    return shuffled_sols


def sign(x):
    if x == 0: return 0
    return -1 if x < 0 else 1
 

def compare(l, r):
    if l[0] == r[0]:
        return sign(l[3] - r[3])
    else:
        return 0


def genetic_search(
        sol, 
        n, 
        m, 
        epoches=5, 
        levels=4, 
        alive=10, 
        count=5, 
        early_stopping=None,
        verbose=True):
    '''
    Search optimal solution for Job Shop Scheduling problem.
    It is based on genetic algorithm with random mutations.

    Params:
        sol - start solution
        n - jobs count
        m - machines count
        epoches - epoches count (mutations for each solution)
        levels - part separating levels (half, third, quarter, ...)
        alive - alive solution after each epoch
        count - parts shuffle count
        early_stopping - if not None, then stop after early_stopping same \
            best solutions
    '''
    solutions = [sol]
    l = len(sol)
    best_times = []

    for epoch in range(epoches):
        new_sols = []
        
        for sol in solutions:
            for lvl in range(levels):
                size = ceil(l / (lvl + 2))
                candidates = parts_shuffle(sol, size, count)

                for c in candidates:
                    c = sorted(c, key=cmp_to_key(compare))

                new_sols.extend(candidates)
            
            new_sols.append(sorted(full_shuffle(sol), key=cmp_to_key(compare)))
        
        solutions.extend(new_sols)

        solutions = sorted(
            list(set([tuple(s) for s in solutions])),
            key=lambda x: estimate(x, n, m)
        )[:min(alive, len(solutions))]

        best_est = estimate(solutions[0], n, m)
        best_times.append(best_est)

        if isinstance(verbose, bool) and verbose:
            print(f'Epoch: {epoch+1}/{epoches}; Best sol: {best_est}')
        elif isinstance(verbose, int) and \
            verbose > 0 and \
            (epoch + 1) % verbose == 0:
            print(f'Epoch: {epoch+1}/{epoches}; Best sol: {best_est}')

        if early_stopping and len(best_times) > early_stopping:
            last = best_times[len(best_times)-early_stopping:]
            last = [b - last[-1] for b in last]

            if any(last):
                pass
            else:
                if verbose:
                    print('Early stopping!')
                break
    
    return solutions[0], best_times


if __name__ == '__main__':
    n, m = 20, 20

    # generate random Job Shop scheduling task
    random.seed(42)
    sol = []

    for j in range(n):
        idxs = [k for k in range(m)]
        for i in range(m):
            sol.append((j, i, random.randint(1, 7), idxs.pop(random.randint(0, len(idxs) - 1))))
    
    sol.sort(key=cmp_to_key(compare))

    # not optimal solution
    print('Old time:', estimate(sol, n, m))

    # solution from GA
    random.seed(42)
    best_sol, best_times = genetic_search(
        sol, n, m, epoches=1000, levels=5, alive=16, count=3,
        early_stopping=50, verbose=10
        )
    print('Best time:', estimate(best_sol, n, m))
    print(best_sol)
    print()
