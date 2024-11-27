import pandas as pd 
import numpy as np 
import matplotlib.pyplot as plt 
from scipy.cluster.hierarchy import dendrogram, linkage 
from sklearn.preprocessing import StandardScaler 
def load_and_cluster_employee_data(): 
    # Load the dataset from CSV 
    df = pd.read_csv('employee_data.csv') 
 
    # Selecting relevant features for clustering 
    features = df[['Age', 'Salary', 'Years at Company']] 
 
    # Standardizing the features 
    scaler = StandardScaler() 
    X_scaled = scaler.fit_transform(features) 
 
    # Perform hierarchical clustering 
    Z = linkage(X_scaled, method='ward') 
    return Z, df 
 
 
def plot_dendrogram(Z): 
    plt.figure(figsize=(10, 7)) 
    dendrogram(Z) 
    plt.title("Hierarchical Clustering Dendrogram") 
    plt.xlabel("Sample Index") 
    plt.ylabel("Distance") 
    plt.show() 
 
 
if __name__ == "__main__": 
    # Load the dataset and perform clustering 
    Z, df = load_and_cluster_employee_data() 
 
    # Plot the dendrogram 
    plot_dendrogram(Z) 