%clear all; clc;
%TODO - Todos o processo de imigracao de imagem estao na funcao Imaging
%preparing. Porem tem valores NaN, como proceder? os For`s nao estao
%funcionando na funcao ImagingPreparing.

%vamos ter 5 imagens de dimensões "nxn" e vamos contruir uma imagem
%apenas delas todas

% numberLines = 30;
% numberColumns = 30;
% 
% %emulacao das imagens a serem recebidas pelo programa.
% img1 = randn(numberLines,numberColumns);
% img2 = randn(numberLines,numberColumns);
% img3 = randn(numberLines,numberColumns);
% img4 = randn(numberLines,numberColumns);
% img5 = randn(numberLines,numberColumns);
% 
% % %definindo uma matriz img_resul que cada elemento dela agregue os 5 valores
% % %que serao recebidos pelas as imagens dos contrastes.
% for i=1:numberLines
%     for j = 1:numberColumns
%         img_resul(i,j).c1 = img1(i,j);
%         img_resul(i,j).c2 = img2(i,j);
%         img_resul(i,j).c3 = img3(i,j);
%         img_resul(i,j).c4 = img4(i,j);
%         img_resul(i,j).c5 = img5(i,j);
%         img_resul(i,j).family = -1;
%     end
% end



%------------------------------------------------------

name1 =  '20161212_122142HeadDTIep2ddiffmddw30s008a001_regularized_m20161212_122142Headt1mpragesagp2isos106a1001.nii';
name2 =  'rm20161212_122142HeadSWIt2fl3dtrap2isos015a1001.nii';
name3 = 'rm20161212_122142HeadSWIt2fl3dtrap2isos017a1001.nii';
name4 = 'rm20161212_122142Headt2spcdaflsagp2isoFSs100a1001.nii';
name5 = 'rm20161212_122142Headt2spcsagp2isos102a1001.nii';
% 
% 
contrast1=load_untouch_nii(name1);
contrast2=load_untouch_nii(name2);
contrast3=load_untouch_nii(name3);
contrast4=load_untouch_nii(name4);
contrast5=load_untouch_nii(name5);

img1 = contrast1.img;
img2 = contrast2.img;
img3 = contrast3.img;
img4 = contrast4.img;
img5 = contrast5.img;

%testing purpuses: 2D

% img1_2d = img1(:,:,60);
% img2_2d = img2(:,:,60);
% img3_2d = img3(:,:,60);
% img4_2d = img4(:,:,60);
% img5_2d = img5(:,:,60);

%teste para volume passado
img1_2d = SWI(:,:,10);
img2_2d = SWIphase(:,:,10);
img3_2d = T1_SN(:,:,10);
img4_2d = T2_SN(:,:,10);
img5_2d = Fl_SN(:,:,10);




img1_2d(isnan(img1_2d))=0;
img2_2d(isnan(img2_2d))=0;
img3_2d(isnan(img3_2d))=0;
img4_2d(isnan(img4_2d))=0;
img5_2d(isnan(img5_2d))=0;

[numberLines,numberColumns] = size(img1_2d);

for i=1:numberLines
    for j = 1:numberColumns
        img_resul(i,j).c1 = img1_2d(i,j);
        img_resul(i,j).c2 = img2_2d(i,j);
        img_resul(i,j).c3 = img3_2d(i,j);
        img_resul(i,j).c4 = img4_2d(i,j);
        img_resul(i,j).c5 = img5_2d(i,j);
        img_resul(i,j).family = -1;
    end
end


%------------------------------------------------------




%variaveis de auxilio
Indices  = [];
i_antigo = [];
j_antigo = [];
numberRepetitions = 0;
loopCounter = 0;

%Implementação do algoritmo de Clustering
for x_int=1:numberLines
    for y_int = 1:numberColumns
        
        
        i = x_int;
        j = y_int;
        numberRepetitions = numberRepetitions+1;
%         if(loopCounter == 1)
%             
%         numberRepetitions = numberRepetitions+1;
%         else
%         numberRepetitions = numberRepetitions;
%         end
        i_antigo = [];
        j_antigo = [];
    
        newposition=1 ; %This variable determinates if the the algorithm can keep advancing towards the next most correlated
        %position. If the next most correlated position is the position
        %that brought to the current position, then is setted to 0.
        
        while (newposition==1)
                loopCounter= loopCounter + 1;
                
                %Dentro do plano (nem na primeira ou ultima linha e coluna)
                if (i-1 >= 1) && ( i+1 <= numberLines ) && (j-1 >= 1) && ( j+1 <= numberColumns )

                    %---NEW---%
                    vector = ComputeVectors(i,j,img_resul,numberLines,numberColumns);
                    vector(isnan(vector))=0;
                    
                    if (vector == 0)
                    newposition =0 ;
%                     img_resul(i,j).family = numberRepetitions;
                    img_resul(i,j).family = 0;
                    else
                    
                    
                    vectorN = {'cl' , 'cddl' , 'cd' , 'cddr', 'cr' , 'cdur', 'cu', 'cdul'};
                    [val idx] = max(vector);
                    img_resul(i,j).family = numberRepetitions;

                    %Apontando para o proximo que deve-se ir:
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
                    
                    end

                    
                %Primeira Coluna e nao seja quina.
                elseif (i-1 >= 1) && (i<numberLines) && (j==1)

                 
                    %---NEW---%
                    vector = ComputeVectors(i,j,img_resul,numberLines,numberColumns);
                    vector(isnan(vector))=0;
                    
                    if (vector == 0)
                    newposition =0 ;
%                     img_resul(i,j).family = numberRepetitions;
                    img_resul(i,j).family = 0;
                    else
                    
                    
                    vectorN = {'cl' , 'cddl' , 'cd' , 'cddr', 'cr' , 'cdur', 'cu', 'cdul'};
                    [val idx] = max(vector);
                    img_resul(i,j).family = numberRepetitions;

                    %Apontando para o proximo que deve-se ir:
                    
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

                %Topo  e nao seja quina.
                elseif (i== 1)  && (j-1>=1) && (j+1 <= numberColumns)

                    
                    %---NEW---%
                    vector = ComputeVectors(i,j,img_resul,numberLines,numberColumns);
                    vector(isnan(vector))=0;
                    
                    if (vector == 0)
                    newposition =0 ;
%                     img_resul(i,j).family = numberRepetitions;
                    img_resul(i,j).family = 0;
                    else
                        
                    vectorN = {'cl' , 'cddl' , 'cd' , 'cddr', 'cr' , 'cdur', 'cu', 'cdul'};
                    [val idx] = max(vector);
                    img_resul(i,j).family =numberRepetitions ;

                    %Apontando para o proximo que deve-se ir:
                   
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
                    
                %Ultima Coluna nao seja quina.
                elseif (i>= 2) && (i< numberLines) && (j== numberColumns)

                    
                    %---NEW---%
                    vector = ComputeVectors(i,j,img_resul,numberLines,numberColumns);
                    vector(isnan(vector))=0;
                    
                    if (vector == 0)
                    newposition =0 ;
%                     img_resul(i,j).family = numberRepetitions;
                    img_resul(i,j).family = 0;
                    else
                        
                    vectorN = {'cl' , 'cddl' , 'cd' , 'cddr', 'cr' , 'cdur', 'cu', 'cdul'};
                    [val idx] = max(vector);
                    img_resul(i,j).family = numberRepetitions;

                    %Apontando para o proximo que deve-se ir:
                   
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


                %Ultima Linha e nao seja quina.
                elseif (i == numberLines)  && (j-1>=1) && (j < numberColumns)

                    %modelo adotado: [anti horario comecando da esquerda]
                   
                    %---NEW---%
                    vector = ComputeVectors(i,j,img_resul,numberLines,numberColumns);
                    vector(isnan(vector))=0;
                    
                    if (vector == 0)
                    newposition =0 ;
%                     img_resul(i,j).family = numberRepetitions;
                    img_resul(i,j).family = 0;
                    else
                        
                    vectorN = {'cl' , 'cddl' , 'cd' , 'cddr', 'cr' , 'cdur', 'cu', 'cdul'};
                    [val idx] = max(vector);
                    img_resul(i,j).family = numberRepetitions;

                    %Apontando para o proximo que deve-se ir:
                   
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

                %Topo  e seja quina esquerda.
                elseif (i== 1) && (j==1)

                    
                    %---NEW---%
                    vector = ComputeVectors(i,j,img_resul,numberLines,numberColumns);
                    vector(isnan(vector))=0;
                    
                    if (vector == 0)
                    newposition =0 ;
%                     img_resul(i,j).family = numberRepetitions;
                    img_resul(i,j).family = 0;
                    else
                    
                    
                    vectorN = {'cl' , 'cddl' , 'cd' , 'cddr', 'cr' , 'cdur', 'cu', 'cdul'};
                    [val idx] = max(vector);
                    img_resul(i,j).family = numberRepetitions;

                    %Apontando para o proximo que deve-se ir:
                  
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

                %Quina superior direita
                elseif (i== 1) && (j==numberColumns)

                    
                    %---NEW---%
                    vector = ComputeVectors(i,j,img_resul,numberLines,numberColumns);
                    vector(isnan(vector))=0;
                    
                    if (vector == 0)
                    newposition =0 ;
%                     img_resul(i,j).family = numberRepetitions;
                    img_resul(i,j).family = 0;
                    else
                        
                    vectorN = {'cl' , 'cddl' , 'cd' , 'cddr', 'cr' , 'cdur', 'cu', 'cdul'};
                    [val idx] = max(vector);
                    img_resul(i,j).family = numberRepetitions;

                    %Apontando para o proximo que deve-se ir:
                  
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

                %Quina inferior direita
                elseif (i== numberLines) && (j==numberColumns)

                    
                    %---NEW---%
                    vector = ComputeVectors(i,j,img_resul,numberLines,numberColumns);
                    vector(isnan(vector))=0;
                    
                    if (vector == 0)
                    newposition =0 ;
%                     img_resul(i,j).family = numberRepetitions;
                    img_resul(i,j).family = 0;
                    else
                        
                    vectorN = {'cl' , 'cddl' , 'cd' , 'cddr', 'cr' , 'cdur', 'cu', 'cdul'};
                    [val idx] = max(vector);
                    img_resul(i,j).family = numberRepetitions;

                    %Apontando para o proximo que deve-se
                    %ir:
                   
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


                %Quina inferior esquerda
                else (i== numberLines) && (j==1)

                    
                    %---NEW---%
                    vector = ComputeVectors(i,j,img_resul,numberLines,numberColumns);
                    vector(isnan(vector))=0;
                    
                    if (vector == 0)
                    newposition =0 ;
%                     img_resul(i,j).family = numberRepetitions;
                    img_resul(i,j).family = 0;
                    else
                        
                    vectorN = {'cl' , 'cddl' , 'cd' , 'cddr', 'cr' , 'cdur', 'cu', 'cdul'};
                    [val idx] = max(vector);
                    img_resul(i,j).family = numberRepetitions;

                    %Apontando para o proximo que deve-se ir:
                   
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

                    
                end
                
        end
        
        
    end
end


for i=1:numberLines
    for j=1:numberColumns
        matrizFamilia(i,j) = img_resul(i,j).family;
    end
end


%-----Plano B

% x =matrizFamilia;
% a = unique(x);
% out = [histc(x(:),a)];
% toBeZero = [];
% 
% for nR =1:numel(out)
%     if(out(nR)<=2)
%         toBeZero = [toBeZero nR];
%     end
%     
% end

% for i = 1:numberLines
%     for j =numberColumns
%       if(~isempty(find(toBeZero == matrizFamilia(i,j) ) >0))
%           matrizFamilia(i,j) = 0;
%           
%     end
%     end
% end




