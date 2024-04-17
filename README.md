# ClimaEs
=======
# 🌤️ ClimaEs (versión en bruto)
---
## Ya se ha aplicado
<ul>
  <li>Diseño de código + SnapKit</li>
  <li>Recuperación de datos JSON y XML a través de Alamofire</li>
  <li>Adición de playas para mostrar en la pantalla, implementado a través de la selección en el mapa (MapKit)</li>
  <li>También es posible añadir playas mediante la búsqueda</li>
  <li>Coordenadas de las playas - estáticas (deben eliminarse de la base de datos)</li>
</ul>
<hr width="500" size="1"/>
## Por realizar
<ul>
  <li>Añadir Realm y base de datos de ciudades españolas (para las que se dispone de datos de AEMET) con ±8000 coordenadas de ciudades.</li>
  <li>~~Configurar y verificar la geolocalización del usuario, solicitar la provincia a través de la geocodificación inversa de OSM (Core Location).~~ Creo que es más rápido hacer una búsqueda por coordenadas que a través de una consulta OSM</li>
  <li>Visualización en la pantalla principal: previsiones meteorológicas diarias y horarias de la ciudad más cercana.</li>
  <li>Pantalla adicional que muestra la fuerza del viento en el mapa</li>
  <li>Añadir localizaciones en otros idiomas</li>
  <li>Verificación del rendimiento y redacción de pruebas</li>
</ul>


<hr width="500" size="1"/>
Los datos pertenecen a Agencia Estatal de Meteorología - AEMET. Gobierno de España
© AEMET. Autorizado el uso de la información y su reproducción citando a AEMET como autora de la misma.
http://www.aemet.es
