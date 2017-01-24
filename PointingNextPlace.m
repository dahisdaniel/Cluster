function output  = PointingNextPlace(i,j,i_antigo,j_antigo, vectorN,idx,a)
%TESTE Summary of this function goes here
%   Detailed explanation goes here
    if strcmp(vectorN(idx),'cl')
        i = i;
        j = j-1;
        if (numel(i_antigo)>1) && (i == i_antigo(numel(i_antigo)-1)) && (j ==j_antigo(numel(j_antigo)-1))
            a=0;
        end

    elseif strcmp(vectorN(idx),'cddl')
        i = i+1;
        j = j-1;
        if (numel(i_antigo)>1) &&(i == i_antigo(numel(i_antigo)-1)) && (j ==j_antigo(numel(j_antigo)-1))
            a=0;
        end

    elseif strcmp(vectorN(idx),'cd')
        i = i+1;
        j = j;
        if (numel(i_antigo)>1) &&(i == i_antigo(numel(i_antigo)-1)) && (j ==j_antigo(numel(j_antigo)-1))
            a=0;
        end

    elseif strcmp(vectorN(idx),'cddr')
        i = i+1;
        j = j+1;
        if (numel(i_antigo)>1) &&(i == i_antigo(numel(i_antigo)-1)) && (j ==j_antigo(numel(j_antigo)-1))
            a=0;
        end

    elseif strcmp(vectorN(idx),'cr')
        i = i;
        j = j+1;
        if (numel(i_antigo)>1) &&(i == i_antigo(numel(i_antigo)-1)) && (j ==j_antigo(numel(j_antigo)-1))
            a=0;
        end

    elseif strcmp(vectorN(idx),'cdur')
        i = i-1;
        j = j+1;
        if (numel(i_antigo)>1) &&(i == i_antigo(numel(i_antigo)-1)) && (j ==j_antigo(numel(j_antigo)-1))
            a=0;
        end

    elseif strcmp(vectorN(idx),'cu')
        i = i-1;
        j = j;
        if (numel(i_antigo)>1) &&(i == i_antigo(numel(i_antigo)-1)) && (j ==j_antigo(numel(j_antigo)-1))
            a=0;
        end

    else strcmp(vectorN(idx),'cdul')
        i = i-1;
        j = j-1;
        if (numel(i_antigo)>1) &&(i == i_antigo(numel(i_antigo)-1)) && (j ==j_antigo(numel(j_antigo)-1))
            a=0;
        end
    end
    
    output = [ i , j , a];


     
end

