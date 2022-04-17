CREATE OR REPLACE PACKAGE feedback_crud
IS
    PROCEDURE ADD_FEEDBACK(p_client_id feedbacks.client_fk%TYPE,
                           p_message feedbacks.message%TYPE);
    PROCEDURE UPD_FEEDBACK_MESSAGE(p_feedback_id feedbacks.feedbacks_pk%TYPE,
                                   p_message feedbacks.message%TYPE);
    PROCEDURE DEL_FEEDBACK(p_feedback_id feedbacks.feedbacks_pk%TYPE);
END feedback_crud;


CREATE OR REPLACE PACKAGE BODY feedback_crud
IS
    PROCEDURE ADD_FEEDBACK(p_client_id feedbacks.client_fk%TYPE,
                           p_message feedbacks.message%TYPE)
                           IS
    BEGIN
        INSERT INTO feedbacks values(NULL, p_client_id, p_message, SYSDATE);
    EXCEPTION
          WHEN DUP_VAL_ON_INDEX
            THEN dbms_output.put_line('There are multiple values with [..]');
    END ADD_FEEDBACK;

    PROCEDURE UPD_FEEDBACK_MESSAGE(p_feedback_id feedbacks.feedbacks_pk%TYPE,
                                   p_message feedbacks.message%TYPE)
                                   IS
    e_exp EXCEPTION;
    BEGIN
        UPDATE feedbacks SET message=p_message WHERE feedbacks_pk = p_feedback_id;
        IF SQL%ROWCOUNT = 0 THEN RAISE e_exp;
        END IF;
    EXCEPTION
        WHEN e_exp THEN dbms_output.put_line('There is no client with the given id.');
    END UPD_FEEDBACK_MESSAGE;

    PROCEDURE DEL_FEEDBACK(p_feedback_id feedbacks.feedbacks_pk%TYPE) IS
    e_exp EXCEPTION;
    BEGIN
        DELETE FROM feedbacks WHERE feedbacks_pk = p_feedback_id;
        IF SQL%ROWCOUNT = 0 THEN RAISE e_exp;
        END IF;
    EXCEPTION
        WHEN e_exp THEN dbms_output.put_line('There is no client with the given id.');
    END DEL_FEEDBACK;
END feedback_crud;