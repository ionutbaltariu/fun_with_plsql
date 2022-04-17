CREATE OR REPLACE PACKAGE appointment_crud
IS
    PROCEDURE ADD_APPOINTMENT(p_computer_id appointments.computer_id%TYPE,
                              p_client_id appointments.client_id%TYPE,
                              p_appointment_date appointments.appointment_date%TYPE,
                              p_start_time appointments.start_time%TYPE,
                              p_end_time appointments.end_time%TYPE,
                              p_price appointments.price%TYPE);
    PROCEDURE UPD_APPOINTMENT_COMPUTER(p_appointment_id appointments.appointment_id%TYPE,
                                       p_computer_id appointments.computer_id%TYPE);
    PROCEDURE UPD_APPOINTMENT_END_TIME(p_appointment_id appointments.appointment_id%TYPE,
                                       p_end_time appointments.end_time%TYPE);
    PROCEDURE UPD_APPOINTMENT_PRICE(p_appointment_id appointments.appointment_id%TYPE,
                                    p_price appointments.price%TYPE);
    PROCEDURE DEL_APPOINTMENT(p_appointment_id appointments.appointment_id%TYPE);
END appointment_crud;


CREATE OR REPLACE PACKAGE BODY appointment_crud
IS
    PROCEDURE ADD_APPOINTMENT(p_computer_id appointments.computer_id%TYPE,
                              p_client_id appointments.client_id%TYPE,
                              p_appointment_date appointments.appointment_date%TYPE,
                              p_start_time appointments.start_time%TYPE,
                              p_end_time appointments.end_time%TYPE,
                              p_price appointments.price%TYPE)
                              IS
    BEGIN
        INSERT INTO appointments values(NULL, p_computer_id, p_client_id, p_appointment_date, p_start_time, p_end_time, p_price);
    EXCEPTION
          WHEN DUP_VAL_ON_INDEX
            THEN dbms_output.put_line('There are multiple values with [..]');
    END ADD_APPOINTMENT;

    PROCEDURE UPD_APPOINTMENT_COMPUTER(p_appointment_id appointments.appointment_id%TYPE,
                                       p_computer_id appointments.computer_id%TYPE)
                                       IS
    e_exp EXCEPTION;
    BEGIN
        UPDATE appointments SET computer_id = p_computer_id WHERE appointment_id = p_appointment_id;
        IF SQL%ROWCOUNT = 0 THEN RAISE e_exp;
        END IF;
    EXCEPTION
        WHEN e_exp THEN dbms_output.put_line('There is no appointment with the given id.');
    END UPD_APPOINTMENT_COMPUTER;

    PROCEDURE UPD_APPOINTMENT_START_TIME(p_appointment_id appointments.appointment_id%TYPE,
                                         p_start_time appointments.start_time%TYPE)
                                         IS
    e_exp EXCEPTION;
    BEGIN
        UPDATE appointments SET start_time = p_start_time WHERE appointment_id = p_appointment_id;
        IF SQL%ROWCOUNT = 0 THEN RAISE e_exp;
        END IF;
    EXCEPTION
        WHEN e_exp THEN dbms_output.put_line('There is no appointment with the given id.');
    END UPD_APPOINTMENT_START_TIME;

    PROCEDURE UPD_APPOINTMENT_END_TIME(p_appointment_id appointments.appointment_id%TYPE,
                                       p_end_time appointments.end_time%TYPE)
                                       IS
    e_exp EXCEPTION;
    BEGIN
        UPDATE appointments SET end_time = p_end_time WHERE appointment_id = p_appointment_id;
        IF SQL%ROWCOUNT = 0 THEN RAISE e_exp;
        END IF;
    EXCEPTION
        WHEN e_exp THEN dbms_output.put_line('There is no appointment with the given id.');
    END UPD_APPOINTMENT_END_TIME;

    PROCEDURE UPD_APPOINTMENT_PRICE(p_appointment_id appointments.appointment_id%TYPE,
                                    p_price appointments.price%TYPE)
                                    IS
    e_exp EXCEPTION;
    BEGIN
        UPDATE appointments SET price = p_price WHERE appointment_id = p_appointment_id;
        IF SQL%ROWCOUNT = 0 THEN RAISE e_exp;
        END IF;
    EXCEPTION
        WHEN e_exp THEN dbms_output.put_line('There is no appointment with the given id.');
    END UPD_APPOINTMENT_PRICE;


    PROCEDURE DEL_APPOINTMENT(p_appointment_id appointments.appointment_id%TYPE) IS
    e_exp EXCEPTION;
    BEGIN
        DELETE FROM appointments WHERE appointment_id = p_appointment_id;
        IF SQL%ROWCOUNT = 0 THEN RAISE e_exp;
        END IF;
    EXCEPTION
        WHEN e_exp THEN dbms_output.put_line('There is no computer with the given id.');
    END DEL_APPOINTMENT;

END appointment_crud;