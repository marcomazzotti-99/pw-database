-- Verifica validità di un biglietto (operazione transazionale)
-- Query per il controllo a bordo. Tramite il PNR ed i dettagli del segmento (ROUTE), verifica rapidamente se il passeggero ha un posto assegnato e se la transazione è attiva.
SELECT
    P.Name AS Nome,
    P.Surname AS Cognome,
    RS.Status AS 'Stato prenotazione',
    S.Code AS Posto,
    CR.Number AS Carrozza,
    R.Departure_Date_Time AS Partenza,
    R.Arrival_Date_Time AS Arrivo
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
LEFT JOIN 
    SEAT S ON TS.ID_SEAT_FK = S.ID_SEAT
LEFT JOIN 
    CARRIAGE CR ON S.ID_CARRIAGE_FK = CR.ID_CARRIAGE
WHERE 
    RS.PNR_Code = 'AZW3FG' -- Codice PNR
    AND R.ID_ROUTE = 1 -- Filtro sulla tratta corrente (es. MI-CEN -> BO-CEN)
    AND RS.Status = 'Pagata'; -- Stato valido (esclude 'Cancellata' o 'Rimborsata')