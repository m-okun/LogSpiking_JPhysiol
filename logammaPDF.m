% Log-Gamma Distribution PDF
% Inputs: 
% b, a - the two parameters of the corresponding Gamma distribution, e.g., as returned by fitdist(YOURDATA, 'Gamma')
%        b is the scale parameter, a is the shape parameter 
% x - a vector of values at which the PDF value needs to be computed
% lb (optional, e by default) - the base of the logarithm of the distribution
%
% Output: 
% y - PDF evaluated at the values of x.
%
function y = logammaPDF(b, a, x, lb)

assert (a > 0 & b > 0, 'Negative scale/shape parameters are not allowed')

if nargin < 4
  % The analytical expression below is found in several papers on the Log-Gamma distribution:
  y = exp(a*x) .* exp(-exp(x)/b) / b^a / gamma(a);
else
  y = log(lb)*lb.^(a*x) .* exp(-1*lb.^x/b) / b^a / gamma(a);
end

return

%% Testing:

% pd = makedist('Gamma', 'a', 0.6, 'b', 7);
pd = makedist('Gamma', 'a', 0.38, 'b', 22); % Closely corresponds to the empirical distribution in O'Connor et al. Neuron 2010.
pdfSampLe = 1e6;
r = pd.random(1, pdfSampLe);

figure; 
e = -9:0.02:6;
subplot(1, 3, 1); hold on;
plot(e(2:end), histcounts(log(r), e, 'Normalization', 'pdf'), '--k')
plot(e, logammaPDF(pd.b, pd.a, e), 'r')
xlabel('ln rates')

subplot(1, 3, 2); 
histogram(log10(r(r>0.01)), 'Normalization', 'pdf')
xlabel('log10 rates')

e = -3:0.02:2;
subplot(1, 3, 3); hold on;
plot(e(2:end), histcounts(log10(pd.random(1, pdfSampLe)), e, 'Normalization', 'pdf'), '--k')
plot(e, logammaPDF(pd.b, pd.a, e*log(10))*log(10), 'r')
plot(e, logammaPDF(pd.b, pd.a, e, 10), 'g--')
xlabel('log10 rates')
