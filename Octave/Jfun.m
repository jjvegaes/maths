function J = Jfun(x);
  J(1,1) = x(2).^2 - 3*x(1).^2;
  J(1,2) = 2*x(1).*x(2) +1;
  J(2,1) = 2*x(1) - x(2) +1;
  J(2,2) = -x(1);
  endfunction