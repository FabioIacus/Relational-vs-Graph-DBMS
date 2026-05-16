import pandas as pd
import os

df = pd.read_csv(os.path.join('data', 'dataset.csv'))

# Display the first few rows and column information
print(df.head())
print(df.info())

# Check a sample of the 'artists' column
print(df['artists'].head(10))