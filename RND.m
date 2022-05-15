%   Load sound file

% Get the path of the sound file from user
clc 
clear sound;
path = input('Enter the full path of the file including extension with quotations ');

% Get the array of sound samples and frequency
[xin, fs] = audioread(path);

% Taking first channel of sound file
x = xin(:,1);




% Transmiting
len_x=length(x);

% Getting end time by multiplying 1/frequency by the number of samples 
t_end = len_x./fs;

% Generate time space
t = linspace(0,t_end, len_x);


% Transfer to frequency domain 

% Shift
xf = fftshift(fft(x));
% getting magnitude
xmag = abs(xf);
% getting phase
xphase = angle(xf);
% getting length of the signal
N = length(xf);
% generate frequency space to plot with
f = linspace(-fs/2,fs/2,N);


% Plot signal with time domain
figure(1)
subplot(4,1,1)
plot(t,x)
title('Signal in time domain')

% Plot Magnitude with frequency domain
subplot(4,1,2)
plot(f,xmag)
title('Signal Magnitude in frequency domain')

% Plot Phase with frequency domain
subplot(4,1,3)
plot(f,xphase)
title('Signal Phase in frequency domain')

% Plot signal with frequency domain
subplot(4,1,4)
plot(f,xf)
title('Signal in frequency domain')



%play sound file 
sound(x,fs);
disp("press any key to stop sound and resume code ")
pause();
clear sound;

% Take the num of the cahnnel to send the sound on
channel = input('Enter number of channel ');




% 2) Channel

% 1)delta

if (channel ==1)
    % generate impulse response
    H1 = [1 zeros(1,N-1)];
    y = conv(x,H1);
    len_y=length(y);
    t_end = len_y./fs;
    t = linspace(0,t_end, len_y);
    % the output signal is the same as the input

end

% 2) exp(-2pi*5000t) 

if (channel == 2)
    % generate impulse response
    H2 = exp(-2*pi*5000*t);
    % Transimiting done by convulution between impulse response and input
    % signal
    y = conv(x,H2);
    len_y=length(y);
    t_end = len_y./fs;
    t = linspace(0,t_end, len_y);
 % the system amplifies the signal volume by approximately 2
end

% 3) exp(-2pi*1000t) 

if(channel == 3)
    H3 = exp(-2*pi*1000*t);
    y = conv(x,H3);
    len_y=length(y);
    t_end = len_y./fs;
    t = linspace(0,t_end, len_y);
   
end
% the system amplifies the signal volume by approximately 4

% 4) The channel has the following impulse response

if (channel == 4)
    H4 = [2 zeros(1,1*fs -2) 0.5];
    y = conv(x,H4);
    
    len_y=length(y);
    t_end = len_y./fs;
    t = linspace(0,t_end, len_y);
    % the system the signal overlab due to shift of the second delta

end

% Ploting

figure(2)
subplot(4,1,1)
plot(t, y)
title('Signal in time domain after Channel')

yf = fftshift(fft(y));
ymag = abs(yf);
yphase = angle(yf);
N = length(yf);
f = linspace(-fs/2,fs/2,N);

subplot(4,1,2)
plot(f, ymag)
title('Signal Magnitude in freq. domain after Channel ')

subplot(4,1,3)
plot(f, yphase)
title('Signal phase in freq. domain after Channel ')

% Plot signal with frequency domain
subplot(4,1,4)
plot(f,yf)
title('Signal in frequency domain')


sound(y,fs);
disp("press any key to stop sound and resume code ")
pause();
clear sound;



% sigma value of the noise
sigma=input('Enter the value of sigma for noise ');



% 3)Noise

% Generate
z = sigma*randn(len_y,1);

% Add
y = y + z';


figure(3)
subplot(3,1,1)
plot(t,y)
title('sound file after adding noise in time domain')


% transfer to freq
yf = fftshift(fft(y));
ymag = abs(yf);
N = length(yf);
f = linspace(-fs/2,fs/2,N);

% plot Magnitude with frequency
subplot(3,1,2)
plot(f,ymag)
title('sound file after adding noise in frequency domain')

% Plot signal with frequency domain
subplot(3,1,3)
plot(f,yf)
title('Signal in frequency domain')

sound(y,fs);
disp("press any key to stop sound and resume code ")
pause();
clear sound;
% Plot with time

% 4) Receiver
N = length(y);
n = N/fs;
right_band = round((fs/2-3400)*n);
left_band = (N-right_band+1);
yf([1:right_band left_band:N]) = 0;

y = real(ifft(ifftshift(yf)));



% plot the sound file at receiver in time domain
figure(4)
subplot(4,1,1)
plot(t,y)
title('sound file at receiver in time domain')


% plot the sound file at receiver in frequency
ymag=abs(yf);
yphase = angle(yf);
f=linspace(-fs/2,fs/2,N);


subplot(4,1,2)
plot(f,ymag)
title('Magnitude of sound file at receiver in frequency domain')

subplot(4,1,3)
plot(f,yphase)
title('Phase pf sound file at receiver in frequency domain')
% Plot signal with frequency domain
subplot(4,1,4)
plot(f,yf)
title('Signal in frequency domain')


sound(y,fs);
disp("press any key to stop sound and resume code ")
pause();
clear sound;