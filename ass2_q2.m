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
            
            G(n, n+y) = map(i+1,j);
            
            G(n,n) = -(map(i,j+1)+map(i-1,j)+map(i+1,j));
            
            G(n,n-y) = map(i-1,j);
            
            G(n,n-1) = map(i,j+1);
            
        elseif ((j == y) && (i < x) && (i >1))
            G(n, n+y) = map(i+1,j);
            
            G(n,n) = -(map(i-1,j)+map(i+1,j)+map(i,j-1));
            
            G(n,n-y) = map(i-1,j);
            
            G(n,n+1) = map(i,j-1);
        else
            G(n, n+y) = map(i+1,j);
            
            G(n,n) = -(map(i-1,j)+map(i+1,j)+map(i,j+1)+map(i,j-1));
            
            G(n,n-y) = map(i-1,j);
            
            G(n,n-1) = map(i,j+1);
            
            G(n,n+1) = map(i,j-1);
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

