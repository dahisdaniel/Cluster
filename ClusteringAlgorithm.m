clear all
%vamos ter 5 imagens de dimensões "20x20" e vamos contruir uma imagem
%apenas delas todas

%numero de linhas e colunas da matriz imagem resultado para ser usada
%depois.

numberLines = 20;
numberColumns = 20;

%emulacao das imagens a serem recebidas pelo programa.
img1 = randn(20,20);
img2 = randn(20,20);
img3 = randn(20,20);
img4 = randn(20,20);
img5 = randn(20,20);

%definindo uma matriz img_resul que cada elemento dela agregue os 5 valores
%que serao recebidos pelas as imagens dos contrastes.
for i=1:20
    for j = 1:20
        img_resul(i,j).c1 = img1(i,j);
        img_resul(i,j).c2 = img2(i,j);
        img_resul(i,j).c3 = img3(i,j);
        img_resul(i,j).c4 = img4(i,j);
        img_resul(i,j).c5 = img5(i,j);
    end
end


Indices  = []; 
i_antigo = [];
j_antigo = [];
contador = 0;
% Implementação do algoritmo de Clustering
for i=1:numberLines
    for j = 1:numberColumns
   
       a=1 ; 
       while a==1
           
           
        %caso geral: nao estar na "borda" e com isso poder comparar com
        %toda vizinhança. 
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
        
            %correlations
            cl  = corr(vec_central,vec_left);
            cu  = corr(vec_central,vec_up);
            cr  = corr(vec_central,vec_right);
            cd  = corr(vec_central,vec_down);
            cdur= corr(vec_central,vec_duright);
            cddr= corr(vec_central,vec_ddright);
            cdul= corr(vec_central,vec_duleft);
            cddl= corr(vec_central,vec_ddleft);
        
            %modelo adotado: [anti horario comecando da esquerda]
            vector = [cl , cddl , cd , cddr, cr , cdur, cu, cdul];
            vectorN = {'cl' , 'cddl' , 'cd' , 'cddr', 'cr' , 'cdur', 'cu', 'cdul'};
            [val idx] = max(vector);
            
            %Apontando para o proximo que deve-se
            %ir:
            contador = contador + 1;
            i_antigo=[i_antigo i];
            j_antigo = [j_antigo j];

            
            if strcmp(vectorN(idx),'cl')               
                i = i;
                j = j-1;
                if (numel(i_antigo)>1) && (i == i_antigo(numel(i_antigo)-1)) && (j ==j_antigo(numel(j_antigo)-1))
                a=0;
                disp('boom1')
                end
                
            end
            
            if strcmp(vectorN(idx),'cddl')
                i = i+1;
                j = j-1;  
                if (numel(i_antigo)>1) &&(i == i_antigo(numel(i_antigo)-1)) && (j ==j_antigo(numel(j_antigo)-1))
                a=0;
                
                disp('boom2')
                end
            end
            
            if strcmp(vectorN(idx),'cd')
                i = i+1;
                j = j;    
                if (numel(i_antigo)>1) &&(i == i_antigo(numel(i_antigo)-1)) && (j ==j_antigo(numel(j_antigo)-1))
                a=0;
                
                disp('boom3')
                end
            end

            if strcmp(vectorN(idx),'cddr')
                i = i+1;
                j = j+1;
                if (numel(i_antigo)>1) &&(i == i_antigo(numel(i_antigo)-1)) && (j ==j_antigo(numel(j_antigo)-1))
                a=0;
                
                disp('boom4')
                end
            end

            if strcmp(vectorN(idx),'cr')
                i = i;
                j = j+1;  
                if (numel(i_antigo)>1) &&(i == i_antigo(numel(i_antigo)-1)) && (j ==j_antigo(numel(j_antigo)-1))
                a=0;
                
                disp('boom5')
                end
            end

            if strcmp(vectorN(idx),'cdur')
                i = i-1;
                j = j+1;
                if (numel(i_antigo)>1) &&(i == i_antigo(numel(i_antigo)-1)) && (j ==j_antigo(numel(j_antigo)-1))
                a=0;
                
                disp('boom6')
                end
            end
            
            if strcmp(vectorN(idx),'cu')
                i = i-1;
                j = j;
                if (numel(i_antigo)>1) &&(i == i_antigo(numel(i_antigo)-1)) && (j ==j_antigo(numel(j_antigo)-1))
                a=0;
                
                disp('boom7')
                end
            end
            
            if strcmp(vectorN(idx),'cdul')
                i = i-1;
                j = j-1;
                if (numel(i_antigo)>1) &&(i == i_antigo(numel(i_antigo)-1)) && (j ==j_antigo(numel(j_antigo)-1))
                a=0;
                
                disp('boom8')
                end
            end
            
            
            

            

            
            end
       a=0;
            
       end   
            
            
    end
end