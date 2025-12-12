-- Tasso di occupazione (load factor) per tratta
-- Questa query calcola il tasso di riempimento (load factor) di una specifica tratta, incrociando i posti venduti (TICKET_SEGMENT) con la capacità totale teorica (SEAT), essenziale per l'ottimizzazione dell'inventario e la pianificazione.
WITH Capacita AS (
    -- 1. Calcola la Capacità Totale per ogni combinazione ROUTE/CLASSE
    SELECT
        R.ID_ROUTE,
        C.Name AS Classe,
        COUNT(S.ID_SEAT) AS Total_Capacity_Per_Class
    FROM
        ROUTE R
    JOIN VEHICLE V ON R.ID_VEHICLE_FK = V.ID_VEHICLE
    JOIN CARRIAGE CR ON V.ID_VEHICLE = CR.ID_VEHICLE_FK
    JOIN CLASS C ON CR.ID_CLASS_FK = C.ID_CLASS
    JOIN SEAT S ON CR.ID_CARRIAGE = S.ID_CARRIAGE_FK
    GROUP BY R.ID_ROUTE, C.Name
),
PostiVenduti AS (
    -- 2. Calcola i Posti Venduti contando i TICKET_SEGMENT per ogni ROUTE
    SELECT
        TS.ID_ROUTE_FK,
        COUNT(TS.ID_TICKET_SEGMENT) AS Posti_Venduti
    FROM
        TICKET_SEGMENT TS
    GROUP BY
        TS.ID_ROUTE_FK
)
SELECT
    R.Departure_Date_Time AS Data,
    S_Dep.Name AS Partenza,
    S_Arr.Name AS Arrivo,
    Cap.Classe,
    Cap.Total_Capacity_Per_Class AS 'Capacità totale',
    -- Usa COALESCE per mostrare 0 posti venduti se il LEFT JOIN non trova risultati
    COALESCE(PV.Posti_Venduti, 0) AS 'Posti venduti',
    -- Calcola la percentuale usando i risultati isolati
    FORMAT(
        (COALESCE(PV.Posti_Venduti, 0) * 100.0 / Cap.Total_Capacity_Per_Class),
        2
    ) AS 'Tasso di occupazione (%)'
FROM
    ROUTE R
JOIN STATION S_Dep ON R.ID_DEPARTURE_STATION_FK = S_Dep.ID_STATION
JOIN STATION S_Arr ON R.ID_ARRIVAL_STATION_FK = S_Arr.ID_STATION
JOIN Capacita Cap ON R.ID_ROUTE = Cap.ID_ROUTE
LEFT JOIN PostiVenduti PV ON R.ID_ROUTE = PV.ID_ROUTE_FK
ORDER BY
    R.Departure_Date_Time ASC;