%   Load sound file
path = input('Enter the full path of the file including extension with quotations ');
[xin, fs] = audioread(path);
sound(xin(:,2),fs);

channel = input('Enter number of channel ');

sigma=input('Enter the value of sigma for noise ');

% 
% 
% t = linspace(0, 5,Fs);
% x = x'.*200000;
% sound(x);
% figure
% plot(t, x);
% 
% %   Channel creation
% chan1 = zeros(1, length(x));
% chan1(1) = 1;
% 
% chan2 = exp(-2*pi.*5000*t);
% chan3 = exp(-2*pi.*1000*t);
% chan4 = chan1; chan4(end) = 0.5; chan4(1) = 2;
% 
% %   Channel convolution 
% x_1 = conv(x,chan1);
% t_1 = linspace(0, 5, length(x_1));
% figure
% plot(t_1, x_1)