clc;
clear all;
format long


data = readtable('Options_R_matlab.csv');

[MAE, MSE, RMSE, R2] = calculator(data, 100000);