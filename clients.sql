CREATE OR REPLACE PACKAGE client_crud
IS
    PROCEDURE ADD_CLIENT(p_first_name clients.first_name%TYPE,
                         p_last_name clients.last_name%TYPE,
                         p_email clients.e_mail%TYPE,
                         p_registration_date clients.registration_date%TYPE,
                         p_account_credits clients.account_credits%TYPE,
                         p_identity_card_id clients.identity_cards_id%TYPE);
    PROCEDURE UPD_CLIENT_CREDITS(p_client_id clients.user_id_pk%TYPE,
                                 p_account_credits clients.account_credits%TYPE);
    PROCEDURE UPD_CLIENT_EMAIL(p_client_id clients.user_id_pk%TYPE,
                               p_email clients.e_mail%TYPE);
    PROCEDURE DEL_CLIENT(p_client_id clients.user_id_pk%TYPE);
END client_crud;


CREATE OR REPLACE PACKAGE BODY client_crud
IS
    PROCEDURE ADD_CLIENT(p_first_name clients.first_name%TYPE,
                         p_last_name clients.last_name%TYPE,
                         p_email clients.e_mail%TYPE,
                         p_registration_date clients.registration_date%TYPE,
                         p_account_credits clients.account_credits%TYPE,
                         p_identity_card_id clients.identity_cards_id%TYPE)
                         IS
    BEGIN
        INSERT INTO clients values(NULL, p_first_name, p_last_name, p_email, p_registration_date, p_account_credits, NULL, p_identity_card_id);
    EXCEPTION
          WHEN DUP_VAL_ON_INDEX
            THEN dbms_output.put_line('There are multiple values with [..]');
    END ADD_CLIENT;

    PROCEDURE UPD_CLIENT_CREDITS(p_client_id clients.user_id_pk%TYPE,
                                 p_account_credits clients.account_credits%TYPE)
                                 IS
    e_exp EXCEPTION;
    BEGIN
        UPDATE clients SET account_credits=p_account_credits WHERE user_id_pk = p_client_id;
        IF SQL%ROWCOUNT = 0 THEN RAISE e_exp;
        END IF;
    EXCEPTION
        WHEN e_exp THEN dbms_output.put_line('There is no client with the given id.');
    END UPD_CLIENT_CREDITS;

    PROCEDURE UPD_CLIENT_EMAIL(p_client_id clients.user_id_pk%TYPE,
                               p_email clients.e_mail%TYPE)
                               IS
    e_exp EXCEPTION;
    BEGIN
        UPDATE clients SET e_mail=p_email WHERE user_id_pk = p_client_id;
        IF SQL%ROWCOUNT = 0 THEN RAISE e_exp;
        END IF;
    EXCEPTION
        WHEN e_exp THEN dbms_output.put_line('There is no client with the given id.');
    END UPD_CLIENT_EMAIL;

    PROCEDURE DEL_CLIENT(p_client_id clients.user_id_pk%TYPE) IS
    e_exp EXCEPTION;
    BEGIN
        DELETE FROM clients WHERE user_id_pk = p_client_id;
        IF SQL%ROWCOUNT = 0 THEN RAISE e_exp;
        END IF;
    EXCEPTION
        WHEN e_exp THEN dbms_output.put_line('There is no client with the given id.');
    END DEL_CLIENT;
END client_crud;