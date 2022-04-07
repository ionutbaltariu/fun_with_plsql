CREATE OR REPLACE PROCEDURE ADD_IDENTITY_CARD(p_cnp identity_cards.cnp%TYPE, p_series identity_cards.series%TYPE, p_number identity_cards."number"%TYPE) IS
BEGIN
    INSERT INTO IDENTITY_CARDS(CNP, SERIES, "number") VALUES(p_cnp, p_series, p_number);
EXCEPTION
      WHEN DUP_VAL_ON_INDEX
        THEN dbms_output.put_line('There are multiple values with [..]');
      WHEN OTHERS THEN dbms_output.put_line('An unexpected error occured');
END ADD_IDENTITY_CARD;

CREATE OR REPLACE PROCEDURE UPD_IDENTITY_CARD(p_id identity_cards.id%TYPE, p_cnp identity_cards.cnp%TYPE, p_series identity_cards.series%TYPE, p_number identity_cards."number"%TYPE) IS
e_exp EXCEPTION;
BEGIN
    UPDATE IDENTITY_CARDS SET cnp= p_cnp, series=p_series, "number"=p_number WHERE id = p_id;
    IF SQL%ROWCOUNT = 0 THEN RAISE e_exp;
    END IF;
EXCEPTION
    WHEN e_exp THEN dbms_output.put_line('There is no identity card with the given id.');
    WHEN OTHERS THEN dbms_output.put_line('An unexpected error occured');
END UPD_IDENTITY_CARD;

CREATE OR REPLACE PROCEDURE DEL_IDENTITY_CARD(p_id identity_cards.id%TYPE) IS

--    plsql_compilation_error exception;
--    pragma exception_init(plsql_compilation_error, -6550);
e_exp EXCEPTION;
BEGIN
    DELETE FROM IDENTITY_CARDS WHERE id = p_id;
    IF SQL%ROWCOUNT = 0 THEN RAISE e_exp;
    dbms_output.put_line(SQL%ROWCOUNT);
    END IF;
EXCEPTION
    WHEN e_exp THEN dbms_output.put_line('There is no identity card with the given id.');
    WHEN OTHERS THEN dbms_output.put_line('An unexpected error occured');
END DEL_IDENTITY_CARD;

BEGIN
    ADD_IDENTITY_CARD('500053107368','XT',837323);
--    UPD_IDENTITY_CARD(7,'5','X',1);
--    DEL_IDENTITY_CARD(7);
END;


SELECT * FROM IDENTITY_CARDS;
DELETE FROM IDENTITY_CARDS WHERE 1=1;