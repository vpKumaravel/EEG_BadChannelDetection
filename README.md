__This repository contains the code for the paper submitted to IEEE SPMB 2021 Symposium titled "Towards a domain-specific NN approach for EEG Bad Channel Detection" (V.P. Kumaravel*, F. Paissan*, E. Farella)__

__For the NN implementation, refer to https://github.com/fpaissan/cleanEEGNet__

State-of-the-art traditional methods to detect and remove bad channels in scalp EEG using EEGLAB

1) Kurtosis measure (2006)
2) FASTER algorithm (2010)
3) ASR Clean_rawdata plugin (PREP-2015)
4) HAPPE (2018)

_Software dependencies:_
1) EEGLAB: https://sccn.ucsd.edu/eeglab/download.php
2) FASTER code implementation: https://sourceforge.net/projects/faster/

_Use case: E.g., to run FASTER pipeline_

* Open run_FASTER.m
* Set the root location of data and label files
* Execute the file
* The results (balanced accuracy and f1 score) can be found in result_FASTER mat file


This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; if not, see http://www.gnu.org/licenses/.
