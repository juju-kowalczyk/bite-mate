CREATE DATABASE IF NOT EXISTS bitemate;
USE bitemate;

-- address
CREATE TABLE address (
                         id                 INT AUTO_INCREMENT NOT NULL,
                         street_type        VARCHAR(20),
                         street             VARCHAR(80),
                         house_number       CHAR(5),
                         flat_number        CHAR(5),
                         city               VARCHAR(80),
                         zipcode            VARCHAR(10),
                         country_code       CHAR(3),
                         is_billing         BOOLEAN NOT NULL,
                         restaurant_id      INT NOT NULL,
                         billing_info_id    INT NOT NULL,
                         restaurant_unit_id INT NOT NULL,
                         PRIMARY KEY (id),
                         UNIQUE INDEX address_idx (restaurant_id)
);

-- billing_info
CREATE TABLE billing_info (
                              id            INT AUTO_INCREMENT NOT NULL,
                              name          VARCHAR(100) NOT NULL,
                              tax_number    VARCHAR(15) NOT NULL,
                              restaurant_id INT NOT NULL,
                              PRIMARY KEY (id),
                              UNIQUE INDEX billing_info_idx (restaurant_id)
);

-- patron
CREATE TABLE patron (
                        id           INT AUTO_INCREMENT NOT NULL,
                        name         VARCHAR(80) NOT NULL,
                        email        VARCHAR(80) NOT NULL,
                        phone        VARCHAR(15),
                        PRIMARY KEY (id)
);

-- purchase
CREATE TABLE purchase (
                          id                 INT AUTO_INCREMENT NOT NULL,
                          `DATE`             DATE NOT NULL,
                          restaurant_unit_id INT NOT NULL,
                          purchase_status_id INT NOT NULL,
                          PRIMARY KEY (id)
);

-- purchase_status
CREATE TABLE purchase_status (
                                 id   INT AUTO_INCREMENT NOT NULL,
                                 name VARCHAR(25) NOT NULL,
                                 PRIMARY KEY (id)
);

-- restaurant
CREATE TABLE restaurant (
                            id            INT AUTO_INCREMENT NOT NULL,
                            name          VARCHAR(80) NOT NULL,
                            description   VARCHAR(80),
                            logo_filename VARCHAR(100),
                            active        BOOLEAN NOT NULL,
                            phone         VARCHAR(15),
                            email         VARCHAR(80),
                            patron_id     INT NOT NULL,
                            PRIMARY KEY (id)
);

-- restaurant_unit
CREATE TABLE restaurant_unit (
                                 id            INT AUTO_INCREMENT NOT NULL,
                                 name          VARCHAR(80) NOT NULL,
                                 description   VARCHAR(80),
                                 logo_filename VARCHAR(100),
                                 active        BOOLEAN NOT NULL,
                                 phone         VARCHAR(15),
                                 email         VARCHAR(80),
                                 type          VARCHAR(20),
                                 restaurant_id INT NOT NULL,
                                 PRIMARY KEY (id)
);

-- subscription
CREATE TABLE subscription (
                              id          INT AUTO_INCREMENT NOT NULL,
                              name        VARCHAR(20) NOT NULL,
                              description VARCHAR(120),
                              price       DECIMAL(5,2) NOT NULL,
                              price_per_month DECIMAL(5,2) NOT NULL,
                              months      TINYINT NOT NULL,
                              `DATE`      DATE,
                              PRIMARY KEY (id)
);

-- subscription_plan
CREATE TABLE subscription_plan (
                                   id                 INT AUTO_INCREMENT NOT NULL,
                                   date_from          DATE NOT NULL,
                                   active             BOOLEAN NOT NULL,
                                   restaurant_unit_id INT NOT NULL,
                                   subscription_id    INT NOT NULL,
                                   PRIMARY KEY (id)
);

-- user
CREATE TABLE user (
                      id                 INT AUTO_INCREMENT NOT NULL,
                      email              VARCHAR(80) NOT NULL UNIQUE,
                      password_hash      VARCHAR(255) NOT NULL,
                      restaurant_unit_id INT NOT NULL,
                      PRIMARY KEY (id)
);

-- user_session
CREATE TABLE user_session (
                              id              INT AUTO_INCREMENT NOT NULL,
                              user_id         INT NOT NULL,
                              token           VARCHAR(255) NOT NULL,
                              expiration_time TIMESTAMP NOT NULL,
                              active          BOOLEAN NOT NULL,
                              PRIMARY KEY (id)
);

-- klucze obce
ALTER TABLE address
    ADD CONSTRAINT address_billing_info_fk FOREIGN KEY (billing_info_id)
        REFERENCES billing_info (id);

ALTER TABLE address
    ADD CONSTRAINT address_restaurant_fk FOREIGN KEY (restaurant_id)
        REFERENCES restaurant (id);

ALTER TABLE address
    ADD CONSTRAINT address_restaurant_unit_fk FOREIGN KEY (restaurant_unit_id)
        REFERENCES restaurant_unit (id);

ALTER TABLE billing_info
    ADD CONSTRAINT billing_info_restaurant_fk FOREIGN KEY (restaurant_id)
        REFERENCES restaurant (id);

ALTER TABLE purchase
    ADD CONSTRAINT purchase_purchase_status_fk FOREIGN KEY (purchase_status_id)
        REFERENCES purchase_status (id);

ALTER TABLE purchase
    ADD CONSTRAINT purchase_restaurant_unit_fk FOREIGN KEY (restaurant_unit_id)
        REFERENCES restaurant_unit (id);

ALTER TABLE restaurant
    ADD CONSTRAINT restaurant_patron_fk FOREIGN KEY (patron_id)
        REFERENCES patron (id);

ALTER TABLE restaurant_unit
    ADD CONSTRAINT restaurant_unit_restaurant_fk FOREIGN KEY (restaurant_id)
        REFERENCES restaurant (id);

ALTER TABLE subscription_plan
    ADD CONSTRAINT subscription_plan_restaurant_unit_fk FOREIGN KEY (restaurant_unit_id)
        REFERENCES restaurant_unit (id);

ALTER TABLE subscription_plan
    ADD CONSTRAINT subscription_plan_subscription_fk FOREIGN KEY (subscription_id)
        REFERENCES subscription (id);

ALTER TABLE user
    ADD CONSTRAINT user_restaurant_unit_fk FOREIGN KEY (restaurant_unit_id)
        REFERENCES restaurant_unit (id);

ALTER TABLE user_session
    ADD CONSTRAINT user_session_user_fk FOREIGN KEY (user_id)
        REFERENCES user (id);
