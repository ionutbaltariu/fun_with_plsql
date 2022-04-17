CREATE OR REPLACE PACKAGE room_crud
IS
  PROCEDURE ADD_ROOM(p_name rooms.name%TYPE, p_number_of_computers rooms.number_of_computers%TYPE);
  PROCEDURE UPD_ROOM_NAME(p_room_id rooms.room_id_pk%TYPE, p_name rooms.name%TYPE);
  PROCEDURE UPD_ROOM_COMPUTER_NUMBER(p_room_id rooms.room_id_pk%TYPE,
                                     p_number_of_computers rooms.number_of_computers%TYPE);
    PROCEDURE DEL_ROOM(p_room_id rooms.room_id_pk%TYPE);
END room_crud;


CREATE OR REPLACE PACKAGE BODY room_crud
IS
    PROCEDURE ADD_ROOM(p_name rooms.name%TYPE,
                       p_number_of_computers rooms.number_of_computers%TYPE)
                       IS
    BEGIN
        INSERT INTO rooms values(NULL, p_name, p_number_of_computers);
    EXCEPTION
          WHEN DUP_VAL_ON_INDEX
            THEN dbms_output.put_line('There are multiple values with [..]');
    END ADD_ROOM;

    PROCEDURE UPD_ROOM_NAME(p_room_id rooms.room_id_pk%TYPE,
                                              p_name rooms.name%TYPE)
                                              IS
    e_exp EXCEPTION;
    BEGIN
        UPDATE rooms SET name=p_name WHERE room_id_pk = p_room_id;
        IF SQL%ROWCOUNT = 0 THEN RAISE e_exp;
        END IF;
    EXCEPTION
        WHEN e_exp THEN dbms_output.put_line('There is no client with the given id.');
    END UPD_ROOM_NAME;

    PROCEDURE UPD_ROOM_COMPUTER_NUMBER(p_room_id rooms.room_id_pk%TYPE,
                                       p_number_of_computers rooms.number_of_computers%TYPE)
                                       IS
    e_exp EXCEPTION;
    BEGIN
        UPDATE rooms SET number_of_computers=p_number_of_computers WHERE room_id_pk = p_room_id;
        IF SQL%ROWCOUNT = 0 THEN RAISE e_exp;
        END IF;
    EXCEPTION
        WHEN e_exp THEN dbms_output.put_line('There is no client with the given id.');
    END UPD_ROOM_COMPUTER_NUMBER;

    PROCEDURE DEL_ROOM(p_room_id rooms.room_id_pk%TYPE) IS
    e_exp EXCEPTION;
    BEGIN
        DELETE FROM rooms WHERE room_id_pk = p_room_id;
        IF SQL%ROWCOUNT = 0 THEN RAISE e_exp;
        END IF;
    EXCEPTION
        WHEN e_exp THEN dbms_output.put_line('There is no client with the given id.');
    END DEL_ROOM;
END room_crud;