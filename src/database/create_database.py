from sqlalchemy import create_engine, text

def create_database(conn_string, db_name):
    db_engine = create_engine(conn_string)
    try:
        with db_engine.connect().execution_options(isolation_level="AUTOCOMMIT") as connection:
            connection.execute((text(f"CREATE DATABASE {db_name};")))
            
            return("Database 'deped_masterlist' created successfully.")

    except Exception as e:
        
        return(f"An error occurred while creating the database: {e}")
    
    finally:
        db_engine.dispose()
