clear all; clc;

%TODO - Ver as condicoes pois nao estao contemplando todas as
%possibilidades.

%vamos ter 5 imagens de dimensões "nxn" e vamos contruir uma imagem
%apenas delas todas

%numero de linhas e colunas da matriz imagem resultado para ser usada
%depois.

numberLines = 300;
numberColumns = 300;

%emulacao das imagens a serem recebidas pelo programa.
img1 = randn(numberLines,numberColumns);
img2 = randn(numberLines,numberColumns);
img3 = randn(numberLines,numberColumns);
img4 = randn(numberLines,numberColumns);
img5 = randn(numberLines,numberColumns);

%definindo uma matriz img_resul que cada elemento dela agregue os 5 valores
%que serao recebidos pelas as imagens dos contrastes.
for i=1:numberLines
    for j = 1:numberColumns
        img_resul(i,j).c1 = img1(i,j);
        img_resul(i,j).c2 = img2(i,j);
        img_resul(i,j).c3 = img3(i,j);
        img_resul(i,j).c4 = img4(i,j);
        img_resul(i,j).c5 = img5(i,j);
        img_resul(i,j).family = -1;
    end
end


%variaveis de auxilio
Indices  = [];
i_antigo = [];
j_antigo = [];
numberRepetitions= 0;
debug_todosOsIs = [];
debug_todosOsJs = [];
contador = 0;

%Implementação do algoritmo de Clustering
for x_int=1:numberLines
    for y_int = 1:numberColumns
        
        i = x_int;
        j = y_int;
        numberRepetitions = numberRepetitions+1;
        debug_todosOsIs = [ debug_todosOsIs i];
        debug_todosOsJs = [ debug_todosOsJs j];
        i_antigo = [];
        j_antigo = [];
    
        newposition=1 ; %This variable determinates if the the algorithm can keep advancing towards the next most correlated
        %position. If the next most correlated position is the position
        %that brought to the current position, then is setted to 0.
        
        while (newposition==1)
          
            %Checking if the current position has already been setted with
            %a "family" number. i.e: if img_result(i,j).family = 2 ; then
            %skip everything and go to the next loop
%             if (img_resul(i,j).family == -1)
              
                %Dentro do plano (nem na primeira ou ultima linha e coluna)
                if (i-1 >= 1) && ( i+1 <= numberLines ) && (j-1 >= 1) && ( j+1 <= numberColumns )

                    vector = ComputeVectors(i,j,img_resul,numberLines,numberColumns);
                    vectorN = {'cl' , 'cddl' , 'cd' , 'cddr', 'cr' , 'cdur', 'cu', 'cdul'};
                    [val idx] = max(vector);
                    img_resul(i,j).family = numberRepetitions;

                    %Apontando para o proximo que deve-se ir:
                    contador = contador + 1;
                    i_antigo=[i_antigo i];
                    j_antigo = [j_antigo j];
                    
                    nextPosition = PointingNextPlace(i,j,i_antigo,j_antigo,vectorN,idx,newposition);
                    i= nextPosition(1);
                    j=nextPosition(2);
                    newposition=nextPosition(3);
                    
                    %se a proxima posicao ja tiver sido marcada com um
                    %family number, entao a posicao atual deve ser marcada
                    %com o valor da familia da proxima posicao e deve-se
                    %avancar. Tudo isso uma vez que estejamos indo a um
                    %numero novo, pois se for a posicao antiga, nao nos
                    %interessa.
                    if(newposition ==1) && (img_resul(nextPosition(1),nextPosition(2)).family ~= -1)
                        img_resul(i_antigo(numel(i_antigo)),j_antigo(numel(j_antigo))).family = img_resul(nextPosition(1),nextPosition(2)).family;
                        newposition =0;
                    end
                    
                    

                    
                %Primeira Coluna e nao seja quina.
                elseif (i-1 >= 1) && (i<numberLines) && (j==1)

                    vector = ComputeVectors(i,j,img_resul,numberLines,numberColumns);
                    vectorN = {'cl' , 'cddl' , 'cd' , 'cddr', 'cr' , 'cdur', 'cu', 'cdul'};
                    [val idx] = max(vector);
                    img_resul(i,j).family = numberRepetitions;

                    %Apontando para o proximo que deve-se ir:
                    contador = contador + 1;
                    i_antigo=[i_antigo i];
                    j_antigo = [j_antigo j];

                    nextPosition = PointingNextPlace(i,j,i_antigo,j_antigo,vectorN,idx,newposition);
                    i= nextPosition(1);
                    j=nextPosition(2);
                    
                    newposition=nextPosition(3);
                    
                    if(newposition ==1) && (img_resul(nextPosition(1),nextPosition(2)).family ~= -1)
                        img_resul(i_antigo(numel(i_antigo)),j_antigo(numel(j_antigo))).family = img_resul(nextPosition(1),nextPosition(2)).family;
                        newposition =0;
                    end

                %Topo  e nao seja quina.
                elseif (i== 1)  && (j-1>=1) && (j+1 <= numberColumns)

                    vector = ComputeVectors(i,j,img_resul,numberLines,numberColumns);
                    vectorN = {'cl' , 'cddl' , 'cd' , 'cddr', 'cr' , 'cdur', 'cu', 'cdul'};
                    [val idx] = max(vector);
                    img_resul(i,j).family =numberRepetitions ;

                    %Apontando para o proximo que deve-se ir:
                    contador = contador + 1;
                    i_antigo=[i_antigo i];
                    j_antigo = [j_antigo j];

                    nextPosition = PointingNextPlace(i,j,i_antigo,j_antigo,vectorN,idx,newposition);
                    i= nextPosition(1);
                    j=nextPosition(2);
                    newposition=nextPosition(3);
                    
                    if(newposition ==1) && (img_resul(nextPosition(1),nextPosition(2)).family ~= -1)
                        img_resul(i_antigo(numel(i_antigo)),j_antigo(numel(j_antigo))).family = img_resul(nextPosition(1),nextPosition(2)).family;
                        newposition =0;
                    end
                    
                %Ultima Coluna nao seja quina.
                elseif (i>= 2) && (i< numberLines) && (j== numberColumns)

                    vector = ComputeVectors(i,j,img_resul,numberLines,numberColumns);
                    vectorN = {'cl' , 'cddl' , 'cd' , 'cddr', 'cr' , 'cdur', 'cu', 'cdul'};
                    [val idx] = max(vector);
                    img_resul(i,j).family = numberRepetitions;

                    %Apontando para o proximo que deve-se ir:
                    contador = contador + 1;
                    i_antigo=[i_antigo i];
                    j_antigo = [j_antigo j];

                    nextPosition = PointingNextPlace(i,j,i_antigo,j_antigo,vectorN,idx,newposition);
                    i= nextPosition(1);
                    j=nextPosition(2);
                    newposition=nextPosition(3);
                    
                    if(newposition ==1) && (img_resul(nextPosition(1),nextPosition(2)).family ~= -1)
                        img_resul(i_antigo(numel(i_antigo)),j_antigo(numel(j_antigo))).family = img_resul(nextPosition(1),nextPosition(2)).family;
                        newposition =0;
                    end


                %Ultima Linha e nao seja quina.
                elseif (i == numberLines)  && (j-1>=1) && (j < numberColumns)

                    %modelo adotado: [anti horario comecando da esquerda]
                    vector = ComputeVectors(i,j,img_resul,numberLines,numberColumns);
                    vectorN = {'cl' , 'cddl' , 'cd' , 'cddr', 'cr' , 'cdur', 'cu', 'cdul'};
                    [val idx] = max(vector);
                    img_resul(i,j).family = numberRepetitions;

                    %Apontando para o proximo que deve-se ir:
                    contador = contador + 1;
                    i_antigo=[i_antigo i];
                    j_antigo = [j_antigo j];

                    nextPosition = PointingNextPlace(i,j,i_antigo,j_antigo,vectorN,idx,newposition);
                    i= nextPosition(1);
                    j=nextPosition(2);
                    newposition=nextPosition(3);
                    
                    if(newposition ==1) && (img_resul(nextPosition(1),nextPosition(2)).family ~= -1)
                        img_resul(i_antigo(numel(i_antigo)),j_antigo(numel(j_antigo))).family = img_resul(nextPosition(1),nextPosition(2)).family;
                        newposition =0;
                    end

                %Topo  e seja quina esquerda.
                elseif (i== 1) && (j==1)

                    vector = ComputeVectors(i,j,img_resul,numberLines,numberColumns);
                    vectorN = {'cl' , 'cddl' , 'cd' , 'cddr', 'cr' , 'cdur', 'cu', 'cdul'};
                    [val idx] = max(vector);
                    img_resul(i,j).family = numberRepetitions;

                    %Apontando para o proximo que deve-se ir:
                    contador = contador + 1;
                    i_antigo=[i_antigo i];
                    j_antigo = [j_antigo j];

                    nextPosition = PointingNextPlace(i,j,i_antigo,j_antigo,vectorN,idx,newposition);
                    i= nextPosition(1);
                    j=nextPosition(2);
                    newposition=nextPosition(3);
                    
                    if(newposition ==1) && (img_resul(nextPosition(1),nextPosition(2)).family ~= -1)
                        img_resul(i_antigo(numel(i_antigo)),j_antigo(numel(j_antigo))).family = img_resul(nextPosition(1),nextPosition(2)).family;
                        newposition =0;
                    end

                %Quina superior direita
                elseif (i== 1) && (j==numberColumns)

                    vector = ComputeVectors(i,j,img_resul,numberLines,numberColumns);
                    vectorN = {'cl' , 'cddl' , 'cd' , 'cddr', 'cr' , 'cdur', 'cu', 'cdul'};
                    [val idx] = max(vector);
                    img_resul(i,j).family = numberRepetitions;

                    %Apontando para o proximo que deve-se ir:
                    contador = contador + 1;
                    i_antigo=[i_antigo i];
                    j_antigo = [j_antigo j];


                    nextPosition = PointingNextPlace(i,j,i_antigo,j_antigo,vectorN,idx,newposition);
                    i= nextPosition(1);
                    j=nextPosition(2);
                    newposition=nextPosition(3);
                    
                    if(newposition ==1) && (img_resul(nextPosition(1),nextPosition(2)).family ~= -1)
                        img_resul(i_antigo(numel(i_antigo)),j_antigo(numel(j_antigo))).family = img_resul(nextPosition(1),nextPosition(2)).family;
                        newposition =0;
                    end

                %Quina inferior direita
                elseif (i== numberLines) && (j==numberColumns)

                    vector = ComputeVectors(i,j,img_resul,numberLines,numberColumns);
                    vectorN = {'cl' , 'cddl' , 'cd' , 'cddr', 'cr' , 'cdur', 'cu', 'cdul'};
                    [val idx] = max(vector);
                    img_resul(i,j).family = numberRepetitions;

                    %Apontando para o proximo que deve-se
                    %ir:
                    contador = contador + 1;
                    i_antigo=[i_antigo i];
                    j_antigo = [j_antigo j];


                    nextPosition = PointingNextPlace(i,j,i_antigo,j_antigo,vectorN,idx,newposition);
                    i= nextPosition(1);
                    j=nextPosition(2);
                    newposition=nextPosition(3);
                    
                    if(newposition ==1) && (img_resul(nextPosition(1),nextPosition(2)).family ~= -1)
                        img_resul(i_antigo(numel(i_antigo)),j_antigo(numel(j_antigo))).family = img_resul(nextPosition(1),nextPosition(2)).family;
                        newposition =0;
                    end


                %Quina inferior esquerda
                else (i== numberLines) && (j==1)

                    vector = ComputeVectors(i,j,img_resul,numberLines,numberColumns);
                    vectorN = {'cl' , 'cddl' , 'cd' , 'cddr', 'cr' , 'cdur', 'cu', 'cdul'};
                    [val idx] = max(vector);
                    img_resul(i,j).family = numberRepetitions;

                    %Apontando para o proximo que deve-se ir:
                    contador = contador + 1;
                    i_antigo=[i_antigo i];
                    j_antigo = [j_antigo j];


                    nextPosition = PointingNextPlace(i,j,i_antigo,j_antigo,vectorN,idx,newposition);
                    i= nextPosition(1);
                    j=nextPosition(2);
                    newposition=nextPosition(3);
                    
                    if(newposition ==1) && (img_resul(nextPosition(1),nextPosition(2)).family ~= -1)
                        img_resul(i_antigo(numel(i_antigo)),j_antigo(numel(j_antigo))).family = img_resul(nextPosition(1),nextPosition(2)).family;
                        newposition =0;
                    end



                end

            
%             else
%                 newposition=0;
%             
%             end 
            
        end
        
        
    end
end


for i=1:numberLines
    for j=1:numberColumns
        matrizFamilia(i,j) = img_resul(i,j).family;
    end
end
pcolor(matrizFamilia)
