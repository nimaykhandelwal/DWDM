import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import accuracy_score, classification_report, confusion_matrix, ConfusionMatrixDisplay

# Load the dataset (replace 'your_file_path.xlsx' with the correct path to your file)
df = pd.read_excel("C:\\Users\\nimay\\Desktop\\DWDMLABESE\\Online Retail.xlsx")

# Data Cleaning
# Drop rows with missing values in critical columns
df.dropna(subset=["CustomerID", "Quantity", "UnitPrice"], inplace=True)

# Remove negative quantities or unit prices
df = df[(df["Quantity"] > 0) & (df["UnitPrice"] > 0)]

# Feature Engineering: Create a TotalAmount column
df["TotalAmount"] = df["Quantity"] * df["UnitPrice"]

# Encode categorical variables (e.g., 'Country' and 'Description')
df["Country_encoded"] = df["Country"].astype("category").cat.codes
df["Description_encoded"] = df["Description"].astype("category").cat.codes

# Prepare features (X) and target (y)
# Features: Quantity, UnitPrice, TotalAmount, Country_encoded
X = df[["Quantity", "UnitPrice", "TotalAmount", "Country_encoded"]]

# Target: Encode 'CustomerID' as numerical labels for classification
df["CustomerID_encoded"] = df["CustomerID"].astype("category").cat.codes
y = df["CustomerID_encoded"]

# Print the labels and first 5 rows of the dataset
print("Unique Target Labels:", y.unique())
print("\nFirst 5 entries of the dataset:\n", X.head())

# Split the dataset into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)

# Create a Decision Tree classifier
dt_classifier = DecisionTreeClassifier(max_depth=5, min_samples_split=10, random_state=42)

# Train the classifier
dt_classifier.fit(X_train, y_train)

# Make predictions using the Decision Tree
y_pred_dt = dt_classifier.predict(X_test)

# Calculate Decision Tree accuracy
accuracy_dt = accuracy_score(y_test, y_pred_dt)
print(f"\nDecision Tree Accuracy: {accuracy_dt * 100:.2f}%")

# Classification Report
print("\nClassification Report:\n", classification_report(y_test, y_pred_dt))

# Confusion Matrix
conf_matrix_dt = confusion_matrix(y_test, y_pred_dt)
disp = ConfusionMatrixDisplay(confusion_matrix=conf_matrix_dt)
disp.plot(cmap=plt.cm.Blues)
plt.title("Decision Tree Confusion Matrix")
plt.show()

# Feature Importance
feature_importance = dt_classifier.feature_importances_
print("\nFeature Importance:")
for i, col in enumerate(X.columns):
    print(f"{col}: {feature_importance[i]:.4f}")
