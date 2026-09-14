# Guía de de uso de docker y ros2 para principiantes

En esta guía se detallará paso a paso el uso de dockers para correr aplicaciones, sin necesidad de saber algo sobre el tema previamente.
Para ello, primero será necesario saber que es docker y porque es tan importante.
Docker es una herramienta que permite empaquetar una aplicación junto con todo lo que necesita para funcionar (código, librerías...) en una especie
de contenedor.
La principal ventaja que tiene es que ese contenedor se ejecuta en cualquier ordenador que tenga instalado docker independientemente de lo que tenga instalado.
Un ejemplo sería que programas una web en tu ordenador. Usas Python versión 3.11 y una librería llamada Flask. En tu máquina todo funciona perfecto.

Ahora le mandas el código a un compañero de trabajo para que lo pruebe. Pero su ordenador tiene Python 3.9, no tiene Flask instalado, y usa otro sistema operativo. El programa falla, aunque el código sea exactamente el mismo.

Docker resuelve esto metiendo tu aplicación, la versión exacta de Python, Flask, y todo lo demás en una "caja" (el contenedor). Le mandas esa caja a tu compañero, y él la abre con un solo comando. Adentro está todo lo necesario, así que funciona igual en su ordenador, sin que le importe qué tiene instalado.

Para empezar con docker, recomiendo ver el siguiente video, especialmente la parte teórica para poder entender como funciona exactamente y que cosas se pueden hacer con el.

https://www.youtube.com/watch?v=4Dko5W96WHg&t=3983s

Para poder comenzar será necesario descargar docker-desktop en el ordenador, junto con otras herramientas. Para aligerar el proceso he creado un makefile en este repo con los comandos necesarios para instalar todo sin problemas.
Para ello, será hacer un make all en la terminal dentro del repo.
En el caso de que solo se quiera descargar una parte especifica podremos mirar con el comando make info las diferentes opciones que tenemos.







