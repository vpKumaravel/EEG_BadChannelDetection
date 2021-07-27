%% This file classifies bad channels using HAPPE (2018) pipeline
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


result_HAPPE(length(csv_files)) = struct('name',"",'bad', [], 'F1',[],'BACC',[]); 

counter = 1;

for j = 1:numel(csv_files)

   just_name = erase(csv_files(j).name,'_labels.csv');
   labels = readtable([labeldir '\\' csv_files(j).name], 'ReadVariableNames', false);
   fprintf('\nCurrent Dataset ID %d:, %s\n', j, just_name);
   EEG = pop_loadset('filename',[just_name '_filtered.set'],'filepath',rootdir);
   EEG_tmp = EEG;
   orig_array = [1:EEG.nbchan];
   
   [~, removed_iter1] = pop_rejchan(EEG_tmp, 'elec',[1:EEG_tmp.nbchan],'threshold',[-3 3],'norm','on','measure','spec','freqrange',[1 125]);
   remaining_elec = setdiff(orig_array, removed_iter1); 
   [EEG_tmp, removed_iter2] = pop_rejchan(EEG, 'elec',remaining_elec,'threshold',[-3 3],'norm','on','measure','spec','freqrange',[1 125] );
   bad_pred = [removed_iter1, remaining_elec(removed_iter2)];
   
   f1 = f1score(labels.Var1',bad_pred);
   bACC_score = bacc(labels.Var1',bad_pred);
   if(isempty(bad_pred) && nnz(labels.Var1') == 0) % to be in compliant with Python balanced_accuracy
       bACC_score = 1;
       f1         = 0;
   end
   result_HAPPE(counter).name = csv_files(j).name;
   result_HAPPE(counter).bad  = bad_pred;
   result_HAPPE(counter).F1 = f1;
   result_HAPPE(counter).BACC = bACC_score;
   
   counter = counter + 1;

end