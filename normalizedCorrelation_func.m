function correlation_vector = normalizedCorrelation_func( vecA, vecB, sizeR) 
%normalizedCorrelation_func calculate the normalized correlation between
%vecA and vecB vectors
%   Inputs: Vectors vecA and vecB both with size R
%   Output: Correlation values vector and a integer indicating that vecA
%   and vecB are the same size or not

correlation_vector = 0.0;

sumA = sum(vecA);
sumB = sum(vecB);
sqr_vecA = zeros(1,sizeR);
sqr_vecB = zeros(1,sizeR);

prod_vec = dot(vecA, vecB);% sum of element by element products

for r = 1 : sizeR

    sqr_vecA(1,r) = vecA(1,r)^2; %vector of squares of elements of vecA
    sqr_vecB(1,r) = vecB(1,r)^2; 

end
 
sqr_sumA = sum(sqr_vecA);
sqr_sumB = sum(sqr_vecB);

correlation_vector = (((((sizeR+1)*prod_vec) - sumA*sumB)^2)*100)/((((sizeR+1)*sqr_sumA) - sumA^2)*(((sizeR+1)*sqr_sumB) - sumB^2));

end

