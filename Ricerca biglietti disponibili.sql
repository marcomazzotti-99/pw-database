-- Ricerca biglietti disponibili (Front-Office)
-- Trova tutti i posti disponibili su una specifica tratta (es. Milano -> Bologna) in una data e ora, filtrando per una specifica classe di servizio.
-- La query confronta l'inventario totale dei posti (SEAT -> CARRIAGE -> VEHICLE) con i posti già venduti su quella specifica tratta (TICKET_SEGMENT).
SELECT 
    V.Number AS "Numero veicolo",
    VT.Name AS "Tipo veicolo",
    C.Name AS Classe,
    R.Departure_Date_Time AS Partenza,
    R.Arrival_Date_Time AS Arrivo,
    (COUNT(S.ID_SEAT) - COUNT(TS.ID_SEAT_FK)) AS "Posti disponibili"
FROM 
    ROUTE R
JOIN 
    VEHICLE V ON R.ID_VEHICLE_FK = V.ID_VEHICLE
JOIN 
    VEHICLE_TYPE VT ON V.ID_VEHICLE_TYPE_FK = VT.ID_VEHICLE_TYPE
JOIN 
    CARRIAGE CR ON V.ID_VEHICLE = CR.ID_VEHICLE_FK
JOIN 
    CLASS C ON CR.ID_CLASS_FK = C.ID_CLASS
JOIN 
    SEAT S ON CR.ID_CARRIAGE = S.ID_CARRIAGE_FK -- Posti totali
LEFT JOIN 
    TICKET_SEGMENT TS ON R.ID_ROUTE = TS.ID_ROUTE_FK AND S.ID_SEAT = TS.ID_SEAT_FK -- Posti venduti
WHERE 
    R.ID_DEPARTURE_STATION_FK = (SELECT ID_STATION FROM STATION WHERE Code = 'MI-CEN') -- ID Milano
    AND R.ID_ARRIVAL_STATION_FK = (SELECT ID_STATION FROM STATION WHERE Code = 'BO-CEN')   -- ID Bologna
    AND DATE(R.Departure_Date_Time) = '2025-12-20' -- Filtro data
    AND C.Name = 'Business' -- Filtro classe
GROUP BY 
    V.Number, C.Name, R.ID_ROUTE;