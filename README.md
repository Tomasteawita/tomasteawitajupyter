# Tomasteawita Jupyter
---
Este proyecto fue desarrollado

## Contenido
* docker-compose.yml: Este archivo contiene los servicios utilizados para la ejecución del proyecto:
    * jupyter_spark:
        * Utiliza la imagen jupyter/pyspark-notebook:2023-04-24.
        * El contenedor se nombra como "tomasteawita_jupyter".
        * Mapea el puerto local 8888 al puerto 8888 dentro del contenedor.
        * Comparte el directorio local ./docker_shared_folder/working_dir con el directorio /home/coder/working_dir dentro del contenedor.
        * Utiliza el archivo .env ubicado en ./docker_shared_folder para cargar las variables de entorno.
        * Configura las variables de entorno NB_USER, NB_GID, CHOWN_HOME, CHOWN_HOME_OPTS y SPARK_CLASSPATH.
        * Se asigna a la red tomasteawita_net con una dirección IP específica.

    * Servicio postgres:
        * Utiliza la imagen oficial de Postgres versión 15.
        * El contenedor se nombra como "tomasteawita_postgres".
        * Mapea el puerto local 5435 al puerto 5435 dentro del contenedor.
        * Comparte el directorio local ./docker_shared_folder/postgres_data con el directorio /var/lib/postgresql/data dentro del contenedor.
        * Configura el comando -p 5435 para especificar el puerto de escucha de Postgres.
        * Utiliza el archivo .env ubicado en ./docker_shared_folder para cargar las variables de entorno.
        * Se asigna a la red tomasteawita_net con una dirección IP específica.
        * Además, se define una red llamada tomasteawita_net con la configuración IPAM (IP Address Management) que utiliza el controlador predeterminado y asigna una subred 172.7.7.0/16.

* docker_shared_folder/: Contiene los siguientes directorios y archivos.
    * working_dir: Es el directorio que contiene el notebook, scripts y modulo necesarios para la ejecución del proyecto.
        * spark_drivers/: contiene el driver para conectarse a la base de datos de Redshift mediante el uso de Spark.
    * .env: Archivo con variables de entorno.

## Creación del entorno
1. Para crear el entorno es necesario tener instalada Docker Desktop (https://www.docker.com/products/docker-desktop).
2. Creamos el directorio "postgres_data" y "working_dir", dentro del directorio docker_shared_folder.
3. Posicionados en el directorio raiz del proyecto ejecutamos:
```bash
  docker-compose up --build
```
4. Para acceder a JupyterLab ingresar a http://localhost:8888/lab?token=tomasteawita .
