-- Storico prenotazioni di un cliente (Back-Office/Utente)
-- Recupera lo storico completo di tutti i viaggi acquistati da un utente specifico (es. tramite Email), mostrando il dettaglio di tutte le tratte incluse in ciascuna prenotazione.
-- La query naviga dalla persona che ha effettuato il pagamento (USER) attraverso la prenotazione (RESERVATION) fino a tutti i segmenti di viaggio (TICKET_SEGMENT e ROUTE).
SELECT
    RS.PNR_Code,
    RS.Purchase_Date_Time AS 'Data di acquisto',
    R.Departure_Date_Time AS Partenza,
    D_S.Name AS 'Stazione di partenza',
    A_S.Name AS 'Stazione di arrivo',
    V.Number AS Mezzo,
    S.Code AS Posto,
    P.Name AS 'Titolare biglietto',
    C.Name AS Classe,
    RS.Total_Price AS 'Prezzo totale prenotazione'
FROM 
    RESERVATION RS
JOIN 
    USER U ON RS.ID_USER_FK = U.ID_USER
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
    STATION D_S ON R.ID_DEPARTURE_STATION_FK = D_S.ID_STATION
JOIN 
    STATION A_S ON R.ID_ARRIVAL_STATION_FK = A_S.ID_STATION
JOIN
    CARRIAGE CR ON TS.ID_SEAT_FK IS NOT NULL AND TS.ID_SEAT_FK = CR.ID_CARRIAGE -- Solo per avere la classe
JOIN
    CLASS C ON CR.ID_CLASS_FK = C.ID_CLASS
JOIN
    SEAT S ON TS.ID_SEAT_FK = S.ID_SEAT
WHERE 
    U.Email = 'mario.rossi@mail.it'
ORDER BY 
    RS.Purchase_Date_Time DESC, R.Departure_Date_Time ASC;