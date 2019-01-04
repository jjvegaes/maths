function F = Ffun(x);
  F(1,1) = x(1).*x(2).^2- x(1).^3 + x(2) + 1;
  F(2,1) = x(1).^2 -x(1).*x(2) + x(1) - 3;
  endfunction