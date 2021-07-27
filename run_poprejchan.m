%% This file classifies bad channels using Kurtosis measure
% Author: Velu Prabhakar Kumaravel
% PhD Student (FBK & CIMEC-UNITN, Trento, Italy)
% email: velu.kumaravel@unitn.it
% July 2021; 

clc
clear all
eeglab

rootdir = 'C:\Google Drive\OpenNeuro\ds002034'; % root directory where all files from Open Neuro Website exist
labeldir = 'C:\Google Drive\OpenNeuro\ds002034\label files'; % label of bad channels from .tsv files in the Open Neuro website (an example can be found in Sample Dataset Folder in this github repo)

%mat files
mat_files = dir(fullfile(rootdir, '**\*.set'));
csv_files = dir(fullfile(rootdir, '**\*.csv'));


result_KURT(length(csv_files)) = struct('name',"",'bad', [], 'F1',[],'BACC',[]); 

counter = 1;

for j = 1:numel(csv_files)

   just_name = erase(csv_files(j).name,'_labels.csv');
   labels = readtable([labeldir '\\' csv_files(j).name], 'ReadVariableNames', false);
   fprintf('\nCurrent Dataset ID %d:, %s\n', j, just_name);
   EEG = pop_loadset('filename',[just_name '_filtered.set'],'filepath',rootdir);
   
   EEG_tmp = EEG;
   
  [~, bad_pred, kurt, ~] = pop_rejchan(EEG, 'elec',[1:62] ,'threshold',5,'norm','on','measure','kurt');
  
   
   f1 = f1score(labels.Var1',bad_pred);
   bACC_score = bacc(labels.Var1',bad_pred);
   if(isempty(bad_pred) && nnz(labels.Var1') == 0) % to be in compliant with Python balanced_accuracy
       bACC_score = 1;
       f1         = 0;
   end
   result_KURT(counter).name = csv_files(j).name;
   result_KURT(counter).bad  = bad_pred;
   result_KURT(counter).F1 = f1;
   result_KURT(counter).BACC = bACC_score;
   
   counter = counter + 1;

end