# Descargar la imagen de Ubuntu
FROM ubuntu:22.04

# Establecer variables de entorno para evitar la interacción durante la instalación
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/México  

# Actualizar la lista de paquetes
RUN apt-get update --fix-missing

# Actualizar la imagen
RUN apt-get upgrade -y

# Instalar el paquete tzdata para la zona horaria y PHP
RUN apt-get install -y tzdata

# Configurar la zona horaria automáticamente
RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && dpkg-reconfigure --frontend noninteractive tzdata

# Instalar PHP y las dependencias necesarias
RUN apt-get install -y php php-cli php-mbstring

# Copiar la carpeta de la aplicación al contenedor
COPY ./app /home/app

# Establecer el directorio de trabajo
WORKDIR /home/app

# Exponer el puerto 8000
EXPOSE 8000

# Inicializar el servidor PHP para servir los archivos de la aplicación
CMD ["php", "-S", "0.0.0.0:8000", "-t", "."]