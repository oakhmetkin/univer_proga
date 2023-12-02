# # Example:
# # Job 1: 
# #   - Operation 1 - 3 ед. вр. - Machine A
# #   - Operation 2 - 2 ед. вр. - Machine B.

# # Job 2: 
# #   - Operation 1 - 2 ед. вр. - Machine B
# #   - Operation 2 - 4 ед. вр. - Machine A.


# schedule = []

# job1 = {
#     0: [1, 2, 3],
#     1: [4, 5],
#     2: [7, 8, 5],
#     3: [3],
# }

# print('machine indexes:', job1.keys())
# print('for each machine operations and theirs durations:', job1)


import numpy as np


A = np.array([
    [0, 1, 0, 0],
    [0, 0, 1, 0],
    [0, 0, 0, 1],
    [1, 0, 0, 0],
])

B = np.array([1, 0, 1, 0]).T

print(A @ B)
print(A @ A @ B)
print(A @ A @ A @ B)




# from copy import deepcopy


# class Machine:

#     def __init__(self, jobs: list):
#         self.__jobs = deepcopy(jobs)

#     def refresh(self):
#         self.jobs = self.__jobs

#     def pick(self):
#         if self.jobs:
#             return self.jobs[0]
        
#         raise Exception('self.jobs = [] !!!')
    
#     def pop(self):
#         if self.jobs:
#             return self.jobs.pop(0)
        
#         raise Exception('self.jobs = [] !!!')

#     def is_running(self):
#         return len(self.jobs) > 0
