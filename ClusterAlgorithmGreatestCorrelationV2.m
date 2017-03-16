
clear all; clc;

load('SNmat.mat')

%------------------------------------------------------
%Naming .nii Images  
% 
% name1 =  '20161212_122142HeadDTIep2ddiffmddw30s008a001_regularized_m20161212_122142Headt1mpragesagp2isos106a1001.nii';
% name2 =  'rm20161212_122142HeadSWIt2fl3dtrap2isos015a1001.nii';
% name3 = 'rm20161212_122142HeadSWIt2fl3dtrap2isos017a1001.nii';
% name4 = 'rm20161212_122142Headt2spcdaflsagp2isoFSs100a1001.nii';
% name5 = 'rm20161212_122142Headt2spcsagp2isos102a1001.nii';

% %Loading the files
% contrast1=load_untouch_nii(name1);
% contrast2=load_untouch_nii(name2);
% contrast3=load_untouch_nii(name3);
% contrast4=load_untouch_nii(name4);
% contrast5=load_untouch_nii(name5);

% %Selecting just the image of the files
% img1 = contrast1.img;
% img2 = contrast2.img;
% img3 = contrast3.img;
% img4 = contrast4.img;
% img5 = contrast5.img;

% Selecting just a slice of the images // testing purpuses: 2D
% img1_2d = img1(:,:,50);
% img2_2d = img2(:,:,50);
% img3_2d = img3(:,:,50);
% img4_2d = img4(:,:,50);
% img5_2d = img5(:,:,50);


% using a test volum (area : slice 10) for testing 2d purposes.
img1_2d = SWI(:,:,8);
img2_2d = SWIphase(:,:,8);
img3_2d = T1_SN(:,:,8);
img4_2d = T2_SN(:,:,8);
img5_2d = Fl_SN(:,:,8);

figure (1)
title('Contrast 1')
imshow(SWI(:,:,8),[]);
figure (2)
title('Contrast 2')
imshow(SWIphase(:,:,8),[]);
figure (3)
title('Contrast 3')
imshow(T1_SN(:,:,8),[]);
figure (4)
title('Contrast 4')
imshow(T2_SN(:,:,8),[]);
figure (5)
title('Contrast 5')
imshow(Fl_SN(:,:,8),[]);


% changing NaN values to 0
img1_2d(isnan(img1_2d))=0;
img2_2d(isnan(img2_2d))=0;
img3_2d(isnan(img3_2d))=0;
img4_2d(isnan(img4_2d))=0;
img5_2d(isnan(img5_2d))=0;

% ------------__TESTE__-----------------
%  clear all , clc
% % 
%  teste_numLin = 7;
%  teste_numCol = 4; 
% % 
% % %Testar com 1`s em geral e zeros no meio. Ta dando errado e diferente.
%  teste_img1 = ones(teste_numLin,teste_numCol)*100 +0.19;
%  teste_img2 = ones(teste_numLin,teste_numCol)*100 + 0.17;
%  teste_img3 = ones(teste_numLin,teste_numCol)*100+ 0.16;
%  teste_img4 = ones(teste_numLin,teste_numCol)*100+ 0.15;
%  teste_img5 = ones(teste_numLin,teste_numCol)*100+0.12 ;
% % 
% % 
%  for t = 2:3
%     for q = 2:3
%         teste_img1(t,q) = 1.2;
%         teste_img2(t,q) = 1;
%         teste_img3(t,q) = 1.4;
%         teste_img4(t,q) = 1;
%         teste_img5(t,q) = 1.7;
%         teste_img1(t+3,q) = 1;
%         teste_img2(t+3,q) = 1.9;
%         teste_img3(t+3,q) = 1.9;
%         teste_img4(t+3,q) = 1;
%         teste_img5(t+3,q) = 1;
%         
%     end
% end
% 
% % 
% figure (1)
% title('Contrast 1')
% imshow(teste_img1,[]);
% figure (2)
% title('Contrast 2')
% imshow(teste_img2,[]);
% figure (3)
% title('Contrast 3')
% imshow(teste_img3,[]);
% figure (4)
% title('Contrast 4')
% imshow(teste_img4,[]);
% figure (5)
% title('Contrast 5')
% imshow(teste_img5,[]);
% % 
% % % 
% img1_2d = teste_img1;
% img2_2d = teste_img2;
% img3_2d = teste_img3;
% img4_2d = teste_img4;
% img5_2d = teste_img5;


% --------------------------------------

%defining numberLines and numberColumns
[numberLines,numberColumns] = size(img1_2d);

%Unifying everything.
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
%Implementation of the Algorithm: Clustering
%------------------------------------------------------

%Auxiliary Variables

clusterUses = [];
contador = 0;
clusterValues = [1:numberLines*numberColumns];

%Clustering
for x_int=1:numberLines
    for y_int = 1:numberColumns
        contador=contador+1;
        i=x_int;
        j=y_int;
             
            % Is this position has already a value? Change the cluster
            % value to that value and set the current position family with
            % the new updated cluster value. Else just keep using new
            % cluster values 
            
            if( img_resul(i,j).family > -1) 
                clusterValue = img_resul(i,j).family;
                img_resul(i,j).family = clusterValue;
                
            else
                clusterValue = clusterValues(contador);
                img_resul(i,j).family = clusterValue;
            end
                
            vector = ComputeVectors(i,j,img_resul,numberLines,numberColumns);
            vectorN = {'cl' , 'cddl' , 'cd' , 'cddr', 'cr' , 'cdur', 'cu', 'cdul'};
            
            %Case that the vector does not have correlations
            vector(isnan(vector))=0; %TIP: Make it to the Nii. File.
            if (vector == 0)
                img_resul(i,j).family = 0;
            end
            
            %------------------------------------------------------------
            %se o vetor tiver mais de um valor de maior correlacao, o que
            %eu quero e marcar todos como o mesmo tecido!
            %THIS PART SHOULD BE CHANGED IF WE WANTED TO TAKE ONLY GREATER
            %VALUES THAN 0.95 FOR EXAMPLE
            %------------------------------------------------------------
            %pegando a qntd de incidencia do maximo valor de correlacao.
            maxValueVector = sum(vector == max(vector));
            %se a qntd de incidencias for maior que 2
            if (maxValueVector >= 2 )
                %Procuro dentro do vetor de correlacoes
                for x= 1:numel(vector)
                    %onde estao esses valores de maior correlacao
                   if(vector(x)==max(vector))
                        
                       if strcmp(vectorN(x),'cl')
                           if( img_resul(i,j-1).family == -1)
                           img_resul(i,j-1).family = img_resul(i,j).family;
                           else
                               newClusterValue = img_resul(i,j-1).family; 
                               %percorro toda a matriz com os valores da
                               %atual cluster value
                               for i_2change = 1:(numberLines)
                                   for j_2change =1:numberColumns
                                       if(img_resul(i_2change,j_2change).family == img_resul(i,j).family)
                                           img_resul(i_2change,j_2change).family = newClusterValue;
                                       end
                                   end
                               end
    
                           end
                       end
                       
                        if strcmp(vectorN(x),'cddl')
                           if( img_resul(i+1,j-1).family == -1)
                           img_resul(i+1,j-1).family = img_resul(i,j).family;
                           else
                               newClusterValue = img_resul(i+1,j-1).family; 
                               %percorro toda a matriz com os valores da
                               %atual cluster value
                               for i_2change = 1:(numberLines)
                                   for j_2change =1:numberColumns
                                       if(img_resul(i_2change,j_2change).family == img_resul(i,j).family)
                                           img_resul(i_2change,j_2change).family = newClusterValue;
                                       end
                                   end
                               end
    
                           end 
                        end
                        if strcmp(vectorN(x),'cd')
                           if( img_resul(i+1,j).family == -1)
                           img_resul(i+1,j).family = img_resul(i,j).family;
                           else
                               newClusterValue = img_resul(i+1,j).family; 
                               %percorro toda a matriz com os valores da
                               %atual cluster value
                               for i_2change = 1:(numberLines)
                                   for j_2change =1:numberColumns
                                       if(img_resul(i_2change,j_2change).family == img_resul(i,j).family)
                                           img_resul(i_2change,j_2change).family = newClusterValue;
                                       end
                                   end
                               end
    
                           end 
                        end
                        if strcmp(vectorN(x),'cddr')
                           if( img_resul(i+1,j+1).family == -1)
                           img_resul(i+1,j+1).family = img_resul(i,j).family;
                           else
                               newClusterValue = img_resul(i+1,j+1).family; 
                               %percorro toda a matriz com os valores da
                               %atual cluster value
                               for i_2change = 1:(numberLines)
                                   for j_2change =1:numberColumns
                                       if(img_resul(i_2change,j_2change).family == img_resul(i,j).family)
                                           img_resul(i_2change,j_2change).family = newClusterValue;
                                       end
                                   end
                               end
    
                           end 
                        end
                        if strcmp(vectorN(x),'cr')
                           if( img_resul(i,j+1).family == -1)
                           img_resul(i,j+1).family = img_resul(i,j).family;
                           else
                               newClusterValue = img_resul(i,j+1).family; 
                               %percorro toda a matriz com os valores da
                               %atual cluster value
                               for i_2change = 1:(numberLines)
                                   for j_2change =1:numberColumns
                                       if(img_resul(i_2change,j_2change).family == img_resul(i,j).family)
                                           img_resul(i_2change,j_2change).family = newClusterValue;
                                       end
                                   end
                               end
    
                           end 
                        end
                        if strcmp(vectorN(x),'cdur')
                           if( img_resul(i-1,j+1).family == -1)
                           img_resul(i-1,j+1).family = img_resul(i,j).family;
                           else
                               newClusterValue = img_resul(i-1,j+1).family; 
                               %percorro toda a matriz com os valores da
                               %atual cluster value
                               for i_2change = 1:(numberLines)
                                   for j_2change =1:numberColumns
                                       if(img_resul(i_2change,j_2change).family == img_resul(i,j).family)
                                           img_resul(i_2change,j_2change).family = newClusterValue;
                                       end
                                   end
                               end
    
                           end 
                        end
                        if strcmp(vectorN(x),'cu')
                           if( img_resul(i-1,j).family == -1)
                           img_resul(i-1,j).family = img_resul(i,j).family;
                           else
                               newClusterValue = img_resul(i-1,j).family; 
                               %percorro toda a matriz com os valores da
                               %atual cluster value
                               for i_2change = 1:(numberLines)
                                   for j_2change =1:numberColumns
                                       if(img_resul(i_2change,j_2change).family == img_resul(i,j).family)
                                           img_resul(i_2change,j_2change).family = newClusterValue;
                                       end
                                   end
                               end
    
                           end 
                        end
                        if strcmp(vectorN(x),'cdul')
                           if( img_resul(i-1,j-1).family == -1)
                           img_resul(i-1,j-1).family = img_resul(i,j).family;
                           else
                               newClusterValue = img_resul(i-1,j-1).family; 
                               %percorro toda a matriz com os valores da
                               %atual cluster value
                               for i_2change = 1:(numberLines)
                                   for j_2change =1:numberColumns
                                       if(img_resul(i_2change,j_2change).family == img_resul(i,j).family)
                                           img_resul(i_2change,j_2change).family = newClusterValue;
                                       end
                                   end
                               end
    
                           end 
                        end
                        
                   end
                end
                
            else
            
            
            %------------------------------------------------------------
            
            
            
            
                
            %----------------------------------------------------------
            %Marking the greater correlation position  with the current
            %clusterValue!
            %----------------------------------------------------------
            
            [val idx1] = max(vector);
            
            if strcmp(vectorN(idx1),'cl')
                
                if( img_resul(i,j-1).family == -1)
                    img_resul(i,j-1).family = img_resul(i,j).family;
                else
                    toBeChangedcluster = img_resul(i,j).family;
                    clusterValue = img_resul(i,j-1).family;
                    i_Maxreview = i;
                    j_Maxreview = j;
                    
                    for iRev = 1 : i_Maxreview
                        for jRev = 1:j_Maxreview
                            if(img_resul(iRev,jRev).family == toBeChangedcluster)
                                img_resul(iRev,jRev).family = clusterValue;
                            end
                        end
                    end
                end

                
                
            elseif strcmp(vectorN(idx1),'cddl')
                
                if( img_resul(i+1,j-1).family == -1)
                    img_resul(i+1,j-1).family = img_resul(i,j).family;
                else
                    toBeChangedcluster = img_resul(i,j).family;
                    clusterValue = img_resul(i+1,j-1).family;
                    i_Maxreview = i;
                    j_Maxreview = j;
                    
                    for iRev = 1 : i_Maxreview
                        for jRev = 1:j_Maxreview
                            if(img_resul(iRev,jRev).family == toBeChangedcluster)
                                img_resul(iRev,jRev).family = clusterValue;
                            end
                        end
                    end
                end
                
                
            elseif strcmp(vectorN(idx1),'cd')
                if( img_resul(i+1,j).family == -1)
                    img_resul(i+1,j).family = img_resul(i,j).family;
                else
                    toBeChangedcluster = img_resul(i,j).family;
                    clusterValue = img_resul(i+1,j).family;
                    i_Maxreview = i;
                    j_Maxreview = j;
                    
                    for iRev = 1 : i_Maxreview
                        for jRev = 1:j_Maxreview
                            if(img_resul(iRev,jRev).family == toBeChangedcluster)
                                img_resul(iRev,jRev).family = clusterValue;
                            end
                        end
                    end
                end
                
            elseif strcmp(vectorN(idx1),'cddr')
                if( img_resul(i+1,j+1).family == -1)
                    img_resul(i+1,j+1).family = img_resul(i,j).family;
                else
                    toBeChangedcluster = img_resul(i,j).family;
                    clusterValue = img_resul(i+1,j+1).family;
                    i_Maxreview = i;
                    j_Maxreview = j;
                    
                    for iRev = 1 : i_Maxreview
                        for jRev = 1:j_Maxreview
                            if(img_resul(iRev,jRev).family == toBeChangedcluster)
                                img_resul(iRev,jRev).family = clusterValue;
                            end
                        end
                    end
                end
                
            elseif strcmp(vectorN(idx1),'cr')
                if( img_resul(i,j+1).family == -1)
                    img_resul(i,j+1).family = img_resul(i,j).family;
                else
                    toBeChangedcluster = img_resul(i,j).family;
                    clusterValue = img_resul(i,j+1).family;
                    i_Maxreview = i;
                    j_Maxreview = j;
                    
                    for iRev = 1 : i_Maxreview
                        for jRev = 1:j_Maxreview
                            if(img_resul(iRev,jRev).family == toBeChangedcluster)
                                img_resul(iRev,jRev).family = clusterValue;
                            end
                        end
                    end
                end
                
            elseif strcmp(vectorN(idx1),'cdur')
                if( img_resul(i-1,j+1).family == -1)
                    img_resul(i-1,j+1).family = img_resul(i,j).family;
                else
                    toBeChangedcluster = img_resul(i,j).family;
                    clusterValue = img_resul(i-1,j+1).family;
                    i_Maxreview = i;
                    j_Maxreview = j;
                    
                    for iRev = 1 : i_Maxreview
                        for jRev = 1:j_Maxreview
                            if(img_resul(iRev,jRev).family == toBeChangedcluster)
                                img_resul(iRev,jRev).family = clusterValue;
                            end
                        end
                    end
                end
                
            elseif strcmp(vectorN(idx1),'cu')
                if( img_resul(i-1,j).family == -1)
                    img_resul(i-1,j).family = img_resul(i,j).family;
                else
                    toBeChangedcluster = img_resul(i,j).family;
                    clusterValue = img_resul(i-1,j).family;
                    i_Maxreview = i;
                    j_Maxreview = j;
                    
                    for iRev = 1 : i_Maxreview
                        for jRev = 1:j_Maxreview
                            if(img_resul(iRev,jRev).family == toBeChangedcluster)
                                img_resul(iRev,jRev).family = clusterValue;
                            end
                        end
                    end
                end
                
            else strcmp(vectorN(idx1),'cdul')
                if( img_resul(i-1,j-1).family == -1)
                    img_resul(i-1,j-1).family = img_resul(i,j).family;
                
                else
                    toBeChangedcluster = img_resul(i,j).family;
                    clusterValue = img_resul(i-1,j-1).family;
                    i_Maxreview = i;
                    j_Maxreview = j;
                    
                    for iRev = 1 : i_Maxreview
                        for jRev = 1:j_Maxreview
                            if(img_resul(iRev,jRev).family == toBeChangedcluster)
                                img_resul(iRev,jRev).family = clusterValue;
                            end
                        end
                    end
                end
                
            end
            
            %---------------------END----------------------------------
            %----------------------------------------------------------        
            %Taking the greater 2nd Value TEST
            
            vectorSecondGreaterValue = sort(vector);
            [~,idx2] = ismember(vectorSecondGreaterValue(numel(vectorSecondGreaterValue)-1),vector,'R2012a');
%             
%             %if there are 2 max correlations in the correlation vector.
%             if(idx1 == idx2)
%                 
%                 max_value = max(vector);
%                 [row,col] = find(vector==max_value)
%                 indices = [row, col];
%                 %preferivel ir para algum que nao tenha familia ainda!
%                  col = giveCoordenades(img_resul,col,i,j,vectorN,[],[]);
%                 idx1 = col(1);
%                 idx2= col(2);
%             
%             
%             
%             end
%             
%             %Marking the 2nd Great Value
%             if strcmp(vectorN(idx2),'cl')
%                 if( img_resul(i,j-1).family == -1)
%                     img_resul(i,j-1).family = img_resul(i,j).family;
%                 end
%             elseif strcmp(vectorN(idx2),'cddl')
%                 if( img_resul(i+1,j-1).family == -1)
%                     img_resul(i+1,j-1).family = img_resul(i,j).family;
%                 end
%             elseif strcmp(vectorN(idx2),'cd')
%                 if( img_resul(i+1,j).family == -1)
%                     img_resul(i+1,j).family = img_resul(i,j).family;
%                 end
%             elseif strcmp(vectorN(idx2),'cddr')
%                 if( img_resul(i+1,j+1).family == -1)
%                     img_resul(i+1,j+1).family = img_resul(i,j).family;
%                 end
%             elseif strcmp(vectorN(idx2),'cr')
%                 if( img_resul(i,j+1).family == -1)
%                     img_resul(i,j+1).family = img_resul(i,j).family;
%                 end
%             elseif strcmp(vectorN(idx2),'cdur')
%                 if( img_resul(i-1,j+1).family == -1)
%                     img_resul(i-1,j+1).family = img_resul(i,j).family;
%                 end
%             elseif strcmp(vectorN(idx2),'cu')
%                 if( img_resul(i-1,j).family == -1)
%                     img_resul(i-1,j).family = img_resul(i,j).family;
%                 end
%             else strcmp(vectorN(idx2),'cdul')
%                 if( img_resul(i-1,j-1).family == -1)
%                     img_resul(i-1,j-1).family = img_resul(i,j).family;
%                 end
%             end
%             
%             
%             end
            
                    
%             %If the next position already belongs to a family, the
%             %current position and the lasts positions family needs to be the same
%             if(flag_newposition ==1) && (img_resul(nextPosition(1),nextPosition(2)).family ~= -1)
%                 %all the family must be converted
%                 for convertingIndex = 1:numel(i_antigo)
%                 	img_resul(i_antigo(convertingIndex),j_antigo(convertingIndex)).family = img_resul(nextPosition(1),nextPosition(2)).family;
%                 end
%                     flag_newposition =0;
%             end
            end
        end
            
end



% Creating a Matrix with a Clustering Values
for i=1:numberLines
    for j=1:numberColumns
        matrizFamilia(i,j) = img_resul(i,j).family;
    end
end

%Changing the Cluster matrix (matrizFamilia): when the cluster has the size minor than 2 the clusters values are transformed to 0 .
x =matrizFamilia;
a = unique(x);
out = [a histc(x(:),a)];
clusterValues = out(:,1)';
ocurrences = out(:,2)';
toBeZero = [];
mapout =[];

for index_toZero =1:numel(clusterValues)
    if(ocurrences(index_toZero)<=2)
        toBeZero = [toBeZero clusterValues(index_toZero)];
    end
end

vectorZeros = zeros(1,numel(toBeZero));
mapout = changem(matrizFamilia,vectorZeros,toBeZero);

%Changing the cluster values to the scale 0 - numberOfClusters
preScalingMatrix = mapout;
valuesPreScalingMatrix = unique(preScalingMatrix);
out1 = [valuesPreScalingMatrix histc(preScalingMatrix(:),valuesPreScalingMatrix)];
cluster2final = out1(:,1)';
matrizAsc = [0 1:(numel(cluster2final)-1)] + 1;
%Final Matrix
matrizResultAfterProcessing = changem(preScalingMatrix,matrizAsc,cluster2final);

figure (6)
title ('After Clustering');
imshow(matrizResultAfterProcessing,[]);

%AFTER IMPLEMENTING THE 1st and 2nd Great values, we can try implementing
%an minimum value for the correlation in order to determine if it belongs
%to the tissue or not.




