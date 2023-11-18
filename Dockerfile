# Usar una imagen base que ya tiene Spark preinstalado
FROM jupyter/pyspark-notebook:python-3.11

# Cambiar al usuario root
USER root

# Actualizar pip e instalar los paquetes necesarios en una sola capa
RUN pip install --upgrade pip && \
    pip install jupyterlab==3.1.12 notebook spylon-kernel && \
    pip install --upgrade jupyter_server && \
    apt-get update && apt-get install -y r-base && \
    R -e "install.packages('IRkernel', repos='http://cran.rstudio.com/')" && \
    R -e "IRkernel::installspec(user = FALSE)" && \
    python -m spylon_kernel install && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*