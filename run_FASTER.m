%% This file classifies bad channels using FASTER (Nolan 2010) algorithm
% Author: Velu Prabhakar Kumaravel
% PhD Student (FBK & CIMEC-UNITN, Trento, Italy)
% email: velu.kumaravel@unitn.it
% July 2021; 

clc
clear all
eeglab
%%
rootdir = '...\Sample Dataset'; % Use the absolute path where data and labels exist

mat_files = dir(fullfile(rootdir, '**\*.set'));
csv_files = dir(fullfile(rootdir, '**\*.csv'));

result_FASTER(length(csv_files)) = struct('name',"",'bad', [], 'F1',[],'BACC',[]); 
counter = 1;

for j = 1:numel(csv_files)

   just_name = erase(csv_files(j).name,'_labels.csv');
   labels = readtable([rootdir '\\' csv_files(j).name], 'ReadVariableNames', false);
   EEG = pop_loadset('filename',[just_name '_filtered.set'],'filepath',rootdir);
   
   ref_chan=find(strcmp({EEG.chanlocs.labels}, 'Cz'));
   
   list_properties = channel_properties(EEG, 1:EEG.nbchan, ref_chan); % run faster
   FASTbadIdx=min_z(list_properties);
   bad_pred=find(FASTbadIdx==1)';

   
   f1 = f1score(labels.Var1',bad_pred);
   bACC_score = bacc(labels.Var1',bad_pred);
   if(isempty(bad_pred) && nnz(labels.Var1') == 0) % to be in compliant with Python balanced_accuracy
       bACC_score = 1;
       f1         = 0;
   end
   result_FASTER(counter).name = csv_files(j).name;
   result_FASTER(counter).bad  = bad_pred;
   result_FASTER(counter).F1 = f1;
   result_FASTER(counter).BACC = bACC_score;
   
   counter = counter + 1;

end
