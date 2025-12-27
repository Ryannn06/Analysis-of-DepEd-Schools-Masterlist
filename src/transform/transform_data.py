import pandas as pd
from sklearn.preprocessing import LabelEncoder

from lib.dict import corrections, correct_sub, region_coordinates

def transform(orig_data):
    try:
        """Copy original data to avoid modifying it directly."""
        data = orig_data.copy().sort_values(by='region', ascending=True).reset_index(drop=True)

        # 1. Drop columns with any missing values
        data.dropna(inplace=True)

        # 2. Drop duplicate rows
        data.drop_duplicates(inplace=True)

        # 3. Standardize formats
        locations = ['division','district','school_name','street_address','municipality','barangay']

        for column in locations:
            data[column] = data[column].str.replace("Ã‘", "Ñ").str.strip().str.title()

        # for school_id
        data['beis_school_id'] = data['beis_school_id'].str.strip().str.replace(r'[^0-9]', '', regex=True).astype(int)

        # for municipality corrections
        data['municipality'] = data['municipality'].replace(corrections).str.strip().str.title()

        # for urban_rural_classification
        data['urban_rural_classification']= data['urban_rural_classification'].str.replace('Partially Ur','Partially Urbanized')

        # for school_subclassification
        data['school_subclassification'] = data['school_subclassification'].replace(correct_sub)


        """ Encode region names to unique IDs """
        encoder = LabelEncoder()

        encoded = encoder.fit_transform(data['region'])
        data['region_id'] = encoded + 1

        """ Create region table """
        region_table = data[['region','region_id']].drop_duplicates().reset_index(drop=True).sort_values('region_id')
        
        """ Drop original region column from main data """
        data.drop(columns=['region'], inplace=True)

        """Add Latitude and Longitude columns based on region"""
        region_table['latitude'] = region_table['region'].map(lambda x: region_coordinates.get(x, {}).get('latitude'))
        region_table['longitude'] = region_table['region'].map(lambda x: region_coordinates.get(x, {}).get('longitude'))
        

        """ Rename columns for consistency """
        data = data.rename(columns={'urban_rural_classification':'urban_rural',
                            'modified_curricural_offering_lassification':'modified_curricular_offering_classification'})
        
        region_table = region_table.rename(columns={'region':'region_name'})

        print("Dataset has been transformed successfully")

        """ Return cleaned data """
        return data, region_table
    
    except Exception as e:
        print(f"An error occurred during data transformation: {e}")