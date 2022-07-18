% Produces the figure from the Supporing Information document 

figH = figure;

pd(1) = makedist('Gamma', a = 0.72, b = 5.24/0.72);
pd(2) = makedist('Lognormal', mu = 0.82, sigma = 1.65);

Co = { [0 0.4470 0.7410],  [0.9290 0.6940 0.1250] };

% Plot the PDF on linear and logscale
for i = 1:2
  subplot(3, 4, i); hold on
  x = 10^-2.5:1e-3:11;
  for d = 1:2
    plot(x, pd(d).pdf(x), Color = Co{d})
  end
  xlim([0 10])
  ylim([0 0.7])
  xlabel('x')
end
subplot(3, 4, 1)
ylabel('Probability density')
subplot(3, 4, 2)
set(gca, 'XScale', 'log')

%Plot the log-transformed PDF
subplot(3, 4, 4); hold on
x = -2:1e-2:2;
plot(x, logammaPDF(pd(1).b, pd(1).a, x, 10), Color = Co{1})
plot(x, normpdf(x, pd(2).mu*log10(exp(1)), pd(2).sigma*log10(exp(1)) ), Color = Co{2})
xlim([-2 2])
xlabel('log x')

% Plot histograms
ax = [];
for d = 1:2
  % Your "usual" histogram
  x1 = pd(d).random(1, 3e7);
  ax(end+1) = subplot(3, 4, 4*d + 1);
  histogram(x1, BinEdges =  0.3e-2:1e-2:100, EdgeColor = 0.5*[1 1 1], FaceColor = Co{d})
  xlim([0 10])

  % As above, with log-scaling of the x-axis
  ax(end+1) = subplot(3, 4, 4*d + 2);
  histogram(x1, BinEdges =  0.3e-2:1e-2:100, EdgeColor = 0.5*[1 1 1], FaceColor = Co{d})
  set(gca, XScale = 'log')
  xlim([0 100])

  % Histogram with exponentially-scaled bins
  ax(end+1) = subplot(3, 4, 4*d + 3);
  histogram(x1, BinEdges = 10.^(-2:0.1:2), EdgeColor = 0.5*[1 1 1], FaceColor = Co{d})
  
  % As above, with log-scaling of the x-axis
  ax(end+1) = subplot(3, 4, 4*d + 4);
  histogram(x1, BinEdges = 10.^(-2:0.1:2), EdgeColor = 0.5*[1 1 1], FaceColor = Co{d})
  set(gca, XScale = 'log')
end

for i = 1:numel(ax)
  box(ax(i), 'off')
end