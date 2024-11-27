import pandas as pd
from sklearn.cluster import KMeans
import matplotlib.pyplot as plt

# Load the dataset
df = pd.read_csv("Iris.csv")

# Display the first few rows of the dataset
print("Dataset Preview:")
print(df.head())

# Select features for clustering (e.g., SepalLengthCm and SepalWidthCm)
X = df[['SepalLengthCm', 'SepalWidthCm']]

# Apply K-means clustering
n_clusters = 3  # Choose the number of clusters
kmeans = KMeans(n_clusters=n_clusters, random_state=42)
df['Cluster'] = kmeans.fit_predict(X)

# Print cluster centers
print("\nCluster Centers:")
for i, center in enumerate(kmeans.cluster_centers_):
    print(f"Cluster {i + 1}: {center}")

# Visualize the clusters
plt.figure(figsize=(8, 6))
for i in range(n_clusters):
    cluster_data = df[df['Cluster'] == i]
    plt.scatter(cluster_data['SepalLengthCm'], cluster_data['SepalWidthCm'], label=f'Cluster {i + 1}')

# Plot the centroids
plt.scatter(kmeans.cluster_centers_[:, 0], kmeans.cluster_centers_[:, 1], 
            color='purple', marker='*', s=200, label='Centroids')

plt.xlabel('Sepal Length (cm)')
plt.ylabel('Sepal Width (cm)')
plt.title('K-means Clustering on Iris Dataset')
plt.legend()
plt.show()
