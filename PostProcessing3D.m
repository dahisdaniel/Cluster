

slice1= img_resul(:,:,1);
slice2 = img_resul(:,:,2);
slice3 = img_resul(:,:,3);
slice4 = img_resul(:,:,4);
slice5 = img_resul(:,:,5);
slice6 = img_resul(:,:,6);
slice7 = img_resul(:,:,7);
slice8 = img_resul(:,:,8);
slice9 = img_resul(:,:,9);
slice10 = img_resul(:,:,10);
slice11 = img_resul(:,:,11);

[numberLines,numberColumns] = size(slice1);

for i=1:numberLines
    for j=1:numberColumns
        slicey1(i,j) = slice1(i,j).family;
        
    end
end
figure(1)
pcolor(slicey1);
i = 0;
j= 0 ;

for i=1:numberLines
    for j=1:numberColumns
        slicey2(i,j) = slice2(i,j).family;
    end
end
figure(2)
pcolor(slicey2);

for i=1:numberLines
    for j=1:numberColumns
        slicey3(i,j) = slice3(i,j).family;
    end
end
figure(3)
pcolor(slicey3);

for i=1:numberLines
    for j=1:numberColumns
        slicey4(i,j) = slice4(i,j).family;
    end
end
figure(4)
pcolor(slicey4);

for i=1:numberLines
    for j=1:numberColumns
        slicey5(i,j) = slice5(i,j).family;
    end
end
figure(5)
pcolor(slicey5);

for i=1:numberLines
    for j=1:numberColumns
        slicey6(i,j) = slice6(i,j).family;
    end
end
figure(6)
pcolor(slicey6);

for i=1:numberLines
    for j=1:numberColumns
        slicey7(i,j) = slice7(i,j).family;
    end
end
figure(7)
pcolor(slicey7);

for i=1:numberLines
    for j=1:numberColumns
        slicey8(i,j) = slice8(i,j).family;
    end
end
figure(8)
pcolor(slicey8);

for i=1:numberLines
    for j=1:numberColumns
        slicey9(i,j) = slice9(i,j).family;
    end
end
figure(9)
pcolor(slicey9);

for i=1:numberLines
    for j=1:numberColumns
        slicey10(i,j) = slice10(i,j).family;
    end
end
figure(10)
pcolor(slicey10);

for i=1:numberLines
    for j=1:numberColumns
        slicey11(i,j) = slice11(i,j).family;
    end
end
figure(11)
pcolor(slicey11);


%-------------------------------------------------------------%
%Now we have 13 slices. Each slice already divided into families.
%-------------------------------------------------------------%

[numLin, numCol] = size(slicey1);

for i=1:numLin
    for j =1:numCol
        if(isThereAnotherFamilyAround(i,j,slicey1,numLin,numCol) ==0)
        mostCommon = MostCommonFamilyAround(i,j,slicey1,numLin,numCol);
        slicey1_postProcessing(i,j) = mostCommon;
        else
        slicey1_postProcessing(i,j) = slicey1(i,j);
        end
    end
end

for i=1:numLin
    for j =1:numCol
        if(isThereAnotherFamilyAround(i,j,slicey2,numLin,numCol) ==0)
        mostCommon = MostCommonFamilyAround(i,j,slicey2,numLin,numCol);
        slicey2_postProcessing(i,j) = mostCommon;
        else
        slicey2_postProcessing(i,j) = slicey2(i,j);
        
        end
    end
end

for i=1:numLin
    for j =1:numCol
        if(isThereAnotherFamilyAround(i,j,slicey3,numLin,numCol) ==0)
        mostCommon = MostCommonFamilyAround(i,j,slicey3,numLin,numCol);
        slicey3_postProcessing(i,j) = mostCommon;
        else
        slicey3_postProcessing(i,j) = slicey3(i,j);
        end
    end
end

for i=1:numLin
    for j =1:numCol
        if(isThereAnotherFamilyAround(i,j,slicey4,numLin,numCol) ==0)
        mostCommon = MostCommonFamilyAround(i,j,slicey4,numLin,numCol);
        slicey4_postProcessing(i,j) = mostCommon;
        else
        slicey4_postProcessing(i,j) = slicey4(i,j);
        end
    end
end

for i=1:numLin
    for j =1:numCol
        if(isThereAnotherFamilyAround(i,j,slicey5,numLin,numCol) ==0)
        mostCommon = MostCommonFamilyAround(i,j,slicey5,numLin,numCol);
        slicey5_postProcessing(i,j) = mostCommon;
        else
        slicey5_postProcessing(i,j) = slicey5(i,j);
        end
    end
end

for i=1:numLin
    for j =1:numCol
        if(isThereAnotherFamilyAround(i,j,slicey6,numLin,numCol) ==0)
        mostCommon = MostCommonFamilyAround(i,j,slicey6,numLin,numCol);
        slicey6_postProcessing(i,j) = mostCommon;
        else
        slicey6_postProcessing(i,j) = slicey6(i,j);
        end
    end
end

for i=1:numLin
    for j =1:numCol
        if(isThereAnotherFamilyAround(i,j,slicey7,numLin,numCol) ==0)
        mostCommon = MostCommonFamilyAround(i,j,slicey7,numLin,numCol);
        slicey7_postProcessing(i,j) = mostCommon;
        else
        slicey7_postProcessing(i,j) = slicey7(i,j);
        end
    end
end

for i=1:numLin
    for j =1:numCol
        if(isThereAnotherFamilyAround(i,j,slicey8,numLin,numCol) ==0)
        mostCommon = MostCommonFamilyAround(i,j,slicey8,numLin,numCol);
        slicey8_postProcessing(i,j) = mostCommon;
        else
        slicey8_postProcessing(i,j) = slicey8(i,j);
        end
    end
end

for i=1:numLin
    for j =1:numCol
        if(isThereAnotherFamilyAround(i,j,slicey9,numLin,numCol) ==0)
        mostCommon = MostCommonFamilyAround(i,j,slicey9,numLin,numCol);
        slicey9_postProcessing(i,j) = mostCommon;
        else
        slicey9_postProcessing(i,j) = slicey9(i,j);
        end
    end
end

for i=1:numLin
    for j =1:numCol
        if(isThereAnotherFamilyAround(i,j,slicey10,numLin,numCol) ==0)
        mostCommon = MostCommonFamilyAround(i,j,slicey10,numLin,numCol);
        slicey10_postProcessing(i,j) = mostCommon;
        else
        slicey10_postProcessing(i,j) = slicey10(i,j);
        end
    end
end

for i=1:numLin
    for j =1:numCol
        if(isThereAnotherFamilyAround(i,j,slicey11,numLin,numCol) ==0)
        mostCommon = MostCommonFamilyAround(i,j,slicey11,numLin,numCol);
        slicey11_postProcessing(i,j) = mostCommon;
        else
        slicey11_postProcessing(i,j) = slicey11(i,j);
        end
    end
end


for i = 1:numLin
    for j =1:numCol
        
    end
end
