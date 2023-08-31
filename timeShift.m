L=3;
n=-L:L;
shift = -4;
y=[zeros(1,L),1,zeros(1,L)];
if (shift > 0)
    y(shift+1:end) = n(1:end-shift);
elseif (shift <0)
  y(1:end+shift) = n(-shift+1:end);
end