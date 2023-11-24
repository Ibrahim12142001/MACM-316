function roots = quadformula(a, b, c)
D = b^2 - 4*a*c; % discriminant (assume D > 0)
if a~=0
    if D>0
        if b<0
            root1 = (-2*c)/(b - sqrt(D));
            root2 = (-b + sqrt(D)) / (2*a);
        else
            root1 = (-b - sqrt(D)) / (2*a);
            root2 = (-2*c) / (b + sqrt(D));             
        end
        roots = [ root1, root2 ];% 2 real roots, smallest first
        fprintf ('There are 2 roots: '); disp(roots);
    elseif D==0
        root1 = (-b) / (2*a);
        roots = (root1); %2 same roots
        fprintf ('There are 2 same roots: '); disp (roots);
   else
        roots = []; %empty array;
        fprintf ('There are no real roots /n ');       
    end 
else
    if b~=0
        roots = (-c/b);
        fprintf('roots are: '); disp(roots);
    else
        roots = [];
        fprintf('There are no roots as a = 0 and b = 0');
    end
end
    l=length(roots);
    if l==2
       if (roots(1)~= -inf) && (roots(2)~=inf) 
           x = linspace(min(roots)-10,max(roots)+10);         
       elseif (roots(1) == -inf) && (roots(2)~=inf)
           x = linspace(roots(2)-10,roots(2)+10);                     
       elseif (roots(1)~= -inf) && (roots(2) == inf)
            x = linspace(roots(1)-10,roots(1)+10);          
       else
            x = linspace(-10,10);            
       end
    elseif l==1            
            if roots(1) == -inf || roots(1) == inf
                x = linspace(-10,10); 
            else
                x = linspace(roots(1)-10,roots(1)+10);        
            end  
    else 
        x = linspace (-10,10);
    end    
    if D~=0
    plot(roots,0,'dk');legend('roots');
    end    
    hold on; 
    plot(x, a*(x.^2) + b*x + c,'LineWidth', 3, 'DisplayNAME', 'function');
    title("roots for a =" + a+" b = "+ b+" c = "+ c);
    xlabel("x axis");
    ylabel("y axis");
    hold off;
end
 
    


