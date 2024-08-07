__This repository contains the code for the paper submitted to IEEE SPMB 2021 Symposium titled "Towards a domain-specific NN approach for EEG Bad Channel Detection" (V.P. Kumaravel*, F. Paissan*, E. Farella)__

__For the Neural Nets implementation, please refer to https://github.com/fpaissan/cleanEEGNet__

# EEG Bad Channel Detection State-of-the-art Methods

This repository provides state-of-the-art traditional methods to detect and remove bad channels in scalp EEG using EEGLAB.

## Methods Included In This Repository
1. **Kurtosis Measure (2006)**
2. **FASTER Algorithm (2010)**
3. **ASR Clean_rawdata Plugin (PREP-2015)**
4. **HAPPE (2018)**

## Software Dependencies
1. **EEGLAB**: [Download EEGLAB](https://sccn.ucsd.edu/eeglab/download.php)
2. **FASTER Code Implementation**: [Download FASTER](https://sourceforge.net/projects/faster/)

## Use Case: Running the FASTER Pipeline
To run the FASTER pipeline:

1. Open `run_FASTER.m`
2. Set the root location of data and label files
3. Execute the file
4. The results (balanced accuracy and F1 score) can be found in the `result_FASTER.mat` file

## Citation
If you use this code, please cite the following publications:

1. Kumaravel, V.P.; Buiatti, M.; Parise, E.; Farella, E. Adaptable and Robust EEG Bad Channel Detection Using Local Outlier Factor (LOF). Sensors 2022, 22, 7314. https://doi.org/10.3390/s22197314

2. Kumaravel, V., Paissan, F. & Farella, E. Towards a domain-specific neural network approach for EEG bad channel detection. in 2021 IEEE Signal Processing in Medicine and Biology Symposium (SPMB) 1–4 (IEEE, 2021).

## Important Update

In our attempts to find a robust bad channel detection method, we adapted the LOF (Local Outlier Factor) to EEG for the first time and we found much improved performance compared to the existing approaches. The code is freely available as an EEGLAB plugin ([here](https://github.com/vpKumaravel/detectbadchannelLOF)) and also a part of MNE-Python preprocessing routine ([here](https://github.com/mne-tools/mne-python/blob/main/mne/preprocessing/_lof.py#L15-L99)).

## License
This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; if not, see [GNU General Public License](http://www.gnu.org/licenses/).
