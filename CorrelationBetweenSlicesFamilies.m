
load('/Users/danieldahis/Documents/Matlab Files/listOfFamiliesSlices.mat');

%new
% for family1=1:numel(listOfFamiliesSlices{1,1})
%     for family2 = 1:numel(listOfFamiliesSlices{1,2})

        vecCorrelationsContrastsSlices = [];
        slice1 = 1;
        slice2 = 2;
         family1 = 2;
         family2 = 2;

        for eleSL1= 1:numel(listOfFamiliesSlices{1,slice1}{1,family1})
    
            for eleSL2=1:numel(listOfFamiliesSlices{1,slice2}{1,family2})
                %percorrendo todas os elementos de uma familia do slice I e slice
                %II
                correlation = corrcoef(listOfFamiliesSlices{1,slice1}{1,family1}{eleSL1},listOfFamiliesSlices{1,slice2}{1,family2}{eleSL2});
                vecCorrelationsContrastsSlices = [vecCorrelationsContrastsSlices correlation(2,1)];
        
            end
            
        vecCorrelationsFamiliesSlices(eleSL1) = mean(vecCorrelationsContrastsSlices);
        vecCorrelationsContrastsSlices = [];   
    
        end

%         correlationBetweenFamilies(family1,family2) = mean(vecCorrelationsFamiliesSlices);
          correlationBetweenFamilies = mean(vecCorrelationsFamiliesSlices)
  
%     end
% end

