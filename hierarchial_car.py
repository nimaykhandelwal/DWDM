import pandas as pd
import scipy.cluster.hierarchy as sch
from sklearn.cluster import AgglomerativeClustering
import matplotlib.pyplot as plt

# Load dataset
file_path = "C:\\Users\\nimay\\Desktop\\DWDMLABESE\\cars.csv"  # Replace with your actual file path
columns = ['Car', 'MPG', 'Cylinders', 'Displacement', 'Horsepower', 'Weight', 'Acceleration', 'Model', 'Origin']
df = pd.read_csv(file_path, names=columns, skiprows=1, delimiter=';')

# Clean the dataset
# Remove invalid rows where numeric columns have non-numeric values
for col in ['MPG', 'Cylinders', 'Displacement', 'Horsepower', 'Weight', 'Acceleration']:
    df[col] = pd.to_numeric(df[col], errors='coerce')  # Convert to numeric, replace invalid values with NaN

df = df.dropna()  # Drop rows with NaN values

# Selecting relevant features for clustering
X = df[['MPG', 'Horsepower', 'Weight', 'Acceleration']].values

# Plot the dendrogram
plt.figure(figsize=(10, 7))
dendrogram = sch.dendrogram(sch.linkage(X, method='ward'))
plt.title('Dendrogram')
plt.xlabel('Cars')
plt.ylabel('Euclidean distances')
plt.show()

# Perform Agglomerative Clustering
hc = AgglomerativeClustering(n_clusters=3, affinity='euclidean', linkage='ward')
y_hc = hc.fit_predict(X)

# Visualize the clusters
plt.scatter(X[y_hc == 0, 0], X[y_hc == 0, 1], s=100, c='red', label='Cluster 1')
plt.scatter(X[y_hc == 1, 0], X[y_hc == 1, 1], s=100, c='blue', label='Cluster 2')
plt.scatter(X[y_hc == 2, 0], X[y_hc == 2, 1], s=100, c='green', label='Cluster 3')

plt.title('Clusters of Cars')
plt.xlabel('MPG')
plt.ylabel('Horsepower')
plt.legend()
plt.show()
