# Usar una imagen base que ya tiene Spark preinstalado
FROM jupyter/pyspark-notebook:latest

# Cambiar al usuario root
USER root

# Actualizar pip e instalar los paquetes necesarios en una sola capa
RUN pip install --upgrade pip && \
    pip install jupyterlab==3.1.12 notebook spylon-kernel && \
    pip install --upgrade jupyter_server

# Instalar R y el kernel de R para Jupyter, luego limpiar la caché de apt
RUN apt-get update && \
    apt-get install -y r-base && \
    R -e "install.packages('IRkernel', repos='http://cran.rstudio.com/')" && \
    R -e "IRkernel::installspec(user = FALSE)" && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Instalar spylon kernel
RUN python -m spylon_kernel install

# Configurar variables de entorno para Spark
ENV SPARK_HOME=/usr/local/spark
ENV PATH=$PATH:/usr/local/spark/bin
ENV PYSPARK_PYTHON=/usr/local/bin/python

# Exponer el puerto de Jupyter
EXPOSE 8888

# Configurar el directorio de trabajo
WORKDIR /home

# Comando para iniciar Jupyter Lab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--LabApp.token=''"]