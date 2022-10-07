#!/usr/bin/env python
# coding: utf-8

# ## Ахметкин Олег Вадимович
# ### группа 21.Б06-пу

# # Вычисление элементарных функций с заданной точностью

# In[1]:


from math import factorial as fact
from math import pi, sin, atan, sqrt


# ### Реализация приближений функций sin(x), cos(x), arctg(x) с помощью рядов Тейлора

# In[2]:


def my_sin(x, eps=1e-6):
    x %= 2*pi
    
    sign = 1
    if x < 0:
        x *= -1
        sign = -1
        
    if x > pi/2:
        x = pi - x
        
    if x > pi/4:
        return my_cos(pi/2 - x)
        
    res = 0
    k = 0
    
    while True:
        s = ((-1)**k * x**(2*k + 1)) / fact(2*k + 1)
        res += s
        k += 1
        
        if abs(s) < eps:
            break
    
    return sign*res


# In[3]:


def my_cos(x, eps=1e-6):
    x %= 2*pi
    
    if x < 0:
        x *= -1
    
    sign = 1
    if x > pi/2:
        x = pi - x
        sign = -1
        
    if x > pi/4:
        return my_sin(pi/2 - x)
        
    res = 0
    k = 0
    
    while True:
        s = ((-1)**k * x**(2*k)) / fact(2*k)
        res += s
        k += 1
        
        if abs(s) < eps:
            break
    
    return sign*res


# In[4]:


def my_arctg(x, eps=1e-6):
    k = 0
    res = 0
    
    if abs(x) < 1:
        while True:
            s = ((-1)**k * x**(2*k + 1)) / (2*k + 1)
            res += s
            k += 1
            
            if abs(s) < eps:
                break
    elif abs(x) == 1:
        return pi/4 * (-1 + 2*(x > 0))
    else:
        res = pi/2 * (-1 + 2*(x > 0))
        while True:
            s = ((-1)**k * x**(-2*k - 1)) / (2*k + 1)
            res -= s
            k += 1
            
            if abs(s) < eps:
                break
    
    return res


# ### Реализация приближенного вычисления корня с помощью рекуррентной формулы Герона

# In[5]:


def my_sqrt(x, eps=1e-6):
    res = x
    prev_res = 0
    
    while True:
        prev_res = res
        res = 1/2 * (res + x/res)
        
        if abs(prev_res - res) < eps: # !!!
            break
    
    return res


# ## Решение задания №13
# 
# $ z(x) = arctg{\frac{\sqrt{0.9x + 1}}{(1 - x^2)}} + sin(3x + 0.6)$
# 
# $ x = 0.2(0.01)0.3 $

# ### Вычисление погрешностей
# 
# **Задача:** вычислить $ z(x) $ с точностью $ \varepsilon = 10^{-6} $
# 
# Положим $ z(x) = f(u, v), $ где
# 
# $ u(x) = \frac{\sqrt{0.9x + 1}}{(1 - x^2)} $,
# 
# $ v(x) = sin(3x + 0.6) $
# 

# Функции $ u(x), v(x) $ монотонны на $ x \in [0.2; 0.3] $
# 
# Также на этом интервале верно:
# 
# $ 1.1 \approx 1.132 < u(x) < 1.239 \approx 1.3 $
# 
# $ 0.9 \approx 0.932 < v(x) < 0.998 \approx 1 $

# Положим $ G = \{ (u, v) \space | \space 1.1 \leq u \leq 1.3, \space 0.9 \leq v \leq 1 \} $
# 
# Оценим в $ G $ частные производные:
# 
# $
# \frac{\partial f(u, v)}{\partial u} = \frac{1}{1 + u^2}; \space \space
# \frac{\partial f(u, v)}{\partial v} = 1
# $
# 
# $
# | \frac{\partial f(u, v)}{\partial u} | \leq 0.439 < 0.5; \space \space
# | \frac{\partial f(u, v)}{\partial v} | \leq 1
# $

# $
# \varepsilon_1 = \frac{10^{-6}}{1.5} \space для \space u(x) \\
# \varepsilon_2 = \frac{10^{-6}}{1} \space для \space v(x) \\
# \varepsilon_3 = \frac{10^{-6}}{3} \space для \space f(u, v) 
# $

# In[6]:


def my_f(x, eps1=1e-6, eps2=1e-6, eps3=1e-6):
    # u
    val1 = my_sqrt(0.9*x + 1, eps1)
    val2 = 1 - x**2
    
    # v
    sin_val = my_sin(3*x + 0.6, eps2)
    
    # f
    return my_arctg(val1 / val2, eps3) + sin_val


# In[7]:


def f(x):
    val1 = sqrt(0.9*x + 1)
    val2 = 1 - x**2
    arc_val = atan(val1 / val2)
    sin_val = sin(3*x + 0.6)
    
    return arc_val + sin_val


# In[8]:


start = 0.2
stop = 0.3
step = 0.01
eps = 1e-6

x = start

while round(x, 2) <= stop:
    my_val = my_f(x, eps)
    true_val = f(x)
    
    print(f'[x = {x:.2f}]:')
    print(f'My func: {my_val:.8f}')
    print(f'Py func: {true_val:.8f}')
    print(f'Error:   {abs(my_val - true_val):.8f}')
    print()
    x += step

