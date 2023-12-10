from os import environ as env
from pyspark.sql import SparkSession


class PySparkSession():
    """
    Clase para cargar datos en Postgres desde Spark utilizando Pyspark.

    """

    DRIVER_PATH = env['DRIVER_PATH']
    
    # Variables de configuración de Postgres
    POSTGRES_HOST = env['POSTGRES_HOST']
    POSTGRES_PORT = env['POSTGRES_PORT']
    POSTGRES_DB = env['POSTGRES_DB']
    POSTGRES_USER = env["POSTGRES_USER"]
    POSTGRES_PASSWORD = env["POSTGRES_PASSWORD"]
    POSTGRES_DRIVER = "org.postgresql.Driver"
    POSTGRES_URL = f"jdbc:postgresql://{POSTGRES_HOST}:{POSTGRES_PORT}/{POSTGRES_DB}"

    def __init__(self):
        """
        Inicializa la clase Load.

        Configura la sesión de Spark.

        """

        env['PYSPARK_SUBMIT_ARGS'] = f'--driver-class-path {self.DRIVER_PATH} --jars {self.DRIVER_PATH} pyspark-shell'
        env['SPARK_CLASSPATH'] = self.DRIVER_PATH

        # Crear sesión de Spark
        self.spark = SparkSession.builder \
                .master("local[1]") \
                .appName("Spark y Postgres") \
                .config("spark.jars", self.DRIVER_PATH) \
                .config("spark.executor.extraClassPath", self.DRIVER_PATH) \
                .getOrCreate()
        
    def load_to_postgres(self, df, table):
        """
        Carga un DataFrame de pandas en Postgres.

        Parameters:
        df (pandas.DataFrame): El DataFrame de pandas a cargar.
        table (str): El nombre de la tabla en Postgres donde se cargará el DataFrame.

        """

        print("Convertir el DataFrame de pandas a un PySpark DataFrame") 
        spark_df = self.spark.createDataFrame(df)
        print(spark_df)
        
        print("Cargar el PySpark DataFrame en Postgres") 
        try:
            spark_df.write \
                .format("jdbc") \
                .option("url", self.POSTGRES_URL) \
                .option("dbtable", table) \
                .option("user", self.POSTGRES_USER) \
                .option("password", self.POSTGRES_PASSWORD) \
                .option("driver", self.POSTGRES_DRIVER) \
                .mode("overwrite") \
                .save()
            
            print("Dataframe subido")
        except Exception as e:
            print("Se produjo excepción:", e)