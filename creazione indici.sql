-- Indice 1: ricerca per data/ora di partenza
CREATE INDEX idx_route_departure_time 
ON ROUTE (Departure_Date_Time);

-- Indice 2: ricerca per coppia di stazioni
CREATE INDEX idx_route_dep_arr 
ON ROUTE (ID_DEPARTURE_STATION_FK, ID_ARRIVAL_STATION_FK);