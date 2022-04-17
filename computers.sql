CREATE OR REPLACE PACKAGE computer_crud
IS
    PROCEDURE ADD_COMPUTER(p_room_id computers.room_fk%TYPE,
                           p_computer_cfg_id computers.computer_cfg_id_pk%TYPE);
    PROCEDURE UPD_COMPUTER_ROOM(p_computer_id computers.computer_id_pk%TYPE,
                                p_room_id computers.room_fk%TYPE);
    PROCEDURE UPD_COMPUTER_CFG_ID(p_computer_id computers.computer_id_pk%TYPE,
                                  p_computer_cfg_id computers.computer_cfg_id_pk%TYPE);
    PROCEDURE DEL_COMPUTER(p_computer_id computers.computer_id_pk%TYPE);
END computer_crud;


CREATE OR REPLACE PACKAGE BODY computer_crud
IS
    PROCEDURE ADD_COMPUTER(p_room_id computers.room_fk%TYPE,
                           p_computer_cfg_id computers.computer_cfg_id_pk%TYPE)
                           IS
    BEGIN
        INSERT INTO computers values(NULL, p_room_id, p_computer_cfg_id);
    EXCEPTION
          WHEN DUP_VAL_ON_INDEX
            THEN dbms_output.put_line('There are multiple values with [..]');
    END ADD_COMPUTER;

    PROCEDURE UPD_COMPUTER_ROOM(p_computer_id computers.computer_id_pk%TYPE,
                                p_room_id computers.room_fk%TYPE)
                                IS
    e_exp EXCEPTION;
    BEGIN
        UPDATE computers SET room_fk=p_room_id WHERE computer_id_pk = p_computer_id;
        IF SQL%ROWCOUNT = 0 THEN RAISE e_exp;
        END IF;
    EXCEPTION
        WHEN e_exp THEN dbms_output.put_line('There is no computer with the given id.');
    END UPD_COMPUTER_ROOM;

    PROCEDURE UPD_COMPUTER_CFG_ID(p_computer_id computers.computer_id_pk%TYPE,
                                  p_computer_cfg_id computers.computer_cfg_id_pk%TYPE)
                                  IS
    e_exp EXCEPTION;
    BEGIN
        UPDATE computers SET computer_cfg_id_pk=p_computer_cfg_id WHERE computer_id_pk = p_computer_id;
        IF SQL%ROWCOUNT = 0 THEN RAISE e_exp;
        END IF;
    EXCEPTION
        WHEN e_exp THEN dbms_output.put_line('There is no computer with the given id.');
    END UPD_COMPUTER_CFG_ID;


    PROCEDURE DEL_COMPUTER(p_computer_id computers.computer_id_pk%TYPE) IS
    e_exp EXCEPTION;
    BEGIN
        DELETE FROM computers WHERE computer_id_pk = p_computer_id;
        IF SQL%ROWCOUNT = 0 THEN RAISE e_exp;
        END IF;
    EXCEPTION
        WHEN e_exp THEN dbms_output.put_line('There is no computer with the given id.');
    END DEL_COMPUTER;
END computer_crud;