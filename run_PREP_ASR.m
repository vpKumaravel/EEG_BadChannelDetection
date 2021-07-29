%% This file classifies bad channels using clean_rawdata (some methods from PREP Pipeline) EEGLAB plugin
% Author: Velu Prabhakar Kumaravel
% PhD Student (FBK & CIMEC-UNITN, Trento, Italy)
% email: velu.kumaravel@unitn.it
% July 2021; 

clc
clear all
eeglab
%%
rootdir = '..\Sample Dataset'; % Use the absolute path where data and labels exist

mat_files = dir(fullfile(rootdir, '**\*.set'));
csv_files = dir(fullfile(rootdir, '**\*.csv'));

result_PREP(length(csv_files)) = struct('name',"",'bad', [], 'F1',[],'BACC',[]); 
counter = 1;

for j = 1:numel(csv_files)

   just_name = erase(csv_files(j).name,'_labels.csv');
   labels = readtable([rootdir '\\' csv_files(j).name], 'ReadVariableNames', false);
   fprintf('\nCurrent Dataset ID %d:, %s\n', j, just_name);
   EEG = pop_loadset('filename',[just_name '_filtered.set'],'filepath',rootdir);
   
   outEEG = pop_clean_rawdata(EEG, 'FlatlineCriterion',5,'ChannelCriterion',0.8,...
                            'LineNoiseCriterion',4,'Highpass','off','BurstCriterion','off','WindowCriterion','off','BurstRejection','off','Distance','Euclidian');
   if isfield(outEEG.etc, 'clean_channel_mask')
       bad_pred = find(outEEG.etc.clean_channel_mask == 0)';
   else
       bad_pred = [];
   end

   
   f1 = f1score(labels.Var1',bad_pred);
   bACC_score = bacc(labels.Var1',bad_pred);
   if(isempty(bad_pred) && nnz(labels.Var1') == 0) % to be in compliant with Python balanced_accuracy
       bACC_score = 1;
       f1         = 0;
   end
   result_PREP(counter).name = csv_files(j).name;
   result_PREP(counter).bad  = bad_pred;
   result_PREP(counter).F1 = f1;
   result_PREP(counter).BACC = bACC_score;
   
   counter = counter + 1;

end