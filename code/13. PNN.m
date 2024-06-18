% PNN Creates a Probabilistic Neural Network for simple leaves. It
% trains the network and tests the network using 10-fold cross-validation
% technique. Accuracies of each fold is returned in an array as output.
%
% MODIFIED BY:
%       Javed Hossain
%       Date: April 20, 2010.
%
% ORIGINAL VERSION BY:
%       Dr. Ashraful Amin

% Load the target class vector for PNN training.
load('T30.mat');

for n = 1:1

    % Obtain primary shape features for all 1200 simple leaves
    PSF = getPSF(1,1200);
    
    % Obtain Laminal Width Vector for all 1200 simple leaves
    WVR = getWidthVector(1,1200,11);

    % Merge PSF and WVR to create input vector for PNN
    P = [WVR PSF];      
      
    P_norm = P;
    Pt = P';
    
    % Get arithmatic mean and standard deviations of the features
    RowMeans = mean(Pt);
    RowStds = std(Pt);
    
    [r c]=size(P);
    
    % Normalize features
    for j = 1:c
      P_norm(:,j) = P(:,j) - RowMeans';
      P_norm(:,j) = P_norm(:,j) ./ RowStds';
    end;

    clear RowMeans RowStds Pt c i r;

    % Partition P and T ( for 10-fold cross-validation )
    for j = 0:9
        testsize = 10; % 10 for 10-fold corss-validation
        ind1 = 1;
        ind2 = 1;
        for i = 1:1200
            if mod(i,testsize)== j % Testing partition
                temp1(:,ind1)= P_norm(:,i);
                temp2(:,ind1)=T(:,i);
                ind1=ind1+1;
            else % Training partition
                temp3(:,ind2)=P_norm(:,i);
                temp4(:,ind2)=T(:,i);
                ind2=ind2+1;
            end
        end
        
        % Make the PNN with training partition
        net = newpnn(temp3,temp4);
        
        % Test the PNN with testing partition
        Y = sim(net,temp1);
        Yc = vec2ind(Y)';

        [r c] = size(Yc);
        temp = 0;
        Yc_actual = vec2ind(temp2)';
        
        % Check the output of the PNN, count number of mistakes
        for i=1:r
              if (Yc_actual(i,1)~= Yc(i,1))
                 temp = temp + 1;   
              end
        end
        
        % Store the accuracy 
        a(1,j+1) = 100-100*(temp/r);
        
        clear temp temp1 temp2 temp3 temp4 ind1 ind2 i j  r c Y testsize; 
    end    
end



