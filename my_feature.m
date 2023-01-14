function out=my_feature(I)
m1=sum(sum(I))/numel(I);
m2=sqrt(sum(sum((I-m1).^2)));
m3=(sum(sum((I-m1).^3))).^(1/3);
out=[m1 m2 abs(m3)];