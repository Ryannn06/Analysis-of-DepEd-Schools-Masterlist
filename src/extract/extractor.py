import pandas as pd
import pdfplumber
 
def extract_pdf_to_csv(path_to_pdf):
    tables = []

    path_to_pdf = path_to_pdf

    i = 0

    with pdfplumber.open(path_to_pdf) as pdf:
        for page in pdf.pages:
            table = page.extract_table({})

            i += 1
            print('processed page/s:', i)

            if table:
                for row in table[1:]:
                    tables.append(row)

    df = pd.DataFrame(tables, columns=[ 'region',
                                        'division',
                                        'district',
                                        'beis_school_id',
                                        'school_name' ,
                                        'street_address',
                                        'municipality',
                                        'legislative_district',
                                        'barangay', 
                                        'sector',
                                        'urban_rural_classification',
                                        'school_subclassification',
                                        'modified_curricural_offering_lassification'])
    df.to_csv("2020-2021-Deped_Schools_Masterlist.csv", index=False, encoding='utf-8')# Implementation of data extraction