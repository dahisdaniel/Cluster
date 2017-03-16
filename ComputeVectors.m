function output = ComputeVectors(i,j,img_resul,numberLines,numberColumns)
%This function computes for the position ixj passed for it what is the next
%position i`x j` with greater correlation value

%CASE 1 : Position inside the plane (not on the borders)
if (i-1 >= 1) && ( i+1 <= numberLines ) && (j-1 >= 1) && ( j+1 <= numberColumns )
    
    vec_central = [img_resul(i,j).c1,img_resul(i,j).c2,img_resul(i,j).c3,img_resul(i,j).c4,img_resul(i,j).c5]';
    vec_left    = [img_resul(i,j-1).c1,img_resul(i,j-1).c2,img_resul(i,j-1).c3,img_resul(i,j-1).c4,img_resul(i,j-1).c5]';
    vec_up      = [img_resul(i-1,j).c1,img_resul(i-1,j).c2,img_resul(i-1,j).c3,img_resul(i-1,j).c4,img_resul(i-1,j).c5]';
    vec_right   = [img_resul(i,j+1).c1,img_resul(i,j+1).c2,img_resul(i,j+1).c3,img_resul(i,j+1).c4,img_resul(i,j+1).c5]';
    vec_down    = [img_resul(i+1,j).c1,img_resul(i+1,j).c2,img_resul(i+1,j).c3,img_resul(i+1,j).c4,img_resul(i+1,j).c5]';
    vec_duright = [img_resul(i-1,j+1).c1,img_resul(i-1,j+1).c2,img_resul(i-1,j+1).c3,img_resul(i-1,j+1).c4,img_resul(i-1,j+1).c5]';
    vec_ddright = [img_resul(i+1,j+1).c1,img_resul(i+1,j+1).c2,img_resul(i+1,j+1).c3,img_resul(i+1,j+1).c4,img_resul(i+1,j+1).c5]';
    vec_duleft  = [img_resul(i-1,j-1).c1,img_resul(i-1,j-1).c2,img_resul(i-1,j-1).c3,img_resul(i-1,j-1).c4,img_resul(i-1,j-1).c5]';
    vec_ddleft  = [img_resul(i+1,j-1).c1,img_resul(i+1,j-1).c2,img_resul(i+1,j-1).c3,img_resul(i+1,j-1).c4,img_resul(i+1,j-1).c5]';

    rangeVC = range(vec_central);

    %correlations
    cl  = (corr(vec_central,vec_left));
    cu  = (corr(vec_central,vec_up));
    cr  = (corr(vec_central,vec_right));
    cd  = (corr(vec_central,vec_down));
    cdur= (corr(vec_central,vec_duright));
    cddr= (corr(vec_central,vec_ddright));
    cdul= (corr(vec_central,vec_duleft));
    cddl= (corr(vec_central,vec_ddleft));  
    
    output = [cl , cddl , cd , cddr, cr , cdur, cu, cdul];


%CASE 2 : Position on the 1st Column but not on top or down
elseif (i-1 >= 1) && (i<numberLines) && (j==1)

    vec_central = [img_resul(i,j).c1,img_resul(i,j).c2,img_resul(i,j).c3,img_resul(i,j).c4,img_resul(i,j).c5]';
    %             vec_left    = [img_resul(i,j-1).c1,img_resul(i,j-1).c2,img_resul(i,j-1).c3,img_resul(i,j-1).c4,img_resul(i,j-1).c5]';
    vec_up      = [img_resul(i-1,j).c1,img_resul(i-1,j).c2,img_resul(i-1,j).c3,img_resul(i-1,j).c4,img_resul(i-1,j).c5]';
    vec_right   = [img_resul(i,j+1).c1,img_resul(i,j+1).c2,img_resul(i,j+1).c3,img_resul(i,j+1).c4,img_resul(i,j+1).c5]';
    vec_down    = [img_resul(i+1,j).c1,img_resul(i+1,j).c2,img_resul(i+1,j).c3,img_resul(i+1,j).c4,img_resul(i+1,j).c5]';
    vec_duright = [img_resul(i-1,j+1).c1,img_resul(i-1,j+1).c2,img_resul(i-1,j+1).c3,img_resul(i-1,j+1).c4,img_resul(i-1,j+1).c5]';
    vec_ddright = [img_resul(i+1,j+1).c1,img_resul(i+1,j+1).c2,img_resul(i+1,j+1).c3,img_resul(i+1,j+1).c4,img_resul(i+1,j+1).c5]';
    %             vec_duleft  = [img_resul(i-1,j-1).c1,img_resul(i-1,j-1).c2,img_resul(i-1,j-1).c3,img_resul(i-1,j-1).c4,img_resul(i-1,j-1).c5]';
    %             vec_ddleft  = [img_resul(i+1,j-1).c1,img_resul(i+1,j-1).c2,img_resul(i+1,j-1).c3,img_resul(i+1,j-1).c4,img_resul(i+1,j-1).c5]';
    
    %correlations
    cl  = -1; %corr(vec_central,vec_left);
    cu  = (corr(vec_central,vec_up));
    cr  = (corr(vec_central,vec_right));
    cd  = (corr(vec_central,vec_down));
    cdur= (corr(vec_central,vec_duright));
    cddr= (corr(vec_central,vec_ddright));
    cdul= -1; %corr(vec_central,vec_duleft);
    cddl= -1; % corr(vec_central,vec_ddleft);
    

    output = [cl , cddl , cd , cddr, cr , cdur, cu, cdul];


%CASE 3 : Position on the 1st line but not on extreme left or right.
elseif (i== 1)  && (j-1>=1) && (j+1 <= numberColumns)


    vec_central = [img_resul(i,j).c1,img_resul(i,j).c2,img_resul(i,j).c3,img_resul(i,j).c4,img_resul(i,j).c5]';
    vec_left    = [img_resul(i,j-1).c1,img_resul(i,j-1).c2,img_resul(i,j-1).c3,img_resul(i,j-1).c4,img_resul(i,j-1).c5]';
    %             vec_up      = [img_resul(i-1,j).c1,img_resul(i-1,j).c2,img_resul(i-1,j).c3,img_resul(i-1,j).c4,img_resul(i-1,j).c5]';
    vec_right   = [img_resul(i,j+1).c1,img_resul(i,j+1).c2,img_resul(i,j+1).c3,img_resul(i,j+1).c4,img_resul(i,j+1).c5]';
    vec_down    = [img_resul(i+1,j).c1,img_resul(i+1,j).c2,img_resul(i+1,j).c3,img_resul(i+1,j).c4,img_resul(i+1,j).c5]';
    %             vec_duright = [img_resul(i-1,j+1).c1,img_resul(i-1,j+1).c2,img_resul(i-1,j+1).c3,img_resul(i-1,j+1).c4,img_resul(i-1,j+1).c5]';
    vec_ddright = [img_resul(i+1,j+1).c1,img_resul(i+1,j+1).c2,img_resul(i+1,j+1).c3,img_resul(i+1,j+1).c4,img_resul(i+1,j+1).c5]';
    %             vec_duleft  = [img_resul(i-1,j-1).c1,img_resul(i-1,j-1).c2,img_resul(i-1,j-1).c3,img_resul(i-1,j-1).c4,img_resul(i-1,j-1).c5]';
    vec_ddleft  = [img_resul(i+1,j-1).c1,img_resul(i+1,j-1).c2,img_resul(i+1,j-1).c3,img_resul(i+1,j-1).c4,img_resul(i+1,j-1).c5]';
      
    
    
    %correlations
    cl  = (corr(vec_central,vec_left));
    cu  = -1; % corr(vec_central,vec_up);
    cr  = (corr(vec_central,vec_right));
    cd  = (corr(vec_central,vec_down));
    cdur= -1; % corr(vec_central,vec_duright);
    cddr= (corr(vec_central,vec_ddright));
    cdul= -1; % corr(vec_central,vec_duleft);
    cddl= (corr(vec_central,vec_ddleft));
    
   
    
    output = [cl , cddl , cd , cddr, cr , cdur, cu, cdul];



%CASE 4 : Position on the last column but not on extreme up or down.
elseif (i>= 2) && (i< numberLines) && (j== numberColumns)


    vec_central = [img_resul(i,j).c1,img_resul(i,j).c2,img_resul(i,j).c3,img_resul(i,j).c4,img_resul(i,j).c5]';
    vec_left    = [img_resul(i,j-1).c1,img_resul(i,j-1).c2,img_resul(i,j-1).c3,img_resul(i,j-1).c4,img_resul(i,j-1).c5]';
    vec_up      = [img_resul(i-1,j).c1,img_resul(i-1,j).c2,img_resul(i-1,j).c3,img_resul(i-1,j).c4,img_resul(i-1,j).c5]';
    %             vec_right   = [img_resul(i,j+1).c1,img_resul(i,j+1).c2,img_resul(i,j+1).c3,img_resul(i,j+1).c4,img_resul(i,j+1).c5]';
    vec_down    = [img_resul(i+1,j).c1,img_resul(i+1,j).c2,img_resul(i+1,j).c3,img_resul(i+1,j).c4,img_resul(i+1,j).c5]';
    %             vec_duright = [img_resul(i-1,j+1).c1,img_resul(i-1,j+1).c2,img_resul(i-1,j+1).c3,img_resul(i-1,j+1).c4,img_resul(i-1,j+1).c5]';
    %             vec_ddright = [img_resul(i+1,j+1).c1,img_resul(i+1,j+1).c2,img_resul(i+1,j+1).c3,img_resul(i+1,j+1).c4,img_resul(i+1,j+1).c5]';
    vec_duleft  = [img_resul(i-1,j-1).c1,img_resul(i-1,j-1).c2,img_resul(i-1,j-1).c3,img_resul(i-1,j-1).c4,img_resul(i-1,j-1).c5]';
    vec_ddleft  = [img_resul(i+1,j-1).c1,img_resul(i+1,j-1).c2,img_resul(i+1,j-1).c3,img_resul(i+1,j-1).c4,img_resul(i+1,j-1).c5]';

    
    %correlations
    cl  = (corr(vec_central,vec_left));
    cu  = (corr(vec_central,vec_up));
    cr  = -1; % corr(vec_central,vec_right);
    cd  = (corr(vec_central,vec_down));
    cdur= -1; % corr(vec_central,vec_duright);
    cddr= -1; % corr(vec_central,vec_ddright);
    cdul= (corr(vec_central,vec_duleft));
    cddl= (corr(vec_central,vec_ddleft));
   
    output = [cl , cddl , cd , cddr, cr , cdur, cu, cdul];

    
%CASE 5 : Position on the last line but not on extreme left or right
elseif (i == numberLines)  && (j-1>=1) && (j < numberColumns)


    vec_central = [img_resul(i,j).c1,img_resul(i,j).c2,img_resul(i,j).c3,img_resul(i,j).c4,img_resul(i,j).c5]';
    vec_left    = [img_resul(i,j-1).c1,img_resul(i,j-1).c2,img_resul(i,j-1).c3,img_resul(i,j-1).c4,img_resul(i,j-1).c5]';
    vec_up      = [img_resul(i-1,j).c1,img_resul(i-1,j).c2,img_resul(i-1,j).c3,img_resul(i-1,j).c4,img_resul(i-1,j).c5]';
    vec_right   = [img_resul(i,j+1).c1,img_resul(i,j+1).c2,img_resul(i,j+1).c3,img_resul(i,j+1).c4,img_resul(i,j+1).c5]';
    %             vec_down    = [img_resul(i+1,j).c1,img_resul(i+1,j).c2,img_resul(i+1,j).c3,img_resul(i+1,j).c4,img_resul(i+1,j).c5]';
    vec_duright = [img_resul(i-1,j+1).c1,img_resul(i-1,j+1).c2,img_resul(i-1,j+1).c3,img_resul(i-1,j+1).c4,img_resul(i-1,j+1).c5]';
    %             vec_ddright = [img_resul(i+1,j+1).c1,img_resul(i+1,j+1).c2,img_resul(i+1,j+1).c3,img_resul(i+1,j+1).c4,img_resul(i+1,j+1).c5]';
    vec_duleft  = [img_resul(i-1,j-1).c1,img_resul(i-1,j-1).c2,img_resul(i-1,j-1).c3,img_resul(i-1,j-1).c4,img_resul(i-1,j-1).c5]';
    %             vec_ddleft  = [img_resul(i+1,j-1).c1,img_resul(i+1,j-1).c2,img_resul(i+1,j-1).c3,img_resul(i+1,j-1).c4,img_resul(i+1,j-1).c5]';
    
    %correlations
    cl  = (corr(vec_central,vec_left));
    cu  = (corr(vec_central,vec_up));
    cr  = (corr(vec_central,vec_right));
    cd  = -1; %corr(vec_central,vec_down);
    cdur= (corr(vec_central,vec_duright));
    cddr= -1; % corr(vec_central,vec_ddright);
    cdul= (corr(vec_central,vec_duleft));
    cddl= -1; % corr(vec_central,vec_ddleft);
    
    output = [cl , cddl , cd , cddr, cr , cdur, cu, cdul];
    
%CASE 6 : Position on the first position (1st line and 1st column).
elseif (i== 1) && (j==1)


    vec_central = [img_resul(i,j).c1,img_resul(i,j).c2,img_resul(i,j).c3,img_resul(i,j).c4,img_resul(i,j).c5]';
    %             vec_left    = [img_resul(i,j-1).c1,img_resul(i,j-1).c2,img_resul(i,j-1).c3,img_resul(i,j-1).c4,img_resul(i,j-1).c5]';
    %              vec_up      = [img_resul(i-1,j).c1,img_resul(i-1,j).c2,img_resul(i-1,j).c3,img_resul(i-1,j).c4,img_resul(i-1,j).c5]';
    vec_right   = [img_resul(i,j+1).c1,img_resul(i,j+1).c2,img_resul(i,j+1).c3,img_resul(i,j+1).c4,img_resul(i,j+1).c5]';
    vec_down    = [img_resul(i+1,j).c1,img_resul(i+1,j).c2,img_resul(i+1,j).c3,img_resul(i+1,j).c4,img_resul(i+1,j).c5]';
    %             vec_duright = [img_resul(i-1,j+1).c1,img_resul(i-1,j+1).c2,img_resul(i-1,j+1).c3,img_resul(i-1,j+1).c4,img_resul(i-1,j+1).c5]';
    vec_ddright = [img_resul(i+1,j+1).c1,img_resul(i+1,j+1).c2,img_resul(i+1,j+1).c3,img_resul(i+1,j+1).c4,img_resul(i+1,j+1).c5]';
    %             vec_duleft  = [img_resul(i-1,j-1).c1,img_resul(i-1,j-1).c2,img_resul(i-1,j-1).c3,img_resul(i-1,j-1).c4,img_resul(i-1,j-1).c5]';
    %             vec_ddleft  = [img_resul(i+1,j-1).c1,img_resul(i+1,j-1).c2,img_resul(i+1,j-1).c3,img_resul(i+1,j-1).c4,img_resul(i+1,j-1).c5]';
   
    %correlations
    cl  = -1; % corr(vec_central,vec_left);
    cu  = -1; % corr(vec_central,vec_up);
    cr  = (corr(vec_central,vec_right));
    cd  = (corr(vec_central,vec_down));
    cdur= -1; % corr(vec_central,vec_duright);
    cddr= (corr(vec_central,vec_ddright));
    cdul= -1; % corr(vec_central,vec_duleft);
    cddl= -1; % corr(vec_central,vec_ddleft);

    output = [cl , cddl , cd , cddr, cr , cdur, cu, cdul];


%quina superior direita

%CASE 7 : Position on the last position of the 1st line.
elseif (i== 1) && (j==numberColumns)


    vec_central = [img_resul(i,j).c1,img_resul(i,j).c2,img_resul(i,j).c3,img_resul(i,j).c4,img_resul(i,j).c5]';
    vec_left    = [img_resul(i,j-1).c1,img_resul(i,j-1).c2,img_resul(i,j-1).c3,img_resul(i,j-1).c4,img_resul(i,j-1).c5]';
    %              vec_up      = [img_resul(i-1,j).c1,img_resul(i-1,j).c2,img_resul(i-1,j).c3,img_resul(i-1,j).c4,img_resul(i-1,j).c5]';
    %             vec_right   = [img_resul(i,j+1).c1,img_resul(i,j+1).c2,img_resul(i,j+1).c3,img_resul(i,j+1).c4,img_resul(i,j+1).c5]';
    vec_down    = [img_resul(i+1,j).c1,img_resul(i+1,j).c2,img_resul(i+1,j).c3,img_resul(i+1,j).c4,img_resul(i+1,j).c5]';
    %             vec_duright = [img_resul(i-1,j+1).c1,img_resul(i-1,j+1).c2,img_resul(i-1,j+1).c3,img_resul(i-1,j+1).c4,img_resul(i-1,j+1).c5]';
    %             vec_ddright = [img_resul(i+1,j+1).c1,img_resul(i+1,j+1).c2,img_resul(i+1,j+1).c3,img_resul(i+1,j+1).c4,img_resul(i+1,j+1).c5]';
    %             vec_duleft  = [img_resul(i-1,j-1).c1,img_resul(i-1,j-1).c2,img_resul(i-1,j-1).c3,img_resul(i-1,j-1).c4,img_resul(i-1,j-1).c5]';
    vec_ddleft  = [img_resul(i+1,j-1).c1,img_resul(i+1,j-1).c2,img_resul(i+1,j-1).c3,img_resul(i+1,j-1).c4,img_resul(i+1,j-1).c5]';
    
    %correlations
    cl  = (corr(vec_central,vec_left));
    cu  = -1; % corr(vec_central,vec_up);
    cr  = -1; % corr(vec_central,vec_right);
    cd  = (corr(vec_central,vec_down));
    cdur= -1; % corr(vec_central,vec_duright);
    cddr= -1; % corr(vec_central,vec_ddright);
    cdul= -1; % corr(vec_central,vec_duleft);
    cddl= (corr(vec_central,vec_ddleft));
  
    
    output = [cl , cddl , cd , cddr, cr , cdur, cu, cdul];


%CASE 8 : Position on the last column and the last line.
elseif (i== numberLines) && (j==numberColumns)


    vec_central = [img_resul(i,j).c1,img_resul(i,j).c2,img_resul(i,j).c3,img_resul(i,j).c4,img_resul(i,j).c5]';
    vec_left    = [img_resul(i,j-1).c1,img_resul(i,j-1).c2,img_resul(i,j-1).c3,img_resul(i,j-1).c4,img_resul(i,j-1).c5]';
    vec_up      = [img_resul(i-1,j).c1,img_resul(i-1,j).c2,img_resul(i-1,j).c3,img_resul(i-1,j).c4,img_resul(i-1,j).c5]';
    %             vec_right   = [img_resul(i,j+1).c1,img_resul(i,j+1).c2,img_resul(i,j+1).c3,img_resul(i,j+1).c4,img_resul(i,j+1).c5]';
    %             vec_down    = [img_resul(i+1,j).c1,img_resul(i+1,j).c2,img_resul(i+1,j).c3,img_resul(i+1,j).c4,img_resul(i+1,j).c5]';
    %              vec_duright = [img_resul(i-1,j+1).c1,img_resul(i-1,j+1).c2,img_resul(i-1,j+1).c3,img_resul(i-1,j+1).c4,img_resul(i-1,j+1).c5]';
    %             vec_ddright = [img_resul(i+1,j+1).c1,img_resul(i+1,j+1).c2,img_resul(i+1,j+1).c3,img_resul(i+1,j+1).c4,img_resul(i+1,j+1).c5]';
    vec_duleft  = [img_resul(i-1,j-1).c1,img_resul(i-1,j-1).c2,img_resul(i-1,j-1).c3,img_resul(i-1,j-1).c4,img_resul(i-1,j-1).c5]';
    %              vec_ddleft  = [img_resul(i+1,j-1).c1,img_resul(i+1,j-1).c2,img_resul(i+1,j-1).c3,img_resul(i+1,j-1).c4,img_resul(i+1,j-1).c5]';
    
    %correlations
    cl  = (corr(vec_central,vec_left));
    cu  = (corr(vec_central,vec_up));
    cr  = -1; % corr(vec_central,vec_right);
    cd  = -1; % corr(vec_central,vec_down);
    cdur= -1; % corr(vec_central,vec_duright);
    cddr= -1; % corr(vec_central,vec_ddright);
    cdul= (corr(vec_central,vec_duleft));
    cddl=-1; % corr(vec_central,vec_ddleft);
    
    output = [cl , cddl , cd , cddr, cr , cdur, cu, cdul];


%CASE 9 : Position on the last place of the first column.
else (i== numberLines) && (j==1)


    vec_central = [img_resul(i,j).c1,img_resul(i,j).c2,img_resul(i,j).c3,img_resul(i,j).c4,img_resul(i,j).c5]';
    %              vec_left    = [img_resul(i,j-1).c1,img_resul(i,j-1).c2,img_resul(i,j-1).c3,img_resul(i,j-1).c4,img_resul(i,j-1).c5]';
    vec_up      = [img_resul(i-1,j).c1,img_resul(i-1,j).c2,img_resul(i-1,j).c3,img_resul(i-1,j).c4,img_resul(i-1,j).c5]';
    vec_right   = [img_resul(i,j+1).c1,img_resul(i,j+1).c2,img_resul(i,j+1).c3,img_resul(i,j+1).c4,img_resul(i,j+1).c5]';
    %             vec_down    = [img_resul(i+1,j).c1,img_resul(i+1,j).c2,img_resul(i+1,j).c3,img_resul(i+1,j).c4,img_resul(i+1,j).c5]';
    vec_duright = [img_resul(i-1,j+1).c1,img_resul(i-1,j+1).c2,img_resul(i-1,j+1).c3,img_resul(i-1,j+1).c4,img_resul(i-1,j+1).c5]';
    %             vec_ddright = [img_resul(i+1,j+1).c1,img_resul(i+1,j+1).c2,img_resul(i+1,j+1).c3,img_resul(i+1,j+1).c4,img_resul(i+1,j+1).c5]';
    %              vec_duleft  = [img_resul(i-1,j-1).c1,img_resul(i-1,j-1).c2,img_resul(i-1,j-1).c3,img_resul(i-1,j-1).c4,img_resul(i-1,j-1).c5]';
    %              vec_ddleft  = [img_resul(i+1,j-1).c1,img_resul(i+1,j-1).c2,img_resul(i+1,j-1).c3,img_resul(i+1,j-1).c4,img_resul(i+1,j-1).c5]';
    
    
    
    %correlations
    cl  = -1; % corr(vec_central,vec_left);
    cu  = (corr(vec_central,vec_up));
    cr  = (corr(vec_central,vec_right));
    cd  = -1; % corr(vec_central,vec_down);
    cdur= (corr(vec_central,vec_duright));
    cddr= -1; % corr(vec_central,vec_ddright);
    cdul= -1; % corr(vec_central,vec_duleft);
    cddl= -1; % corr(vec_central,vec_ddleft);
    
    
    output = [cl , cddl , cd , cddr, cr , cdur, cu, cdul];



end

