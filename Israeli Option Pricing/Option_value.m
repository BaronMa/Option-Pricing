clc;
clear all;
format long


data = readtable('Options_R_matlab.csv');

% Assign necessary variable matrix
maturity = data{:, {'maturity'}}/365;
option = data{:, {'cp_flag'}};
strike_price = data{:,{'strike_price'}};
volatility = round(data{:, {'impl_volatility'}},4);
stock_price = data{:, {'underlying_price'}};
rate = data{:, {'interest_rate'}};
option_value = data{:, {'best_offer'}};


%get_option_value(option{2},stock_price(2),maturity(2),volatility(2),strike_price(2),rate(2),1000)

%value = get_option_value(option{1},stock_price(1),maturity(1),volatility(1),strike_price(1),rate(1),1000);

%get_option_value('put', 58.75, 0.047, 1.84, 20, 0.0008, 1000)

true = option_value(1:20000);

for r = 1:20000
    value(r) = get_option_value(option{r},stock_price(r),maturity(r),volatility(r),strike_price(r),rate(r),1000);
end

j = 1;
for i = 1:20000
    if ~ismissing(value(i))
        true_1(j) = true(i);
        value_1(j) = value(i);
        j = j + 1;
    end
end

mean_absolute_error = sum(abs(value_1-true_1))/numel(value_1)
mse = immse(value_1,true_1)
rmse = sqrt(immse(value_1,true_1))

correlation_coeff = corr2(value_1,true_1);
r_sqr = power(correlation_coeff,2)


