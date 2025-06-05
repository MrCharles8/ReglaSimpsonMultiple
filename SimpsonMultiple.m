clc; clear; close all;

% Definir la función f(x)
f = @(x) 0.2 + 25*x - 200*x.^2 + 675*x.^3 - 900*x.^4 + 400*x.^5;

% Intervalo
a = 0;
b = 0.8;

% Valor exacto conocido
valor_real = 1.640533;

% Número de subintervalos (debe ser par)
n = 6;
if mod(n,2) ~= 0
    error('El número de subintervalos (n) debe ser par para Simpson 1/3.');
end

% Paso
h = (b - a)/n;

% Puntos xi
x = a:h:b;

% Evaluación de la función en los puntos
y = f(x);

% Simpson 1/3 compuesta
I_aprox = (h/3) * (y(1) + 4*sum(y(2:2:end-1)) + 2*sum(y(3:2:end-2)) + y(end));

% Cálculo simbólico de la cuarta derivada
syms xs
f_sym = 0.2 + 25*xs - 200*xs^2 + 675*xs^3 - 900*xs^4 + 400*xs^5;
f4_sym = diff(f_sym, xs, 4);
f4_fun = matlabFunction(f4_sym);

% Valor medio de la cuarta derivada
media_f4 = integral(f4_fun, a, b) / (b - a);

% Error de truncamiento estimado
E_t = -((b - a)^5 / (180 * n^4)) * media_f4;

% Error relativo porcentual
error_porcentual = abs((valor_real - I_aprox) / valor_real) * 100;

% Resultados
fprintf('=== Simpson 1/3 Compuesta con n = %d ===\n', n);
fprintf('Integral aproximada        : %.6f\n', I_aprox);
fprintf('Media de f''''(x)            : %.6f\n', media_f4);
fprintf('Error de truncamiento       : %.6f\n', E_t);
fprintf('Error relativo porcentual   : %.4f%%\n', error_porcentual);