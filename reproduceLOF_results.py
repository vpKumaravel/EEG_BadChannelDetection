"""
This code reproduces the plot used in the paper:
https://www.mdpi.com/1424-8220/22/19/7314

It generates bar plots showing the precomputed mean F1 scores (across 10-Folds) for various EEG bad channel detection methods,
with error bars representing the standard error of the mean (SEM). 

The methods plotted are:
- Kurtosis
- FASTER
- CRD
- HAPPE
- LOF

The plot is separated into three subplots for different population categories:
- Newborn
- Infant
- Adult

Each method is colored according to the following palette:
- Orange
- Blue
- Red
- Violet
- Green
"""

import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

# Data
methods = ['Kurtosis', 'FASTER', 'CRD', 'HAPPE', 'LOF']
categories = ['Newborn', 'Infant', 'Adult']

mean_f1_scores = {
    'Newborn': [0.30, 0.40, 0.38, 0.45, 0.63],
    'Infant': [0.23, 0.17, 0.21, 0.25, 0.35],
    'Adult': [0.14, 0.15, 0.11, 0.24, 0.45]
}

sem_errors = {
    'Newborn': [0.022, 0.014, 0.019, 0.016, 0.018],
    'Infant': [0.012, 0.011, 0.006, 0.008, 0.007],
    'Adult': [0.008, 0.006, 0.008, 0.006, 0.016]
}

# Convert data to DataFrame
data = []
for category in categories:
    for method, mean, sem in zip(methods, mean_f1_scores[category], sem_errors[category]):
        data.append([category, method, mean, sem])

df = pd.DataFrame(data, columns=['Category', 'Method', 'Mean F1 Score', 'SEM'])

# Define custom color palette in the specified order
custom_palette = {
    'Kurtosis': '#FF7F0E',  # Orange
    'FASTER': '#1F77B4',    # Blue
    'CRD': '#D62728',       # Red
    'HAPPE': '#9467BD',     # Violet
    'LOF': '#2CA02C'        # Green
}

# Plotting
sns.set(style="whitegrid")

fig, axes = plt.subplots(1, 3, figsize=(18, 6), sharey=True)

for ax, category in zip(axes, categories):
    subset = df[df['Category'] == category]
    sns.barplot(
        x='Method', y='Mean F1 Score', data=subset, 
        palette=custom_palette, ax=ax, ci=None
    )
    ax.errorbar(
        x=np.arange(len(methods)), 
        y=subset['Mean F1 Score'], 
        yerr=subset['SEM'], 
        fmt='none', 
        c='black', 
        capsize=5
    )
    ax.set_title(category)
    ax.set_xlabel('Method')
    if category == 'Newborn':
        ax.set_ylabel('Mean F1 Score')
    else:
        ax.set_ylabel('')

plt.suptitle('Mean F1 Scores with SEM Error Bars')
plt.tight_layout(rect=[0, 0, 1, 0.95])
plt.show()
