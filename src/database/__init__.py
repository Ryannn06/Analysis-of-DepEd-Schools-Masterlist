def create_database(conn_string):
    db_engine = create_engine(conn_string)

    try:
        with db_engine.connect().execution_options(isolation_level="AUTOCOMMIT") as connection:
            connection.execute((text(f"CREATE DATABASE {self._db_name};")))
            print("Database 'deped_masterlist' created successfully.")

    except Exception as e:
        print(f"An error occurred while creating the database: {e}")
    
    finally:
        db_engine.dispose()