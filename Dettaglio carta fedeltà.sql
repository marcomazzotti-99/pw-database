-- Punti utente
-- Recuperare i dettagli della carta fedeltà (punti, status, scadenza) di un utente loggato.
SELECT
    U.Name,
    U.Surname,
    FC.Code AS 'CartaFRECCIA/XGO',
    FC.CF_Status AS 'Status CartaFRECCIA',
    FC.CF_StatusPoints AS 'Punti Status CartaFRECCIA',
    FC.CF_StatusPoints_ExpireDate AS 'Scadenza Punti Status CartaFRECCIA',
    FC.CF_PrizePoints AS 'Punti premio CartaFRECCIA',
    FC.CF_PrizePoints_ExpireDate AS 'Scadenza Punti premio CartaFRECCIA',
    FC.XGO_Points AS 'Saldo punti XGO',
    FC.XGO_Points_ExpireDate AS 'Scadenza punti XGO'
FROM 
    USER U
JOIN 
    FIDELITY_CARD FC ON U.ID_USER = FC.ID_USER_FK
WHERE 
    U.Email = 'mario.rossi@mail.it'; -- Filtro sull'utente loggato