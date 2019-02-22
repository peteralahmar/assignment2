%Peter Al ahmar
%100961570  

% It doesnt seem right and not sure how to fix it

%solving question 1 part a
x=40;
y=60;

%matrix G and V
G = sparse((x *y), (x*y));
V = zeros(1,(x *y));
Vo = 1;

for i = 1:x
    
    for j = 1: y
        n = j+ (i-1) *y;
        
        if i == x
            G(n,:) = 0;
            G(n,n) = 1;
            
        elseif i == 1 
            G(n,:) = 0;
            G(n,n) = 1;
            V(1,n) = 1;
            
        elseif i>1 && i <x && j==1
            G(n, n+y) = 1;
            G(n,n) = -3;
            G(n,n-y) = 1;
            G(n,n-1) = 1;
        elseif j ==y && i < x && i >1
            G(n, n+y) = 1;
            G(n,n) = -3;
            G(n,n-y) = 1;
            G(n,n-1) = 1;
        else
            G(n, n+y) = 1;
            G(n,n) = -4;
            G(n,n-y) = 1;
            G(n,n-1) = 1;
            G(n,n+1) = 1;
        end
    end
end
figure(1)
spy(G)
solution = G\V';

figure(2)

%matrix
act = zeros(x,y);

for i =1:x
    for j = 1:y
        n = j+(i-1) * y;
        act(i,j) = solution(n);
    end
end

surf(act);


%solving question 1 part b

newG = sparse((x *y),(x*y));
newV = zeros(1,(x *y));
%same V0

for i = 1:x
    
    for j = 1: y
        n = j+ (i-1) *y;
        
        if i == x
            newV(1,n) =1; % which is Vo
            newG(n,:) =0;
            newG(n,n) =1;
            
        elseif i == 1 
            newV(1,n) =1; % which is Vo
            newG(n,:) =0;
            newG(n,n) =1;

        elseif j ==y
            newG(n,n) = 1;
            newG(n,:) = 0;
            
        elseif j==1
            newG(n,n) = 1;
            newG(n,:) = 0

        else
            newG(n, n+y) = 1;
            newG(n,n) = -4;
            newG(n,n-y) = 1;
            newG(n,n-1) = 1;
            newG(n,n+1) = 1;
            newG(n,:) = 0;
        end
    end
end

figure(3)
spy(newG)

newSolution = newG\newV';

figure(4)

newAct = zeros(x,y);

for i = 1:x
    for j = 1:y
        n = j + (i-1)*y;
        newAct(i,j) = newSolution(n);
       
    end
end

surf(newAct)

%using analytical approach -- reached out for help -- isnt working -- 

a = 60; b= 20;
z = zeros(60,40);
numx = linspace(-20,20,40);
numy = linspace(0,60,60);

[xm,ym] = meshgrid(numx, numy);

for i = 1: 2:300
    z = (4* Vo/pi) .* (z + (cosh((n*pi*xm)/a)./ (n* cosh((n*pi*b)/a)) .* sin((n*pi*ym)/a))) ;
    figure(5)
    title("Analytical Approach")
    surf(numx,numy,z)
    pause(0.01)
end

