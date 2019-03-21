%Peter Al ahmar
%100961570  

% It doesnt seem right and not sure how to fix it

%solving question 1 part a
x=40;
y=60;
Vo = 1;
%matrix G and V
G = sparse((x * y), (x * y));
V = zeros(1,(x *y));

for i = 1:x
    
    for j = 1: y
        n = j+ (i-1) *y;
        
        if (i == 1)
            G(n,:) = 0;
            
            G(n,n) = 1;
            
            V(1,n) = 1;
            
        elseif (i == x)
            G(n,:) = 0;
            
            G(n,n) = 1;

            
        elseif ((i > 1) && (i < x) && (j==1))
            
            G(n, n+y) = 1;
            
            G(n,n) = -3;
            
            G(n,n-y) = 1;
            
            G(n,n-1) = 1;
            
        elseif ((j == y) && (i < x) && (i >1))
            G(n, n+y) = 1;
            
            G(n,n) = -3;
            
            G(n,n-y) = 1;
            
            G(n,n+1) = 1;
        else
            G(n, n+y) = 1;
            
            G(n,n) = -4;
            
            G(n,n-y) = 1;
            
            G(n,n-1) = 1;
            
            G(n,n+1) = 1;
        end
    end
end
figure(1);
spy(G);

solution = G\V';
%matrix
act = zeros(x,y);

for i =1:x
    for j = 1:y
        n = j+(i-1) * y;
        act(i,j) = solution(n);
    end
end
figure(2);
surf(act);


%solving question 1 part b

x=40;
y=60;
Vo = 1;

newG = sparse((x * y),(x * y));
newV = zeros(1,(x * y));

for i = 1:x
    
    for j = 1:y
        
        n = j+ (i-1) *y;
        
        if (i == 1)

            newG(n,:) =0;
            
            newG(n,n) =1;
            
            newV(1,n) =1; % which is Vo 
            
        elseif (i == x) 

            newG(n,:) =0;
            
            newG(n,n) =1;
           
            newV(1,n) = 1;
        elseif (i == y)                      
            newG(n,:) = 0;
            
            newG(n,n) = 1;
            
        elseif (j == 1)        
            newG(n,:) = 0;
            
            newG(n,n) = 1;

        else
            newG(n,:) = 0;
            
            newG(n,n) = -4;
            
            newG(n,n-y) = 1;
            
            newG(n,n+y) = 1;
            
            newG(n,n-1) = 1;
            
            newG(n,n+1) = 1;
            

        end
    end
end

newSolution = newG\newV';
figure(3);
newAct = zeros(x,y);

for i = 1:x
    for j = 1:y
        
        n = j + (i-1)*y;
        newAct(i,j) = newSolution(n);
       
    end
end

surf(newAct)

%using analytical approach -- reached out for help -- 

z = zeros(60, 40);
a = 60;b = 20;

xnum = linspace(-20,20,40);
ynum = linspace(0,60,60);

[xm, ym] = meshgrid(xnum, ynum);



for n = 1:2:300
    
    z= (4 * Vo/pi) .* (z + (cosh((n * pi * xm)/a) .* sin((n * pi * ym)/a)) ./ (n * cosh((n * pi * b)/a)));
    
    figure(4);
    surf(xnum, ynum, z);
    title("Analytical Approach");
    pause(0.01);
    
end

