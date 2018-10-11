## Copyright (C) 2011 Ana
## 
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with Octave; see the file COPYING.  If not, see
## <http://www.gnu.org/licenses/>.

## puntofijo

## Author: Ana <Ana@ANA-TOSH>
## Created: 2011-09-27

function [ x, niter ] = puntofijo2(phi,xini,tol,nmax,varargin)
% algoritmo del punto fijo
% aproximación de un punto fijo ALPHA de una funcion PHI
% partiendo de un dato inicial x0
% el método se para después de 100 iteraciones o después de que
% el valor absoluto de la diferencia entre los valores obtenidos en dos
% iteraciones consecutivas sea menor que 1.e-04
% PHI puede definirse como una función o como una función inline

   x = xini; diff= tol +1; niter =0;
 while niter <= nmax & diff >= tol
 gx = feval (phi,x,varargin{:});
 diffnew=x-gx;
 diff=abs(diffnew);
 xnew=gx;
 x=xnew;
 niter=niter+1; 
 end
 if niter >= nmax
 fprintf(' No converge en el maximo',...
          'número de iteraciones\n ');
		  end
		  return

endfunction