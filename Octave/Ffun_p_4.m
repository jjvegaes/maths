function F = Ffun_p_4(x);
  F(1,1) = x(1).^3+x(1).^2*x(2)-x(1)*x(3)+6;
  F(2,1) = exp(x(1))+exp(x(2))-x(3);
  F(3,1) = x(2).^2-2*x(1)*x(3)-4;
  endfunction