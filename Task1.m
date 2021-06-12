%create adjacency matrix
M_A = [0 1/3 1/3 1/3 0 0 0; 0 0 1 0 0 0 0; 0 0 0 0 1 0 0; 0 0 0 0 0 1/2 1/2; 1 0 0 0 0 0 0; 0 0 0 0 1 0 0; 1 0 0 0 0 0 0];
%implement page rank
Pg = ones(1,size(M_A,1))/size(M_A,1);
for k = 1:100
        Pg = Pg*M_A(:,:);
end
[V,D] = eig(M_A');
d = eigs(M_A',1);

%exercise 4 - spam
Spam = ones(100,1);
M_B = zeros(107,107);
M_B(1:7,1:7) = M_A;
M_B(8:107,6) = Spam;
%implement page rank
Pg_B = ones(1,size(M_B,1))/size(M_B,1);
for k = 1:100
        Pg_B = Pg_B*M_B(:,:);
end

%HITS algorithm
%implement hub weights
Hub_w = ones(1,size(M_A,1));
for k = 1:7
        Auth_w = Hub_w*M_A(:,:) %authority weights
        Hub_w  = M_A(:,:)*Auth_w';
        Hub_w = Hub_w'
end

for r = 1:size(Auth_w,2)
    if Hub_w(r) > Auth_w(r)
        Type_of_el{r} = sprintf('%d el. is a hub',r)
    elseif Hub_w(r) == Auth_w(r)
        Type_of_el{r} = sprintf('%d el. is equal',r)        
    else
        Type_of_el{r} = sprintf('%d el. is an authority node',r)
    end
end