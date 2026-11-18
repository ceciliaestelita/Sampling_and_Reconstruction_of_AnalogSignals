function [S,fr]=MagSpectrum(x,fs)
%
% [S,fr]=MagSpectrum(x,fs);
%
% This function estimates the magnitude spectrum of a real signal
% by using a simple DFT (FFT algorithm)
% 
% Inputs:
%  - x : signal samples
%  - fs: sampling frequency
%
% Outputs:
%  - S : Magnitude spectrum estimate
%  - fr: real frequency

% Grenoble INP / Gipsa-lab
% P. Granjon
% 2014
