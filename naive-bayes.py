import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.naive_bayes import GaussianNB
from sklearn.metrics import accuracy_score, confusion_matrix, classification_report

# Load the data
data = pd.read_csv("Naive-Bayes-Classification-Data.csv", header=None,names=['glucose', 'blood_pressure', 'diabetes'])

# Convert data to numeric type
data = data.apply(pd.to_numeric, errors='coerce')

# Drop any rows with NaN values
data = data.dropna()

# Split features and target
X = data[['glucose', 'blood_pressure']]
y = data['diabetes']

# Split the data into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Initialize and train the Naive Bayes classifier
nb_classifier = GaussianNB()
nb_classifier.fit(X_train, y_train)

# Make predictions
y_pred = nb_classifier.predict(X_test)

# Calculate accuracy
accuracy = accuracy_score(y_test, y_pred)

# Generate confusion matrix and classification report
conf_matrix = confusion_matrix(y_test, y_pred)
class_report = classification_report(y_test, y_pred)

print(f"Accuracy: {accuracy}")
print("\nConfusion Matrix:")
print(conf_matrix)
print("\nClassification Report:")
print(class_report)

# Function to calculate class probabilities
def calculate_class_probabilities(glucose, blood_pressure):
    feature_vector = np.array([[glucose, blood_pressure]])
    probabilities = nb_classifier.predict_proba(feature_vector)[0]
    return probabilities

# Example prediction
example_glucose = 50
example_blood_pressure = 75
probabilities = calculate_class_probabilities(example_glucose, example_blood_pressure)
print(f"\nProbabilities for Glucose={example_glucose}, Blood Pressure={example_blood_pressure}:")
print(f"P(No Diabetes | X) = {probabilities[0]:.4f}")
print(f"P(Diabetes | X) = {probabilities[1]:.4f}")
