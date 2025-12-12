-- Dettaglio prenotazione
-- Visualizza i dettagli del viaggio multitratta (segmenti, posto, passeggeri, prezzo finale, sconto applicato) partendo dal codice PNR.
SELECT
    RS.PNR_Code as PNR,
    RS.Total_Price AS Prezzo,
    DC.Code AS 'Codice sconto',
    P.Name AS Nome,
    P.Surname AS Cognome,
    S_Dep.Name AS Partenza,
    S_Arr.Name AS Arrivo,
    R.Departure_Date_Time AS 'Orario di partenza',
    C.Name AS Classe, 
    SEAT.Code AS Posto,
    V.Number AS Mezzo
FROM 
    RESERVATION RS
JOIN 
    TICKET T ON RS.ID_RESERVATION = T.ID_RESERVATION_FK
JOIN 
    PASSENGER P ON T.ID_PASSENGER_FK = P.ID_PASSENGER
JOIN 
    TICKET_SEGMENT TS ON T.ID_TICKET = TS.ID_TICKET_FK
JOIN 
    ROUTE R ON TS.ID_ROUTE_FK = R.ID_ROUTE
JOIN 
    VEHICLE V ON R.ID_VEHICLE_FK = V.ID_VEHICLE
JOIN 
    STATION S_Dep ON R.ID_DEPARTURE_STATION_FK = S_Dep.ID_STATION
JOIN 
    STATION S_Arr ON R.ID_ARRIVAL_STATION_FK = S_Arr.ID_STATION
LEFT JOIN 
    DISCOUNT_COUPON DC ON RS.ID_DISCOUNT_COUPON_FK = DC.ID_DISCOUNT_COUPON
LEFT JOIN 
    SEAT ON TS.ID_SEAT_FK = SEAT.ID_SEAT
LEFT JOIN 
    CARRIAGE CR ON SEAT.ID_CARRIAGE_FK = CR.ID_CARRIAGE
LEFT JOIN 
    CLASS C ON CR.ID_CLASS_FK = C.ID_CLASS
WHERE 
    RS.PNR_Code = 'FGT6YU'
ORDER BY 
    R.Departure_Date_Time ASC, P.Name;