%Question 2

x = 120;
y = 80;

G = sparse((x *y), (x*y));
V = zeros(1,(x *y));
Vo = 1;

conductivity1 = 1; %outside
conductivity2 = 1e-2; %inside

box1 = [(x* 2/5), (x* 3/5), y , (y *4/5)]; %lower box
box2 = [(x* 2/5), (x* 3/5),0, (y *1/5)]; %top box

bottleNeckVec = zeros(1,10);
currentVec = zeros(1,10);

% conductivity map
map = ones(x,y);

for i = 1:x
    for j = 1:y
        if (i < box1(2) && i >box1(1) && ((j < box2(4)) || (j > box1(4))))
            map(i,j) = conductivity2;
        end
    end
end
%plotting the map
figure(1);
surf(map);
title('Conductivity Map');


%Matrix G

for i = 1:x
    for j = 1:y
        
        n = j+(i-1) *y;
        
        if i==x
            G(n,:) = 0;
            G(n,n) = 1;

        elseif i==1
            G(n,:) = 0;  
            G(n,n) = 1;
            V(1,n) = 1; %Vo 
        elseif j ==1 && i>1 && i<x
            
            if i == box1(1)
                G(n,n) = -3;
                G(n,n+1) = conductivity2;
                G(n,n+y) = conductivity2;
                G(n,n-y) = conductivity1;  
            elseif i ==box1(2)
                G(n,n) = -3;
                G(n,n+1) = conductivity2;
                G(n,n+y) = conductivity1;
                G(n,n-y) = conductivity2;  
            elseif (i >box1(1) && i< box1(2))
                G(n,n) = -3;
                G(n,n+1) = conductivity2;
                G(n,n+y) = conductivity2;
                G(n,n-y) = conductivity2;  
            else
                G(n,n) = -3;
                G(n,n+1) = conductivity1;
                G(n,n+y) = conductivity1;
                G(n,n-y) = conductivity1;  
                
            end
            

            
        elseif j ==y && i >1 && i <x
            
            if i == box1(1)
                G(n,n) = -3;
                G(n, n-1) = conductivity2;
                G(n,n+y) = conductivity2;
                G(n,n-y) = conductivity1;
            elseif i == box1(2)
                G(n,n) = -3;
                G(n, n-1) = conductivity2;
                G(n,n+y) = conductivity1;
                G(n,n-y) = conductivity2;
            elseif(i >box1(1)&& i <box1(2))
                G(n,n) = -3;
                G(n, n-1) = conductivity2;
                G(n,n+y) = conductivity2;
                G(n,n-y) = conductivity2;
            else
                G(n,n) = -3;
                G(n, n-1) = conductivity1;
                G(n,n+y) = conductivity1;
                G(n,n-y) = conductivity1;
            end
        else
            if i == box1(1) && (j < box2(4) || (j > box1(4)))
                G(n,n) = -4;
                G(n,n+1) = conductivity2;  
                G(n,n-1) = conductivity2;
                G(n, n+y) = conductivity2;
                G(n,n-y) = conductivity1;
            elseif i == box1(2) && (j < box2(4) || (j > box1(4)))
                G(n,n) = -4;
                G(n,n+1) = conductivity2;  
                G(n,n-1) = conductivity2;
                G(n, n+y) = conductivity1;
                G(n,n-y) = conductivity2;
            elseif i > box1(1) && i <box1(2) && (j < box2(4) || (j > box1(4)))
                G(n,n) = -4;
                G(n,n+1) = conductivity2;  
                G(n,n-1) = conductivity2;
                G(n, n+y) = conductivity2;
                G(n,n-y) = conductivity1;
            else 
                G(n,n) = -4;
                G(n,n+1) = conductivity1;  
                G(n,n-1) = conductivity1;
                G(n, n+y) = conductivity1;
                G(n,n-y) = conductivity1;
            end      
        end
    end 
end

solution1 = G\V';

act = zeros(x,y);

for i =1:x
    for j = 1:y
        n = j+(i-1) * y;
        act(i,j) = solution1(n);
    end
end


figure(2);
surf(act);
title('Voltage Map with Bottleneck');

[Efx,Efy] = gradient(act);
Efx = -Efx;
Efy = -Efy;

figure(3)
axis tight
quiver(Efx',Efy');
title('Quiver Plot of Electric Field')

%plotting current density

Jx = Efx .* map;
Jy = Efx .*map;
figure(4)
axis tight
quiver(Jx,Jy);
title('Quiver Plot of Current Density (J)')

magnitude = ((Jx .^2) + (Jy .^2)) .^0.5;

figure(5)
title('Magnitude of Current Density')
surface(magnitude)
axis tight

currentflow = sum(Jx(x/2,:));

figure(6)
title('Electric Field along the Y direction')
surface(Efy)

figure(7)
title('Electric Field along the X direction')
surface(Efx)

