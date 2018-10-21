fs = 44100; % sampling frequency (Hz)
t = 0 : 1/fs : 1; % time axis (seconds)
f1 = 440; % frequency (Hz)
f2 = 2 * f1
f3 = 3 * f1;
f4 = 4 * f1;
A1 = .3; A2 = A1/2; A3 = A1/3; A4 = A1/4;
w = 0; % phase

y1 = A1 * sin( 2 * pi * f1 * t + w );
y2 = A2 * sin( 2 * pi * f2 * t + w );
y3 = A3 * sin( 2 * pi * f3 * t + w );
y4 = A4 * sin( 2 * pi * f4 * t + w );
y = [y1 y2 y3 y4 y1 y2 y3 y4 y1 y2]
[r,fs] = audioread('orig_input.wav');
melody = r + (y(1:length(r)))'; %Tron giai dieu voi file ghi am ban dau.
soundsc(melody,44100);
filename = 'melody.wav';
audiowrite(filename,melody,fs);

[melody,fs] = audioread('melody.wav');
xlabel('Frequency(Hz)');
figure(1)
N = fs % number of FFT points
transform = fft(melody,N)/N;
magTransform = abs(transform);
faxis = linspace(-N/2,N/2,N);
plot(faxis,fftshift(magTransform));
title('FFT');
xlabel('Frequency(Hz)');

win = 128 % window length in samples
% number of samples between overlapping windows:
hop = win/2            
nfft = win %width of each frequency bin 
figure(2)
spectrogram(melody,win,hop,nfft,fs,'yaxis');
% change the tick labels of the graph from scientific notation to floating point: 
yt = get(gca,'YTick');  
set(gca,'YTickLabel', sprintf('%.0f|',yt));
title('Spectrogram');