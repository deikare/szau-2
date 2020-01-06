clear;
close all;

consts;

u_ucz = init_u(n, n_op, umin, umax, u0, shift, seed_ucz);
u_wer = init_u(n, n_op, umin, umax, u0, shift, seed_wer);

[x1_ucz, x2_ucz, y_ucz] = getModel(u_ucz, n_op, x1_0, x2_0, y0, alfa1, alfa2, beta1, beta2);
[x1_wer, x2_wer, y_wer] = getModel(u_wer, n_op, x1_0, x2_0, y0, alfa1, alfa2, beta1, beta2);

[ustat, ystat] = char_stat(umin, umax, alfa1, alfa2, beta1, beta2);

charStatPlotter(ustat, ystat, 'directory here', 'filename here');

serialize('II/dane.txt', u_ucz, y_ucz);
serialize('II/dane_weryfikujace.txt', u_wer, y_wer);

dataPlotter(u_ucz, y_ucz, u_wer, y_wer, 'directory here', 'filename here');
