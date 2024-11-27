import pandas as pd 
from mlxtend.frequent_patterns import apriori 
from mlxtend.frequent_patterns import association_rules 
# Read the dataset from the CSV file 
df = pd.read_csv('transactions.csv') 
# Display the first few rows to ensure it's read correctly 
print("Dataset:") 
print(df.head()) 
# Generate frequent itemsets using Apriori 
frequent_itemsets = apriori(df, min_support=0.2, use_colnames=True) 
# Generate association rules 
rules = association_rules(frequent_itemsets, metric="confidence", 
min_threshold=0.6) 
# Display all columns of the rules 
print("\nAssociation Rules:") 
print(rules[['antecedents', 'consequents', 'confidence']]) 
# Save the rules to a CSV file 
rules.to_csv('association_rules.csv', index=False) 
print("\nAssociation rules have been saved to 'association_rules.csv'.")