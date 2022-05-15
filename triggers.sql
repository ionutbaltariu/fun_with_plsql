CREATE OR REPLACE TRIGGER appointment_date_validation
BEFORE INSERT OR UPDATE ON appointments
FOR EACH ROW
DECLARE
    rc_app SYS_REFCURSOR;
    app_rec appointments%ROWTYPE;
BEGIN
    IF :new.end_time < :new.start_time
        THEN RAISE_APPLICATION_ERROR(-20502, 'End date must be after start date!');
    ELSIF (TO_CHAR(:new.start_time, 'DY') IN ('SUN')) OR
            (TO_CHAR(:new.end_time, 'DY') IN ('SUN'))
        THEN RAISE_APPLICATION_ERROR(-20503, 'Start or end date might not be on Sunday');
    ELSIF :new.end_time - :new.start_time > 1
        THEN RAISE_APPLICATION_ERROR(-20504, 'Appointments cannot take more than 24 hours');
    END IF;

    OPEN rc_app FOR SELECT  * FROM APPOINTMENTS;
    LOOP
        FETCH rc_app INTO app_rec;
        EXIT WHEN rc_app%NOTFOUND;
        IF (:new.start_time < app_rec.end_time AND :new.start_time > app_rec.start_time)
            THEN RAISE_APPLICATION_ERROR(-20505, 'New appointments cannot overlap with preexistent appointments.');
        END IF;
    END LOOP;
END;

CREATE OR REPLACE TRIGGER room_validation
BEFORE INSERT OR UPDATE ON rooms
FOR EACH ROW
BEGIN
    IF NOT REGEXP_LIKE(:new.name, '.+\sRoom')
        THEN RAISE_APPLICATION_ERROR(-20900, 'A room name must end in "Room"');
    END IF;
END;

CREATE OR REPLACE TRIGGER id_validation
BEFORE INSERT OR UPDATE ON identity_cards
FOR EACH ROW
BEGIN
    IF (SUBSTR(:new.cnp, 1, 1) IN ('0', '9'))
        THEN RAISE_APPLICATION_ERROR(-20999, 'CNP must not begin with 0 or 9');
    ELSIF (SUBSTR(:new.cnp, 4, 1) NOT IN ('0', '1'))
        THEN
            RAISE_APPLICATION_ERROR(-20999, 'Invalid CNP. Check the month of birth.');
    ELSIF (SUBSTR(:new.cnp, 4, 1) = '1') AND (SUBSTR(:new.cnp, 5, 1) NOT IN ('0', '1', '2'))
        THEN RAISE_APPLICATION_ERROR(-20999, 'Invalid CNP. Check the month of birth.');
    END IF;
END;