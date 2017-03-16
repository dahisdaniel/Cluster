 clear all; clc;



%------------------------------------------------------
% % Naming .nii Images  
% % name1 =  '20161212_122142HeadDTIep2ddiffmddw30s008a001_regularized_m20161212_122142Headt1mpragesagp2isos106a1001.nii';
% % name2 =  'rm20161212_122142HeadSWIt2fl3dtrap2isos015a1001.nii';
% % name3 = 'rm20161212_122142HeadSWIt2fl3dtrap2isos017a1001.nii';
% % name4 = 'rm20161212_122142Headt2spcdaflsagp2isoFSs100a1001.nii';
% % name5 = 'rm20161212_122142Headt2spcsagp2isos102a1001.nii';
% % 
% % %Loading the files
% % contrast1=load_untouch_nii(name1); 
% % contrast2=load_untouch_nii(name2);
% % contrast3=load_untouch_nii(name3);
% % contrast4=load_untouch_nii(name4);
% % contrast5=load_untouch_nii(name5);
% % 
% % %Selecting just the image of the files
% % img1 = contrast1.img;
% % img2 = contrast2.img;
% % img3 = contrast3.img;
% % img4 = contrast4.img;
% % img5 = contrast5.img;
% % 
% % Selecting just a slice of the images // testing purpuses: 2D
% % img1_2d = img1(:,:,50);
% % img2_2d = img2(:,:,50);
% % img3_2d = img3(:,:,50);
% % img4_2d = img4(:,:,50);
% % img5_2d = img5(:,:,50);

% for versao = 1:15
% listOfFamiliesSlices = {};

% for slicess =1:2
    
load('SNmat.mat')
% using a test volum (area : slice 10) for testing 2d purposes.
% T1_SN(:,:,:) = 0;
% T2_SN(:,:,:) = 0;

img1_2d = (SWI(:,:,:));
img2_2d = (SWIphase(:,:,:));
img3_2d = (T1_SN(:,:,:));
img4_2d = (T2_SN(:,:,:));
img5_2d = (Fl_SN(:,:,:));

% figure (1)
% title('Contrast 1')
% imshow(img1_2d,[]);
% figure (2)
% title('Contrast 2')
% imshow(img2_2d,[]);
% figure (3)
% title('Contrast 3')
% imshow(img3_2d,[]);
% figure (4)
% title('Contrast 4')
% imshow(img4_2d,[]);
% figure (5)
% title('Contrast 5')
% imshow(img5_2d,[]);


% changing NaN values to 0
img1_2d(isnan(img1_2d))=0;
img2_2d(isnan(img2_2d))=0;
img3_2d(isnan(img3_2d))=0;
img4_2d(isnan(img4_2d))=0;
img5_2d(isnan(img5_2d))=0;

%defining numberLines and numberColumns
[numberLines,numberColumns,numberAltitude] = size(img1_2d);

%Unifying everything.
for i=1:numberLines
    for j = 1:numberColumns
        for k =1:13
        img_resul(i,j,k).c1 = img1_2d(i,j,k);
        img_resul(i,j,k).c2 = img2_2d(i,j,k);
        img_resul(i,j,k).c3 = img3_2d(i,j,k);
        img_resul(i,j,k).c4 = img4_2d(i,j,k);
        img_resul(i,j,k).c5 = img5_2d(i,j,k); % era .c5
        img_resul(i,j,k).family = -1;
        end
    end
end


%------------------------------------------------------
%Implementation of the Algorithm: Clustering
%------------------------------------------------------

%Auxiliary Variables


%Clustering

contador = 0 ; %era 0 antes
limitCorrelation = 0.7;
vecCorrelationsContrasts = [];
listOfFamilies = {{}};


h = waitbar(0,['Loading']);
totalOp = numberLines*numberColumns*numberAltitude;

%testing
i_tot = [1:numberLines];
j_tot = [1:numberColumns];
k_tot = [1:numberAltitude];

firstI = i_tot(randi(numel(i_tot)));
firstJ = j_tot(randi(numel(j_tot)));
firstK = j_tot(randi(numel(k_tot)));

 listOfFamilies{1}{1} = [img_resul(firstI,firstJ,firstK).c1,img_resul(firstI,firstJ,firstK).c2,img_resul(firstI,firstJ,firstK).c3,img_resul(firstI,firstJ,firstK).c4,img_resul(firstI,firstJ,firstK).c5]';
% listOfFamilies{1}{1} = [img_resul(firstI,firstJ,firstK).c1,img_resul(firstI,firstJ,firstK).c2,img_resul(firstI,firstJ,firstK).c3,img_resul(firstI,firstJ,firstK).c4]';


img_resul(firstI,firstJ,firstK).family = 1;

%end test

for k = 6: 6
   for i=1:numberLines
      for j = 1:numberColumns
        
        
        contador = contador + 1;
        waitbar(contador/totalOp);
        vecCorrelationsContrasts = [];
        vecCorrelationsFamilies = [];
            
         vec_central = [img_resul(i,j,k).c1,img_resul(i,j,k).c2,img_resul(i,j,k).c3,img_resul(i,j,k).c4,img_resul(i,j,k).c5]';    
%         vec_central = [img_resul(i,j,k).c1,img_resul(i,j,k).c2,img_resul(i,j,k).c3,img_resul(i,j,k).c4]';    
        
        %percorre o vetor que contem cada familia
          for index_family = 1:numel(listOfFamilies)
               %para cada familia, percorre os vetores contrastes 

                    for corr = 1:((numel(listOfFamilies{index_family})))
                        
                        correlation = corrcoef(vec_central,listOfFamilies{index_family}{corr});
                        vecCorrelationsContrasts = [vecCorrelationsContrasts correlation(2,1)];
                    
                    end

           
                
               vecCorrelationsFamilies(index_family) = mean(vecCorrelationsContrasts);
               vecCorrelationsContrasts = [];           
          end
          
          if(max(vecCorrelationsFamilies)>= limitCorrelation)       
            [val idx1] = max(vecCorrelationsFamilies);
            img_resul(i,j,k).family =  idx1;
            numberElements = numel(listOfFamilies{idx1});
            listOfFamilies{idx1}{numberElements+1} = vec_central;
%             listOfFamiliesPositions{idx1}{numberElements+1} = [i,j];
          else
            numberFamilies= numel(listOfFamilies);
            listOfFamilies{numberFamilies+1}{1} = vec_central;
%             listOfFamiliesPositions{numberFamilies+1}{1} = [i,j];
            img_resul(i,j,k).family =  numberFamilies + 1;
          end       
          
        end  
           
   end
end
        
% listOfFamiliesSlices{slicess} = listOfFamilies;
            
% end

%  listOfPositions{versao} = listOfFamiliesPositions ;

 
% 

% for i=1:numberLines
%     for j=1:numberColumns
%         matrizFamilia(i,j) = img_resul(i,j,1).family; %tinha 
%     end
% end
 
% figure (6) 
% % imshow(matrizFamilia(:,:,slicess),[])
% colormap default
% % end





