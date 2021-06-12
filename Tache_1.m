% dir **/*.jpg
fileList = dir('**/*.jpg');
myFolder = 'C:\Users\Olek\Documents\Genéve\TP5\Corel';
if ~isdir(myFolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end
filePattern = fullfile(myFolder, '*.jpg');
jpegFiles = dir(filePattern);
for k = 1:length(jpegFiles)
  baseFileName = jpegFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  imageArray = imread(fullFileName);
  kk{k} = imageArray;
end
Images_RGB = [];
for im = 1:k
    
    flat = reshape(kk{im},1,[]);
    R=imhist(kk{im}(:,:,1),96);
    G=imhist(kk{im}(:,:,2),96);
    B=imhist(kk{im}(:,:,3),96);
    Images_RGB{im} = cat(1,R,G,B);
end
for r = 1:k
    for c = 1:k
        M_euclidean(r,c) = norm(Images_RGB{r}-Images_RGB{c}); 
    end
end
for count = 1:100
    [out,idx] = sort(M_euclidean(count,:));
    for counter = 1:300
        claster=idx(1,1:counter)<=100;
        Recall_b(count,counter) = sum(claster(:))/100;
        Precision_b(count,counter) = sum(claster(:))/counter;
    end
end
for countt = 101:200
    [out,idx] = sort(M_euclidean(countt,:));
    for counter = 1:300
        claster=(101<=idx(1,1:counter))&(idx(1,1:counter)<=200);
        Recall_t(countt,counter) = sum(claster(:))/100;
        Precision_t(countt,counter) = sum(claster(:))/counter;
    end
end
for countw = 201:300
    [out,idx] = sort(M_euclidean(countw,:));
    for counter = 1:300
        claster=(201<=idx(1,1:counter))&(idx(1,1:counter)<=300);
        Recall_w(countw,counter) = sum(claster(:))/100;
        Precision_w(countw,counter) = sum(claster(:))/counter;
    end
end
Recall_beverages = mean(Recall_b,1);
Precision_beverages = mean(Precision_b,1);
Recall_trop = mean(Recall_t(101:200,:),1);
Precision_trop = mean(Precision_t(101:200,:),1);
Recall_waves = mean(Recall_w(201:300,:),1);
Precision_waves = mean(Precision_w(201:300,:),1);
Conc_recall = cat(1,Recall_beverages,Recall_trop,Recall_waves);
Conc_precision = cat(1,Precision_beverages,Precision_trop,Precision_waves);
Overall_recall = mean(Conc_recall,1);
Overall_precision = mean(Conc_precision,1);
figure
plot(Overall_recall,Overall_precision,'r');
title('Precision-Recall RGB bin classifier');
ylabel('Precision'); 
xlabel('Recall');