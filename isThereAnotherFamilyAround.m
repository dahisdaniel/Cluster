function output = isThereAnotherFamilyAround(i,j,img_resul,numberLines,numberColumns)
%This function computes for the position ixj passed for it what is the next
%position i`x j` with greater correlation value
familysAround = [];
%CASE 1 : Position inside the plane (not on the borders)
if (i-1 >= 1) && ( i+1 <= numberLines ) && (j-1 >= 1) && ( j+1 <= numberColumns )
    
    family = img_resul(i,j);
%     familysAround = [familysAround img_resul(i,j)];
    familysAround = [familysAround img_resul(i,j-1)];
    familysAround = [familysAround img_resul(i-1,j)];
    familysAround = [familysAround img_resul(i,j+1)];
    familysAround = [familysAround img_resul(i+1,j)];
    familysAround = [familysAround img_resul(i-1,j+1)];
    familysAround = [familysAround img_resul(i+1,j+1)];
    familysAround = [familysAround img_resul(i-1,j-1)];
    familysAround = [familysAround img_resul(i+1,j-1)];
    
    output = ~isempty(find(familysAround == family));
    
    
%CASE 2 : Position on the 1st Column but not on top or down
elseif (i-1 >= 1) && (i<numberLines) && (j==1)
    
    family = img_resul(i,j);
%     familysAround = [familysAround img_resul(i,j)];
%     familysAround = [familysAround img_resul(i,j-1)];
    familysAround = [familysAround img_resul(i-1,j)];
    familysAround = [familysAround img_resul(i,j+1)];
    familysAround = [familysAround img_resul(i+1,j)];
    familysAround = [familysAround img_resul(i-1,j+1)];
    familysAround = [familysAround img_resul(i+1,j+1)];
%     familysAround = [familysAround img_resul(i-1,j-1)];
%     familysAround = [familysAround img_resul(i+1,j-1)];
     output = ~isempty(find(familysAround == family));
    
%CASE 3 : Position on the 1st line but not on extreme left or right.
elseif (i== 1)  && (j-1>=1) && (j+1 <= numberColumns)
    
    family = img_resul(i,j);
%     familysAround = [familysAround img_resul(i,j)];
    familysAround = [familysAround img_resul(i,j-1)];
%     familysAround = [familysAround img_resul(i-1,j)];
    familysAround = [familysAround img_resul(i,j+1)];
    familysAround = [familysAround img_resul(i+1,j)];
%     familysAround = [familysAround img_resul(i-1,j+1)];
    familysAround = [familysAround img_resul(i+1,j+1)];
%     familysAround = [familysAround img_resul(i-1,j-1)];
    familysAround = [familysAround img_resul(i+1,j-1)];
    
    output = ~isempty(find(familysAround == family));

%CASE 4 : Position on the last column but not on extreme up or down.
elseif (i>= 2) && (i< numberLines) && (j== numberColumns)
    
    family = img_resul(i,j);
%     familysAround = [familysAround img_resul(i,j)];
    familysAround = [familysAround img_resul(i,j-1)];
    familysAround = [familysAround img_resul(i-1,j)];
%     familysAround = [familysAround img_resul(i,j+1)];
    familysAround = [familysAround img_resul(i+1,j)];
%     familysAround = [familysAround img_resul(i-1,j+1)];
%     familysAround = [familysAround img_resul(i+1,j+1)];
    familysAround = [familysAround img_resul(i-1,j-1)];
    familysAround = [familysAround img_resul(i+1,j-1)];
    
     output = ~isempty(find(familysAround == family));
    
%CASE 5 : Position on the last line but not on extreme left or right
elseif (i == numberLines)  && (j-1>=1) && (j < numberColumns)
    
     family = img_resul(i,j);
%     familysAround = [familysAround img_resul(i,j)];
    familysAround = [familysAround img_resul(i,j-1)];
    familysAround = [familysAround img_resul(i-1,j)];
    familysAround = [familysAround img_resul(i,j+1)];
%     familysAround = [familysAround img_resul(i+1,j)];
    familysAround = [familysAround img_resul(i-1,j+1)];
%     familysAround = [familysAround img_resul(i+1,j+1)];
    familysAround = [familysAround img_resul(i-1,j-1)];
%     familysAround = [familysAround img_resul(i+1,j-1)];
    
    output = ~isempty(find(familysAround == family));
    

%CASE 6 : Position on the first position (1st line and 1st column).
elseif (i== 1) && (j==1)
    
    family = img_resul(i,j);
%     familysAround = [familysAround img_resul(i,j)];
%     familysAround = [familysAround img_resul(i,j-1)];
%     familysAround = [familysAround img_resul(i-1,j)];
    familysAround = [familysAround img_resul(i,j+1)];
    familysAround = [familysAround img_resul(i+1,j)];
%     familysAround = [familysAround img_resul(i-1,j+1)];
    familysAround = [familysAround img_resul(i+1,j+1)];
%     familysAround = [familysAround img_resul(i-1,j-1)];
%     familysAround = [familysAround img_resul(i+1,j-1)];
    
   output = ~isempty(find(familysAround == family));
   
%CASE 7 : Position on the last position of the 1st line.
elseif (i== 1) && (j==numberColumns)
    
    family = img_resul(i,j);
%     familysAround = [familysAround img_resul(i,j)];
    familysAround = [familysAround img_resul(i,j-1)];
%     familysAround = [familysAround img_resul(i-1,j)];
%     familysAround = [familysAround img_resul(i,j+1)];
    familysAround = [familysAround img_resul(i+1,j)];
%     familysAround = [familysAround img_resul(i-1,j+1)];
%     familysAround = [familysAround img_resul(i+1,j+1)];
%     familysAround = [familysAround img_resul(i-1,j-1)];
    familysAround = [familysAround img_resul(i+1,j-1)];
    
   output = ~isempty(find(familysAround == family));

%CASE 8 : Position on the last column and the last line.
elseif (i== numberLines) && (j==numberColumns)
    
   family = img_resul(i,j);
%     familysAround = [familysAround img_resul(i,j)];
    familysAround = [familysAround img_resul(i,j-1)];
    familysAround = [familysAround img_resul(i-1,j)];
%     familysAround = [familysAround img_resul(i,j+1)];
%     familysAround = [familysAround img_resul(i+1,j)];
%     familysAround = [familysAround img_resul(i-1,j+1)];
%     familysAround = [familysAround img_resul(i+1,j+1)];
    familysAround = [familysAround img_resul(i-1,j-1)];
%     familysAround = [familysAround img_resul(i+1,j-1)];
    
     output = ~isempty(find(familysAround == family));

%CASE 9 : Position on the last place of the first column.
else (i== numberLines) && (j==1)
    
    family = img_resul(i,j);
%     familysAround = [familysAround img_resul(i,j)];
%     familysAround = [familysAround img_resul(i,j-1)];
    familysAround = [familysAround img_resul(i-1,j)];
    familysAround = [familysAround img_resul(i,j+1)];
%     familysAround = [familysAround img_resul(i+1,j)];
    familysAround = [familysAround img_resul(i-1,j+1)];
%     familysAround = [familysAround img_resul(i+1,j+1)];
%     familysAround = [familysAround img_resul(i-1,j-1)];
%     familysAround = [familysAround img_resul(i+1,j-1)];
    
     output = ~isempty(find(familysAround == family));

end

