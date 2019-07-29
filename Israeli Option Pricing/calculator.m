function [mean_absolute_error, mse, rmse, r_sqr] = calculator(s, N)

data_sample = datasample(s, N, 'Replace', false);

% Assign necessary variable matrix
maturity = data_sample{:, {'maturity'}}/365;
option = data_sample{:, {'cp_flag'}};
strike_price = data_sample{:,{'strike_price'}};
volatility = round(data_sample{:, {'impl_volatility'}},4);
stock_price = data_sample{:, {'underlying_price'}};
rate = data_sample{:, {'interest_rate'}};
option_value = data_sample{:, {'best_offer'}};

%true = option_value(1:20000);

for r = 1:N
    value(r) = get_option_value(option{r},stock_price(r),maturity(r),volatility(r),strike_price(r),rate(r),1000);
end

j = 1;
for i = 1:N
    if ~ismissing(value(i))
        true(j) = option_value(i);
        value_1(j) = value(i);
        j = j + 1;
    end
end

mean_absolute_error = sum(abs(value_1-true))/numel(value_1)
mse = immse(value_1,true)
rmse = sqrt(immse(value_1,true))

correlation_coeff = corr2(value_1,true);
r_sqr = power(correlation_coeff,2)