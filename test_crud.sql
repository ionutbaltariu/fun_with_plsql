CREATE OR REPLACE PACKAGE test_crud
IS
    PROCEDURE push_data;
    PROCEDURE delete_everything;
    PROCEDURE transaction_fails_invalid_cnp;
    PROCEDURE transaction_fails_invalid_times;
    PROCEDURE transaction_fails_invalid_room_name;
    PROCEDURE list_clients;
    PROCEDURE update_client_credits(p_first_name clients.first_name%TYPE, p_last_name clients.last_name%TYPE, p_account_credits clients.account_credits%TYPE);
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

    PROCEDURE update_client_credits(p_first_name clients.first_name%TYPE, p_last_name clients.last_name%TYPE, p_account_credits clients.account_credits%TYPE)
    IS
    v_client_id clients.user_id_pk%TYPE;
    BEGIN
        SELECT user_id_pk into v_client_id FROM clients WHERE first_name = p_first_name and last_name = p_last_name;
        client_crud.upd_client_credits(v_client_id, p_account_credits);
    END;


    PROCEDURE list_clients IS
    c_clients SYS_REFCURSOR;
    client_rec clients%ROWTYPE;
    BEGIN
    OPEN c_clients FOR SELECT  * FROM CLIENTS;
        LOOP
            FETCH c_clients into client_rec;
            EXIT WHEN c_clients%NOTFOUND;
            dbms_output.put_line('First name: ' || client_rec.first_name || ', Last name: ' || client_rec.last_name || ', Email: ' || client_rec.e_mail || ', Credits: ' || client_rec.account_credits);
        END LOOP;
    END;

    PROCEDURE transaction_fails_invalid_room_name IS
        v_room_id rooms.room_id_pk%TYPE;
        v_computer_cfg_id_pk computer_configurations.computer_cfg_id_pk%TYPE;
        v_computer_id computers.computer_id_pk%TYPE;
        c_computers SYS_REFCURSOR;
        computer_rec computers%ROWTYPE;
    BEGIN
        room_crud.add_room('Camera Zeilor', 3);
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
    END;

    PROCEDURE transaction_fails_invalid_times IS
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

        transactions.create_client_w_appointment('Ionut', 'Baltariu', 'alex@yahoo.com', 0, '4000531072361', 'XT', 837321, v_computer_id, TO_DATE('2022/5/17 21:30:01', 'YYYY/MM/DD hh24:MI:SS'),TO_DATE('2022/5/16 22:30:02', 'YYYY/MM/DD hh24:MI:SS'));
    END;

    PROCEDURE transaction_fails_invalid_cnp IS
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

        transactions.create_client_w_appointment('Ionut', 'Baltariu', 'alex@yahoo.com', 0, '4002531072361', 'XT', 837321, v_computer_id, TO_DATE('2022/5/17 21:30:01', 'YYYY/MM/DD hh24:MI:SS'),TO_DATE('2022/5/17 22:30:02', 'YYYY/MM/DD hh24:MI:SS'));
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
            v_computer_id := computer_rec.computer_id_pk;
            EXIT;
        END LOOP;

        transactions.create_client_w_appointment('Ionut', 'Baltariu', 'alex@yahoo.com', 0, '4000531072361', 'XT', 837321, v_computer_id, TO_DATE('2022/5/17 21:30:01', 'YYYY/MM/DD hh24:MI:SS'),TO_DATE('2022/5/17 22:30:02', 'YYYY/MM/DD hh24:MI:SS'));
    END push_data;
END test_crud;

BEGIN
    test_crud.delete_everything;
    test_crud.push_data;
    test_crud.list_clients;
    dbms_output.put_line('first transaction succeeded');
    test_crud.delete_everything;

    test_crud.transaction_fails_invalid_times;
    test_crud.delete_everything;

    test_crud.transaction_fails_invalid_cnp;
    test_crud.delete_everything;

    test_crud.transaction_fails_invalid_times;
    test_crud.delete_everything;

    dbms_output.put_line('Before update:');
    test_crud.push_data;
    test_crud.list_clients;
    dbms_output.put_line('After update:');
    test_crud.update_client_credits('Ionut', 'Baltariu', 123);
    test_crud.list_clients;
END;
