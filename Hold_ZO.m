function HoldSignal = Hold_ZO(SampledSequence, r, SignalType)
%
% simulates a zero-order hold by repeating
% each sample of the input sequence r times
%
% Inputs:
%  - SampledSequence: original sample sequence
%  - r: number of times each sample is repeated
%  - SignalType: set to 'A' if the input signal is "analog"
%                set to 'D' if the input signal is "digital"
% Outputs:
%  - HoldSignal: signal at the output of the zero-order hold
%
% Examples:
% >> HoldSignal = Hold_ZO2([1, 2, 3, 4, 5, 6, 7, 8], 3, 'a')
% HoldSignal =  1  1  1  4  4  4  7  7
% >> HoldSignal = Hold_ZO2([1, 2, 3], 2, 'd')
% HoldSignal =  1  1  2  2  3  3

[nrows, ncols] = size(SampledSequence);
if nrows > ncols
  SampledSequence = SampledSequence';
end

if SignalType == 'a' %for an analog signal
    SampledSequence = SampledSequence(1:r:length(SampledSequence));
    HoldSignal = ones(r, 1)*SampledSequence;
    HoldSignal = reshape(HoldSignal, 1, r*length(SampledSequence));
elseif SignalType == 'd' %for a digital signal
    HoldSignal = ones(r, 1)*SampledSequence;
    HoldSignal = reshape(HoldSignal, 1, r*length(SampledSequence));
end
