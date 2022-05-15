set serveroutput on;

CREATE OR REPLACE PACKAGE test_crud
IS
    PROCEDURE push_data;
    PROCEDURE delete_everything;
    PROCEDURE transaction_fails_invalid_cnp;
    PROCEDURE transaction_fails_invalid_times;
    PROCEDURE transaction_fails_invalid_room_name;
END test_crud;

CREATE OR REPLACE PACKAGE BODY test_crud
IS
    PROCEDURE delete_everything IS
    BEGIN
        DELETE FROM appointments WHERE 1=1;
        DELETE FROM computers WHERE 1=1;
        DELETE FROM rooms WHERE 1=1;
        DELETE FROM computer_configurations WHERE 1=1;
        DELETE FROM identity_cards WHERE 1=1;
        DELETE FROM feedbacks WHERE 1=1;
        DELETE  FROM clients WHERE 1=1;
    END;

    PROCEDURE push_data IS
    v_room_id rooms.room_id_pk%TYPE;
    v_computer_cfg_id_pk computer_configurations.computer_cfg_id_pk%TYPE;
    v_computer_id computers.computer_id_pk%TYPE;
    c_computers SYS_REFCURSOR;
    computer_rec computers%ROWTYPE;

    BEGIN
        room_crud.add_room('Gods Room', 3);
        SELECT room_id_pk INTO v_room_id FROM rooms WHERE name = 'Gods Room';

        computer_cfg_crud.add_computer_cfg('Intel i9', 'GTX 3060', '32 GB', 'DELL', 'Razer', 'Razer');
        SELECT computer_cfg_id_pk INTO v_computer_cfg_id_pk FROM computer_configurations WHERE cpu = 'Intel i9';

        computer_crud.add_computer(v_room_id, v_computer_cfg_id_pk);
        computer_crud.add_computer(v_room_id, v_computer_cfg_id_pk);
        computer_crud.add_computer(v_room_id, v_computer_cfg_id_pk);

        OPEN c_computers FOR SELECT  * FROM COMPUTERS;
        LOOP
            FETCH c_computers into computer_rec;
            dbms_output.put_line(computer_rec.computer_id_pk);
            v_computer_id := computer_rec.computer_id_pk;
            EXIT;
        END LOOP;

        transactions.create_client_w_appointment('Ionut', 'Baltariu', 'alex@yahoo.com', 0, '4000531072361', 'XT', 837321, v_computer_id, TO_DATE('2022/5/17 21:30:01', 'YYYY/MM/DD hh24:MI:SS'),TO_DATE('2022/5/17 22:30:02', 'YYYY/MM/DD hh24:MI:SS'));
    END push_data;
END test_crud;