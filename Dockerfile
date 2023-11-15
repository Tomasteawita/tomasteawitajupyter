FROM jupyter/pyspark-notebook:2023-04-24

USER root

RUN pip install --upgrade pip
RUN pip install jupyterlab==3.1.12 notebook spylon-kernel
RUN pip install --upgrade jupyter_server

# Instalar R y el kernel de R para Jupyter
RUN apt-get update && apt-get install -y r-base
RUN R -e "install.packages('IRkernel', repos='http://cran.rstudio.com/')"
RUN R -e "IRkernel::installspec(user = FALSE)"

RUN python -m spylon_kernel install