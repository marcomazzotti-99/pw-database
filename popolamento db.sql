-- Inserimento Tipi di Veicolo (VEHICLE_TYPE)
INSERT INTO VEHICLE_TYPE (Name) VALUES
('Frecciarossa ETR 500'), 
('Regionale Veloce'),      
('Bus Extraurbano');      

-- Inserimento Classi (CLASS)
INSERT INTO CLASS (Name) VALUES
('Standard'),  
('Business'),   
('1^ Classe');  

-- Inserimento Offerte (OFFER)
INSERT INTO OFFER (Name, Refund_Flexibility, Change_Flexibility, Price_Multiplier) VALUES
('Base', 'Alta', 'Media', 1.00),        
('Economy', 'Bassa', 'Bassa', 0.85),    
('Super Economy', 'Nessuna', 'Nessuna', 0.60); 

-- Inserimento Stazioni (STATION)
INSERT INTO STATION (Name, City, Code) VALUES
('Milano Centrale', 'Milano', 'MI-CEN'), 
('Bologna Centrale', 'Bologna', 'BO-CEN'),
('Firenze S.M.N', 'Firenze', 'FI-SMN'), 
('Modena Autostazione', 'Modena', 'MO-AUT'); 

-- Inserimento Classi per Tipo Veicolo (VEHICLE_TYPE_CLASS_ASSOCIATION)
INSERT INTO VEHICLE_TYPE_CLASS_ASSOCIATION (ID_VEHICLE_TYPE_FK, ID_CLASS_FK) VALUES
(1, 1), -- Frecciarossa (ID=1) offre Standard (1) e Business (2)
(1, 2),
(2, 1), -- Regionale (ID=2) offre solo Standard (1)
(3, 1); -- Bus (ID=3) offre solo Standard (1)


-- Inserimento Veicoli (VEHICLE)
INSERT INTO VEHICLE (Number, Company, Capacity, Has_Seat_Choice, ID_VEHICLE_TYPE_FK) VALUES
('FR9510', 'Trenitalia', 450, TRUE, 1),   -- Frecciarossa
('RV2123', 'Trenitalia', 300, FALSE, 2),  -- Regionale
('BUS-A1', 'TPER', 50, FALSE, 3);         -- Bus

-- Inserimento Carrozze (CARRIAGE)
INSERT INTO CARRIAGE (Number, ID_VEHICLE_FK, ID_CLASS_FK) VALUES
-- Carrozze treno FR9510 (ID_VEHICLE=1): carrozza 1 (Business), carrozza 2 (Standard)
(1, 1, 2),
(2, 1, 1),
-- Carrozze treno Regionale RV2123 (ID_VEHICLE=2): carrozza 1 (Standard)
(1, 2, 1),
-- Carrozze Bus-A1 (ID_VEHICLE=3): carrozza unica
(1, 3, 1);

-- Inserimento Posti (SEAT)
INSERT INTO SEAT (Code, ID_CARRIAGE_FK) VALUES
-- Posti Frecciarossa (ID_CARRIAGE=1, Business)
('01A', 1), ('01B', 1), ('02A', 1), ('02B', 1), ('03A', 1), ('03B', 1), ('04A', 1), ('04B', 1), ('05A', 1), ('05B', 1),
-- Posti Regionale (ID_CARRIAGE=3, Standard)
('101', 3), ('102', 3), ('103', 3), ('104', 3), ('105', 3),
-- Posti Bus (ID_CARRIAGE=4, Standard)
('05C', 4), ('05D', 4);

-- Inserimento Utenti (USER)
INSERT INTO USER (Username, Name, Surname, CF, Email, Password_Hash, Password_Salt) VALUES
('mrossi80', 'Mario', 'Rossi', 'RSSMRI80A01H501K', 'mario.rossi@mail.it', 'hash_mario', 'salt_mario'),
('gverdi95', 'Giulia', 'Verdi', 'VRDGLI95E01G100R', 'giulia.verdi@mail.it', 'hash_giulia', 'salt_giulia');

-- Inserimento Carte Fedeltà (FIDELITY_CARD)
INSERT INTO FIDELITY_CARD (ID_USER_FK, Code, CF_Status, CF_StatusPoints, CF_PrizePoints, CF_StatusPoints_ExpireDate, CF_PrizePoints_ExpireDate, XGO_Points, XGO_Points_ExpireDate) VALUES
(1, '175800424', 'Argento', 1260.2, 512.5, '2025-12-31', '2026-05-31', 38.9, '2026-12-31');

-- Inserimento Passeggeri (PASSENGER)
INSERT INTO PASSENGER (Name, Surname, Cell, Email, ID_FIDELITY_CARD_FK) VALUES
('Mario', 'Rossi', '3315873468', 'mario.rossi@mail.it', 1),
('Luisa', 'Bianchi', '3298453128', 'luisa.bianchi@mail.it', NULL),
('Giulia', 'Verdi', '3358476364', 'giulia.verdi@mail.it', NULL);

-- Inserimento Coupon Sconto (DISCOUNT_COUPON)
INSERT INTO DISCOUNT_COUPON (Code, Value, Valid_From, Valid_To) VALUES
('SCONTO2025', 10.00, '2025-01-01', '2025-12-31');

-- Inserimento Associazione Sconto/Tipo Veicolo
INSERT INTO DISCOUNT_VEHICLE_TYPE_ASSOCIATION (ID_DISCOUNT_COUPON_FK, ID_VEHICLE_TYPE_FK) VALUES
(1, 1); -- SCONTO2025 (ID=1) si applica solo al Frecciarossa (ID=1)

-- Inserimento Tratte (ROUTE)
INSERT INTO ROUTE (Departure_Date_Time, Arrival_Date_Time, ID_VEHICLE_FK, ID_DEPARTURE_STATION_FK, ID_ARRIVAL_STATION_FK) VALUES
('2025-12-20 08:00:00', '2025-12-20 09:10:00', 1, 1, 2), -- ROUTE 1: MI-CEN (1) -> BO-CEN (2) con FR9510 (1)
('2025-12-20 09:30:00', '2025-12-20 10:20:00', 3, 2, 4), -- ROUTE 2: BO-CEN (2) -> MO-AUT (4) con Bus (3)
('2025-12-25 15:00:00', '2025-12-25 16:30:00', 2, 3, 2); -- ROUTE 3: FI-SMN (3) -> BO-CEN (2) con RV2123 (2)

-- Inserimento Prezzi (PRICE)
INSERT INTO PRICE (ID_ROUTE_FK, ID_CLASS_FK, ID_OFFER_FK, Base_Price) VALUES
-- Prezzi per ROUTE 1 (Frecciarossa):
(1, 1, 1, 45.00), -- Standard (ID=1), Base (ID=1): 45.00€ 
(1, 2, 1, 65.00), -- Business (ID=2), Base (ID=1): 65.00€
(1, 2, 2, 55.25), -- Business (ID=2), Economy (ID=2): 65.00 * 0.85 = 55.25€
-- Prezzi per ROUTE 2 (Bus):
(2, 1, 1, 8.00),-- Standard (ID=1), Base (ID=1): 8.00€
-- Prezzi per ROUTE 3 (Regionale, solo STANDARD):
(3, 1, 1, 12.50), -- Base (ID=1) 12.50€
(3, 1, 3, 7.50);  -- Super Economy (ID=3) 7.50€

-- Inserimento Prenotazione (RESERVATION)

INSERT INTO RESERVATION (PNR_Code, Purchase_Date_Time, Status, Total_Price, ID_USER_FK, ID_DISCOUNT_COUPON_FK) VALUES
-- Acquisto effettuato da Mario Rossi (ID_USER=1) usando SCONTO2025 (ID_DISCOUNT_COUPON=1)
-- [TICKET 1 (MR)]: (Route 1 Business Economy: 55.25) + (Route 2 Standard Base: 8.00) = 63.25€
-- [TICKET 2 (LB)]: (Route 1 Standard Base: 45.00) + (Route 2 Standard Base: 8.00) = 53.00€
-- Subtotale: 63.25 + 53.00 = 116.25€, applicazione SCONTO2025 (10.00€ sul subtotale): 116.25 - 10.00 = 106.25€
('AZW3FG', '2025-11-20 10:00:00', 'Pagata', 106.25, 1, 1),
-- Prenotazione effettuata da Giulia (ID_USER=2), prezzo calcolato: 7.50 EUR (Super Economy)
('FGT6YU', '2025-11-05 18:00:00', 'Pagata', 7.50, 2, NULL);

-- Inserimento Biglietti (TICKET)
INSERT INTO TICKET (ID_RESERVATION_FK, ID_PASSENGER_FK) VALUES
(1, 1), -- Biglietto 1: titolare Mario Rossi (ID_PASSENGER=1)
(1, 2), -- Biglietto 2: titolare Luisa Bianchi (ID_PASSENGER=2)
(2, 3); -- Biglietto 3: titolare Giulia Verdi (ID_PASSENGER=3)

-- Inserimento Segmenti (TICKET_SEGMENT)
INSERT INTO TICKET_SEGMENT (ID_TICKET_FK, ID_ROUTE_FK, ID_SEAT_FK) VALUES
-- Segmenti di Viaggio per TICKET 1 (Mario Rossi) - Totale 2 segmenti
(1, 1, 1), -- TICKET 1: Route 1 (MI->BO), Posto 01A (ID_SEAT=1)
(1, 2, 3), -- TICKET 1: Route 2 (BO->MO), Posto 05C (ID_SEAT=3)
-- Segmenti di Viaggio per TICKET 2 (Luisa Bianchi) - Totale 2 segmenti
(2, 1, 2), -- TICKET 2: Route 1 (MI->BO), Posto 01B (ID_SEAT=2)
(2, 2, 4), -- TICKET 2: Route 2 (BO->MO), Posto 05D (ID_SEAT=4)
-- Segmenti di Viaggio per TICKET 3 (Giulia Verdi) - Totale 1 segmento
(3, 3, 11); -- TICKET 3: Route 3, Posto 101 (ID_SEAT=11)