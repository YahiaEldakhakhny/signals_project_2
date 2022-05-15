%   Load sound file
path = input('Enter the full path of the file including extension with quotations ');
[xin, fs] = audioread(path);
x = xin(:,1);
sound(x,fs);

channel = input('Enter number of channel ');

sigma=input('Enter the value of sigma for noise ');


%transmiting


t_end = length(x)./fs;
t = linspace(0,t_end, length(x));


xf = fftshift(fft(x));
xmag = abs(x);
phase = angle(x);
N = length(x);
f = linspace(-fs/2,fs/2,N);



figure(1)
subplot(3,1,1)
plot(t,x)
title('Signal in time domain')

subplot(3,1,2)
plot(fvec,xmag)
title('Signal Magnitude in frequency domain')

subplot(3,1,3)
plot(fvec,phase)
title('Signal Phase in frequency domain')



% 2) Channel
% 1)delta

if (channel ==1)
    H1 = [1 zeros(1,N-1)];
    y = conv(x,H1);

    t_end = length(y)./fs;
    t_conv = linspace(0,t_end, length(y));
    
end

% 2) exp(-2pi*5000t) 

if (channel == 2)
    H2 = exp(-2*pi*5000*t);
    y = conv(x,H2);
    
    t_end = length(y)./fs;
    t_conv = linspace(0,t_end, length(y));
 
end

% 3) exp(-2pi*1000t) 

if(channel == 3)
    H3 = exp(-2*pi*1000*t);
    y = conv(x,H3);
    
    t_end = length(y)./fs;
    t_conv = linspace(0,t_end, length(y));
   
end

% 4) The channel has the following impulse response

if (channel == 4)
    H4 = [2 zeros(1,1*fs -2) 1];
    y = conv(x,H4);
    
    t_end = length(y)./fs;
    t_conv = linspace(0,t_end, length(y));
end

% Ploting

figure(2)
subplot(3,1,1)
plot(t_conv, y)
title('Signal in time domain after Channel')

Y = fftshift(fft(y));
Ymg = abs(Y);
Yphase = angle(Y);
N = length(Y);
fvec = linspace(-fs/2,fs/2,N);

subplot(3,1,2)
plot(fvec, Ymg)
title('Signal Magnitude in freq. domain after Channel ')

subplot(3,1,3)
plot(fvec, Yphase)
title('Signal phase in freq. domain after Channel ')

% 3)Noise


z = sigma*randn(length(x),1);
noiseSignal = y(1:length(x)) + z;
x = noiseSignal;

t_endN=length(x)./fs;
t=linspace(0,t_endN,length(x));





