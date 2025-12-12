-- Creazione DB
CREATE DATABASE Trenitalia_DB;
USE Trenitalia_DB;

-- Imposta l'engine InnoDB per il supporto a transazioni e chiavi esterne
SET default_storage_engine=InnoDB;

-- Entità: VEHICLE_TYPE
-- Contiene le varie tipologie di veicoli presenti nella rete di trasporti (es. Frecciarossa, Regionali, Intercity, Bus)
CREATE TABLE VEHICLE_TYPE (
    ID_VEHICLE_TYPE INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL UNIQUE
);

-- Entità: STATION
-- Rappresenta i nodi della rete ferroviaria
CREATE TABLE STATION (
    ID_STATION INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    City VARCHAR(100) NOT NULL,
    Code VARCHAR(10) UNIQUE
);

-- Entità: CLASS
-- Classi di servizio (es. Standard, Business, Prima Classe)
CREATE TABLE CLASS (
    ID_CLASS INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50) NOT NULL UNIQUE
);

-- Entità: OFFER
-- Politiche commerciali (es. Base, Economy, Super Economy)
CREATE TABLE OFFER (
    ID_OFFER INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL UNIQUE,
    Refund_Flexibility VARCHAR(50) NOT NULL, -- Politica sul rimborso
    Change_Flexibility VARCHAR(50) NOT NULL, -- Politica sul cambio
    Price_Multiplier DECIMAL(4, 2) DEFAULT 1.00
);

-- Entità: USER
-- Acquirente, chi ha un account sul sistema
CREATE TABLE USER (
    ID_USER INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR (15) NOT NULL UNIQUE,
    Name VARCHAR(100) NOT NULL,
    Surname VARCHAR(100) NOT NULL,
    CF VARCHAR(16) UNIQUE, 
    Email VARCHAR(150) NOT NULL UNIQUE,
	Cell VARCHAR(20),
    Address VARCHAR(50),
    -- Per motivi di sicurezza la password non viene salvata in chiaro sul DB ma vengono utilizzati l'hash e il salt 
    Password_Salt VARCHAR(50) NOT NULL, -- Salt casuale generato dal server da combinare con la password dell'utente         
    Password_Hash VARCHAR(255) NOT NULL -- Hash calcolato da password + salt
);

-- Entità: FIDELITY_CARD
-- Carta punti (CARTAFRECCIA e XGO)
-- Due carte differenti ma con lo stesso codice, due politiche di punti differenti nello stesso record
CREATE TABLE FIDELITY_CARD (
    ID_FIDELITY_CARD INT PRIMARY KEY AUTO_INCREMENT,
    ID_USER_FK INT UNIQUE NOT NULL,
    Code INT UNIQUE NOT NULL,
    -- Punti CF (CartaFRECCIA)
    CF_Status VARCHAR(50) NOT NULL DEFAULT 'Bronzo', -- Status dell'utente
    CF_StatusPoints FLOAT DEFAULT 0, -- Punti status necessari per passare da uno status inferiore ad uno successivo
    CF_PrizePoints FLOAT DEFAULT 0, -- Punti premio accumulati acquistando viaggi, da utilizzare per ottenere premi
    CF_StatusPoints_ExpireDate DATE NOT NULL, -- Scadenza dei punti status (se non maturato lo status successivo entro tale data si azzerano e si rimane allo status precedente)
    CF_PrizePoints_ExpireDate DATE NOT NULL, -- Scadenza dei punti premio
    -- Punti XGO
    XGO_Points FLOAT DEFAULT 0,
    XGO_Points_ExpireDate DATE NOT NULL,
    
    FOREIGN KEY (ID_USER_FK) 
        REFERENCES USER(ID_USER)
        ON DELETE CASCADE -- Se l'utente è cancellato, la carta fedeltà viene cancellata
);

-- Entità: DISCOUNT_COUPON
-- Codici sconto da inserire in fase di pagamento
CREATE TABLE DISCOUNT_COUPON (
    ID_DISCOUNT_COUPON INT PRIMARY KEY AUTO_INCREMENT,
    Code VARCHAR(50) UNIQUE NOT NULL,
    Value DECIMAL(10, 2) NOT NULL,
    Valid_From DATE NOT NULL,
    Valid_To DATE NOT NULL
);

-- Entità: GIFT_COUPON
-- Buoni regalo da inserire in fase di pagamento
CREATE TABLE GIFT_COUPON (
    ID_GIFT_COUPON INT PRIMARY KEY AUTO_INCREMENT,
    Antifraud_Code VARCHAR(50) UNIQUE NOT NULL, -- Codice antifrode da inserire per validare il coupon
    Value DECIMAL(10, 2) NOT NULL
);

-- Entità di congiunzione per l'associazione N:M tra DISCOUNT_COUPON e VEHICLE_TYPE
-- Definisce quali tipologie di veicolo possono accettare un determinato sconto
CREATE TABLE DISCOUNT_VEHICLE_TYPE_ASSOCIATION (
    ID_DISCOUNT_COUPON_FK INT NOT NULL,
    ID_VEHICLE_TYPE_FK INT NOT NULL,
    
    PRIMARY KEY (ID_DISCOUNT_COUPON_FK, ID_VEHICLE_TYPE_FK),
    
    FOREIGN KEY (ID_DISCOUNT_COUPON_FK) 
        REFERENCES DISCOUNT_COUPON(ID_DISCOUNT_COUPON)
        ON DELETE CASCADE, 
    FOREIGN KEY (ID_VEHICLE_TYPE_FK) 
        REFERENCES VEHICLE_TYPE(ID_VEHICLE_TYPE)
        ON DELETE RESTRICT
);

-- Entità: RESERVATION 
-- Prenotazione del viaggio comprensivo di tutte le tratte acquistate
CREATE TABLE RESERVATION (
    ID_RESERVATION INT PRIMARY KEY AUTO_INCREMENT,
    PNR_Code VARCHAR(10) NOT NULL UNIQUE, 
    Purchase_Date_Time DATETIME NOT NULL,
    Status VARCHAR(20) NOT NULL, 
    Total_Price DECIMAL(10, 2) NOT NULL,
    
    ID_USER_FK INT NOT NULL, -- Chi ha effettuato l'acquisto
    ID_DISCOUNT_COUPON_FK INT UNIQUE, -- Relazione 1:1 (un coupon per una prenotazione)
    ID_GIFT_COUPON_FK INT UNIQUE, -- Relazione 1:1 (un gift coupon per una prenotazione)
    
    FOREIGN KEY (ID_USER_FK) 
        REFERENCES USER(ID_USER)
        ON DELETE RESTRICT,
    FOREIGN KEY (ID_DISCOUNT_COUPON_FK) 
        REFERENCES DISCOUNT_COUPON(ID_DISCOUNT_COUPON)
        ON DELETE RESTRICT,
    FOREIGN KEY (ID_GIFT_COUPON_FK) 
        REFERENCES GIFT_COUPON(ID_GIFT_COUPON)
        ON DELETE RESTRICT
);

-- Entità: PASSENGER
-- Il passeggero del viaggio, che può essere diverso dallo User
CREATE TABLE PASSENGER (
    ID_PASSENGER INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Surname VARCHAR(100) NOT NULL,
    Cell VARCHAR(16),
    Email VARCHAR(150) NOT NULL,
    
    ID_FIDELITY_CARD_FK INT UNIQUE,
    
    FOREIGN KEY (ID_FIDELITY_CARD_FK) 
        REFERENCES FIDELITY_CARD(ID_FIDELITY_CARD)
        ON DELETE RESTRICT
);

-- Entità: TICKET 
-- Il dettaglio del viaggio: congiunge tutte le transazioni e i dati di viaggio
CREATE TABLE TICKET (
    ID_TICKET INT PRIMARY KEY AUTO_INCREMENT,
    
    ID_RESERVATION_FK INT NOT NULL,
    ID_PASSENGER_FK INT NOT NULL,
    
    FOREIGN KEY (ID_RESERVATION_FK) 
        REFERENCES RESERVATION(ID_RESERVATION)
        ON DELETE CASCADE, -- Se la prenotazione è cancellata, il ticket è cancellato
    FOREIGN KEY (ID_PASSENGER_FK)
        REFERENCES PASSENGER(ID_PASSENGER)
        ON DELETE RESTRICT 
);

-- Entità: VEHICLE
-- Rappresenta i diversi veicoli del sistema di trasporto
CREATE TABLE VEHICLE (
    ID_VEHICLE INT PRIMARY KEY AUTO_INCREMENT,
    Number VARCHAR(20) NOT NULL UNIQUE,
    Company VARCHAR(100) NOT NULL, -- es. Trenitalia, TPER
    Capacity INT, 
    Has_Bike_Space BOOLEAN DEFAULT FALSE,
    Has_Seat_Choice BOOLEAN DEFAULT FALSE, -- Alcuni veicoli potrebbero non permettere la scelta del posto
    ID_VEHICLE_TYPE_FK INT NOT NULL,
    
    FOREIGN KEY (ID_VEHICLE_TYPE_FK) 
        REFERENCES VEHICLE_TYPE(ID_VEHICLE_TYPE)
        ON DELETE RESTRICT
);

-- Entità di congiunzione per l'associazione N:M tra VEHICLE_TYPE e CLASS
CREATE TABLE VEHICLE_TYPE_CLASS_ASSOCIATION (
    ID_VEHICLE_TYPE_FK INT NOT NULL,
    ID_CLASS_FK INT NOT NULL,
    
    PRIMARY KEY (ID_VEHICLE_TYPE_FK, ID_CLASS_FK),
    
    FOREIGN KEY (ID_VEHICLE_TYPE_FK) 
        REFERENCES VEHICLE_TYPE(ID_VEHICLE_TYPE)
        ON DELETE CASCADE, 
    FOREIGN KEY (ID_CLASS_FK) 
        REFERENCES CLASS(ID_CLASS)
        ON DELETE RESTRICT
);

-- Entità: CARRIAGE
-- Rappresenta le diverse carrozze presenti sul veicolo
CREATE TABLE CARRIAGE (
    ID_CARRIAGE INT PRIMARY KEY AUTO_INCREMENT,
    Number INT NOT NULL, 
    ID_VEHICLE_FK INT NOT NULL,
    ID_CLASS_FK INT NOT NULL,
    
    UNIQUE KEY (ID_VEHICLE_FK, Number), 
    
    FOREIGN KEY (ID_VEHICLE_FK) 
        REFERENCES VEHICLE(ID_VEHICLE)
        ON DELETE CASCADE, 
    FOREIGN KEY (ID_CLASS_FK)
        REFERENCES CLASS(ID_CLASS)
        ON DELETE RESTRICT
);

-- Entità: SEAT
-- Rappresenta i diversi posti presenti nella carrozza
CREATE TABLE SEAT (
    ID_SEAT INT PRIMARY KEY AUTO_INCREMENT,
    Code VARCHAR(10) NOT NULL, 
    Orientation VARCHAR(20), -- In quale senso è orientato il posto (es. senso di marcia), da utilizzare per una visualizzazione grafica del posto sul sito
    Position VARCHAR(20), -- Es. corridoio o finestrino
    ID_CARRIAGE_FK INT NOT NULL,
    
    UNIQUE KEY (ID_CARRIAGE_FK, Code), 
    
    FOREIGN KEY (ID_CARRIAGE_FK) 
        REFERENCES CARRIAGE(ID_CARRIAGE)
        ON DELETE CASCADE 
);

-- Entità: ROUTE
-- La tratta
CREATE TABLE ROUTE (
    ID_ROUTE INT PRIMARY KEY AUTO_INCREMENT,
    Departure_Date_Time DATETIME NOT NULL,
    Arrival_Date_Time DATETIME NOT NULL,
    
    ID_VEHICLE_FK INT NOT NULL,
    ID_DEPARTURE_STATION_FK INT NOT NULL,
    ID_ARRIVAL_STATION_FK INT NOT NULL,
    
    FOREIGN KEY (ID_VEHICLE_FK) 
        REFERENCES VEHICLE(ID_VEHICLE)
        ON DELETE RESTRICT,
    FOREIGN KEY (ID_DEPARTURE_STATION_FK) 
        REFERENCES STATION(ID_STATION)
        ON DELETE RESTRICT,
    FOREIGN KEY (ID_ARRIVAL_STATION_FK) 
        REFERENCES STATION(ID_STATION)
        ON DELETE RESTRICT
);

-- Tabella che risolve il problema delle tratte multiple (scali) collegando le entità TICKET e ROUTE (relazione N:M)
CREATE TABLE TICKET_SEGMENT (
    ID_TICKET_SEGMENT INT PRIMARY KEY AUTO_INCREMENT,
    ID_TICKET_FK INT NOT NULL, 
    ID_ROUTE_FK INT NOT NULL,
    ID_SEAT_FK INT,

    UNIQUE KEY (ID_ROUTE_FK, ID_SEAT_FK), -- Un posto in una tratta non può essere assegnato due volte

    FOREIGN KEY (ID_TICKET_FK) 
        REFERENCES TICKET(ID_TICKET)
        ON DELETE CASCADE, -- Se il ticket è cancellato, il segmento è cancellato
    FOREIGN KEY (ID_ROUTE_FK) 
        REFERENCES ROUTE(ID_ROUTE)
        ON DELETE RESTRICT,
    FOREIGN KEY (ID_SEAT_FK)
        REFERENCES SEAT(ID_SEAT)
        ON DELETE RESTRICT
);

-- Entità: PRICE 
-- Definisce il prezzo base per la combinazione di tratta, classe e offerta
CREATE TABLE PRICE (
    ID_ROUTE_FK INT NOT NULL,
    ID_CLASS_FK INT NOT NULL,
    ID_OFFER_FK INT NOT NULL,
    Base_Price DECIMAL(10, 2) NOT NULL,
    
    PRIMARY KEY (ID_ROUTE_FK, ID_CLASS_FK, ID_OFFER_FK),
    
    FOREIGN KEY (ID_ROUTE_FK) 
        REFERENCES ROUTE(ID_ROUTE)
        ON DELETE CASCADE,
    FOREIGN KEY (ID_CLASS_FK) 
        REFERENCES CLASS(ID_CLASS)
        ON DELETE RESTRICT,
    FOREIGN KEY (ID_OFFER_FK) 
        REFERENCES OFFER(ID_OFFER)
        ON DELETE RESTRICT
);