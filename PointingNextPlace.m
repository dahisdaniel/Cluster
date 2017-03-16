function output  = PointingNextPlace(i,j,i_antigo,j_antigo, vectorN,idx1,a)
    %Teste para marcar a 2a posicao!
    


%-----end


    if strcmp(vectorN(idx1),'cl')
        i = i;
        j = j-1;
        if (numel(i_antigo)>1) && (i == i_antigo(numel(i_antigo)-1)) && (j ==j_antigo(numel(j_antigo)-1))
            a=0;
        end

    elseif strcmp(vectorN(idx1),'cddl')
        i = i+1;
        j = j-1;
        if (numel(i_antigo)>1) &&(i == i_antigo(numel(i_antigo)-1)) && (j ==j_antigo(numel(j_antigo)-1))
            a=0;
        end

    elseif strcmp(vectorN(idx1),'cd')
        i = i+1;
        j = j;
        if (numel(i_antigo)>1) &&(i == i_antigo(numel(i_antigo)-1)) && (j ==j_antigo(numel(j_antigo)-1))
            a=0;
        end

    elseif strcmp(vectorN(idx1),'cddr')
        i = i+1;
        j = j+1;
        if (numel(i_antigo)>1) &&(i == i_antigo(numel(i_antigo)-1)) && (j ==j_antigo(numel(j_antigo)-1))
            a=0;
        end

    elseif strcmp(vectorN(idx1),'cr')
        i = i;
        j = j+1;
        if (numel(i_antigo)>1) &&(i == i_antigo(numel(i_antigo)-1)) && (j ==j_antigo(numel(j_antigo)-1))
            a=0;
        end

    elseif strcmp(vectorN(idx1),'cdur')
        i = i-1;
        j = j+1;
        if (numel(i_antigo)>1) &&(i == i_antigo(numel(i_antigo)-1)) && (j ==j_antigo(numel(j_antigo)-1))
            a=0;
        end

    elseif strcmp(vectorN(idx1),'cu')
        i = i-1;
        j = j;
        if (numel(i_antigo)>1) &&(i == i_antigo(numel(i_antigo)-1)) && (j ==j_antigo(numel(j_antigo)-1))
            a=0;
        end

    else strcmp(vectorN(idx1),'cdul')
        i = i-1;
        j = j-1;
        if (numel(i_antigo)>1) &&(i == i_antigo(numel(i_antigo)-1)) && (j ==j_antigo(numel(j_antigo)-1))
            a=0;
        end
    end
    
    output = [ i , j , a];


     
end

