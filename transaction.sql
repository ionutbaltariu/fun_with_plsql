CREATE OR REPLACE PACKAGE transactions
IS
    PROCEDURE CREATE_CLIENT_W_APPOINTMENT(p_first_name clients.first_name%TYPE,
                                         p_last_name clients.last_name%TYPE,
                                         p_email clients.e_mail%TYPE,
                                         p_account_credits clients.account_credits%TYPE,
                                         p_cnp identity_cards.cnp%TYPE,
                                         p_series identity_cards.series%TYPE,
                                         p_number identity_cards."number"%TYPE,
                                         p_computer_id computers.computer_id_pk%TYPE,
                                         p_start_time appointments.start_time%TYPE,
                                         p_end_time appointments.end_time%TYPE);
END transactions;


CREATE OR REPLACE PACKAGE BODY transactions
IS
    PROCEDURE CREATE_CLIENT_W_APPOINTMENT(p_first_name clients.first_name%TYPE,
                                     p_last_name clients.last_name%TYPE,
                                     p_email clients.e_mail%TYPE,
                                     p_account_credits clients.account_credits%TYPE,
                                     p_cnp identity_cards.cnp%TYPE,
                                     p_series identity_cards.series%TYPE,
                                     p_number identity_cards."number"%TYPE,
                                     p_computer_id computers.computer_id_pk%TYPE,
                                     p_start_time appointments.start_time%TYPE,
                                     p_end_time appointments.end_time%TYPE)
    IS
    v_client_id clients.user_id_pk%TYPE;
    v_identity_card_id identity_cards.id%TYPE;
    BEGIN
        savepoint from_start;
        identity_card_crud.add_identity_card(p_cnp, p_series, p_number);

        SELECT id INTO v_identity_card_id FROM identity_cards WHERE cnp = p_cnp;

        client_crud.add_client(p_first_name, p_last_name, p_email, SYSDATE, p_account_credits, v_identity_card_id);

        SELECT user_id_pk INTO v_client_id FROM clients WHERE first_name = p_first_name and last_name = p_last_name;

--        first appointment is free
        appointment_crud.add_appointment(p_computer_id, v_client_id, SYSDATE, p_start_time, p_end_time, 0);

    EXCEPTION
        WHEN DUP_VAL_ON_INDEX
            THEN dbms_output.put_line('There are multiple values with [..]');
        WHEN Others THEN
            dbms_output.put_line('Transaction failed: '|| SQLERRM);
            ROLLBACK to from_start;
    END CREATE_CLIENT_W_APPOINTMENT;
END transactions;