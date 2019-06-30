clc;
clear all;
format long

% Input files
input_file_options  = 'Options_Matlab.csv';
fid = fopen(input_file_options, 'r');
formatSpec = '%s; \n';
header = fscanf(fid, formatSpec);
formatSpec1 = '%s %f %s %f %f %f %f %f\n';
option_data = textscan(fid, formatSpec1, 'Delimiter',',');
fclose(fid);

% Assign necessary variable matrix
maturity = option_data{2}/365;
option = option_data{3};
strike_price = option_data{4};
volatility = round(option_data{5},4);
stock_price = option_data{6};
rate = option_data{7};
option_value = option_data{8};

%option_chr = convertStringsToChars(option);
true = option_value(1:2700, 1);

for r = 1:2700
    value(r) = get_option_value(option{r},stock_price(r),maturity(r),volatility(r),strike_price(r),rate(r),1000);
end

%value_true = option_value(1:2747);

mean_absolute_error = sum(abs(value'-true))/numel(value')
mse = immse(value',true)
rmse = sqrt(immse(value',true))

correlation_coeff = corr2(value',true);
r_sqr = power(correlation_coeff,2)

%mae=sum(abs(x(:)-y(:)))/numel(x);

% true2 = option_value(2501:5500, 1);
% for r = 2501:5500
%     value2(r) = get_option_value(option{r},stock_price(r),maturity(r),volatility(r),strike_price(r),rate(r),1000);
% end
% err2 = immse(value2', true2)

%row=3;
%[y] = get_option_value(option{row},stock_price(row),maturity(row),volatility(row),strike_price(row),rate(row),1000);
%y

%option_value(row)




