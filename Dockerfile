FROM python:3.10
WORKDIR /
RUN mkdir jupyter-lab
WORKDIR jupyter-lab
RUN pip install --upgrade pip
RUN pip install pandas 'jupyterlab>=3.0.0,<4.0.0a0' scipy matplotlib pymystem3 jupyterlab-lsp python-lsp-server[all] python-language-server pydub \
    psycopg2 tqdm ipywidgets SQLAlchemy sqlalchemy-redshift redshift_connector PyDrive2 openpyxl
RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get update && apt-get upgrade -y && \
    apt install -y nodejs ffmpeg && \
    npm install -g npm@latest && \
    npm install --save-dev bash-language-server dockerfile-language-server-nodejs sql-language-server \
    unified-language-server --no-fund
WORKDIR /jupyter-lab
RUN pip install --upgrade jupyterlab jupyterlab-git
RUN pip install jupyterlab-topbar jupyter-resource-usage jupyterlab-system-monitor jupyterlab-lsp jedi-language-server \
    lckr-jupyterlab-variableinspector pyright pivottablejs atlassian-python-api xlrd
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager
RUN jupyter labextension install jupyterlab_onedarkpro
RUN jupyter-lab build
ENTRYPOINT jupyter-lab --no-browser --port=8888 --ip=0.0.0.0 --allow-root
# docker run -p 8888:8888 --rm -it -v D:\git\jupyterlab\:/jupyter-lab jupyterlab