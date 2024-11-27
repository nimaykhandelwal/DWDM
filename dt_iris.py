import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import accuracy_score, classification_report, confusion_matrix, ConfusionMatrixDisplay

# Load the Iris dataset
data = pd.read_csv('iris.csv')  # Update the file name if needed
X = data.drop(['Id', 'Species'], axis=1)  # Features
y = data['Species']  # Labels

# Print the unique target labels and the first 5 entries of the dataset
print("Unique Target Labels:", y.unique())
print("\nFirst 5 entries of the dataset:\n", X.head())

# Split the dataset into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)

# Create a Decision Tree classifier
dt_classifier = DecisionTreeClassifier(max_depth=5, min_samples_split=10, random_state=42)

# Train the classifier
dt_classifier.fit(X_train, y_train)

# Make predictions using Decision Tree
y_pred_dt = dt_classifier.predict(X_test)

# Calculate Decision Tree accuracy
accuracy_dt = accuracy_score(y_test, y_pred_dt)
print(f"\nDecision Tree Accuracy: {accuracy_dt * 100:.2f}%")

# Classification report
print("\nClassification Report:\n", classification_report(y_test, y_pred_dt))

# Confusion Matrix
conf_matrix_dt = confusion_matrix(y_test, y_pred_dt, labels=y.unique())
disp = ConfusionMatrixDisplay(confusion_matrix=conf_matrix_dt, display_labels=y.unique())
disp.plot(cmap=plt.cm.Blues)
plt.title('Decision Tree Confusion Matrix')
plt.show()
