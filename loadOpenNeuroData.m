%% This file 
% 1) loads EDF files from the open Neuro Dataset (https://openneuro.org/datasets/ds002034/versions/1.0.1)
% 2) updates channel informaiton
% 3) applies band-pass filtering
%
% Author: Velu Prabhakar Kumaravel
% PhD Student (FBK & CIMEC-UNITN, Trento, Italy)
% email: velu.kumaravel@unitn.it
% July 2021; 

EEG = pop_biosig('\Sample Dataset\sub-09_ses-01_eeg_sub-09_ses-01_task-offline_run-04_eeg.edf');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off'); 
EEG = eeg_checkset( EEG );
EEG = pop_select( EEG, 'channel',{'FP1' 'FPz' 'FP2' 'AF7' 'AF3' 'AF4' 'AF8' 'F7' 'F5' 'F3' 'F1' 'Fz' 'F2' 'F4' 'F6' 'F8' 'FT7' 'FC5' 'FC3' 'FC1' 'FCz' 'FC2' 'FC4' 'FC6' 'FT8' 'T7' 'C5' 'C3' 'C1' 'Cz' 'C2' 'C4' 'C6' 'T8' 'TP7' 'CP5' 'CP3' 'CP1' 'CPz' 'CP2' 'CP4' 'CP6' 'TP8' 'P7' 'P5' 'P3' 'P1' 'Pz' 'P2' 'P4' 'P6' 'P8' 'PO7' 'PO3' 'POz' 'PO4' 'PO8' 'O1' 'Oz' 'O2' 'F9' 'F10'});
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'gui','off'); 
EEG = eeg_checkset( EEG );
%pop_eegplot( EEG, 1, 1, 1); % to plot
eeglab redraw

EEG=pop_chanedit(EEG, 'lookup','standard-10-5-cap385.elp');


% Low-pass filter @40 Hz
EEG = pop_eegfiltnew(EEG, [], 40, 174, 0, [], 1);

% High-pass filter at 1 Hz
EEG = pop_clean_rawdata(EEG, 'FlatlineCriterion','off','ChannelCriterion','off','LineNoiseCriterion','off','Highpass',[0.25 0.75] , ...
    'BurstCriterion','off','WindowCriterion','off','BurstRejection','off','Distance','Euclidian');
eeglab redraw

%save it for future processing with the naming convention:

%TruncatedFILENAME_filtered.set
%Example: ssub-09_ses-01_task-offline_run-04_filtered.set

EEG = pop_saveset( EEG, 'filename','sub-09_ses-01_task-offline_run-04_filtered.set','filepath','\Sample Dataset\');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);