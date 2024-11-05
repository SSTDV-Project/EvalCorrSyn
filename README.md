# EvalCorrSyn

Evaluation of Multivariate Distribution Similarity in Synthetic Data
The statistical similarity between the real and synthetic data for pairs of features. This is often called the correlation or bivariate distributions of the features.
Target features in real and synthetic data : age, intracranial volume, the volume of lateral ventricle.

In the script, 
1) Read in a CSV file with age, intracranial volume, and lateral ventricle volume values from real and synthetic data to calculate the correlation between age and lateral ventricle volume.
2) The correlation between age and lateral ventricle is modeled by polynominal of degree 1, 2, and 3.
3) Select the model that best fits the data.
4) Statistically validate the similarity between the parameters of the model estimated from the real data and those estimated from the synthetic data.

Example features of interest in real and synthetic data: age, intracranial volume, and volume of the lateral ventricles.
The correlation of the ratio of intracranial volume to lateral ventricles (%) was estimated by referring to the study below.

Age-Related Differences in Brain Morphology and the Modifiers in Middle-Aged and Older Adults, Lu Zhao et al., Cerebral Cortex 2019

# Acknowledgement

This work was supported by Institute for Information & communications Technology Promotion(IITP) grant funded by the Korea government(MSIT) (No.00223446, Development of object-oriented synthetic data generation and evaluation methods) and the Technology Innovation Program (20011875, Development of AI-Based Diagnostic Technology for Medical Imaging Devices) funded by the Ministry of Trade, Industry & Energy (MOTIE, Korea).
