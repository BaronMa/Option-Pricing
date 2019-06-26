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
volatility = option_data{5};
stock_price = option_data{6};
rate = option_data{7};
option_value = option_data{8};

%option_chr = convertStringsToChars(option);
length(option_data{1})


for r = 1:length(option_data{1})
    value(r) = get_option_value(option{r},stock_price(r),maturity(r),volatility(r),strike_price(r),rate(r),1000);
end


row=3;
[y] = get_option_value(option{row},stock_price(row),maturity(row),volatility(row),strike_price(row),rate(row),1000);
y

option_value(row)




