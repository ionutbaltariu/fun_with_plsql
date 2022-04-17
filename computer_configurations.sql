CREATE OR REPLACE PACKAGE computer_cfg_crud
IS
    PROCEDURE ADD_COMPUTER_CFG(p_cpu computer_configurations.cpu%TYPE,
                               p_gpu computer_configurations.gpu%TYPE,
                               p_ram computer_configurations.ram%TYPE,
                               p_monitor computer_configurations.monitor%TYPE,
                               p_mouse computer_configurations.mouse%TYPE,
                             p_keyboard computer_configurations.keyboard%TYPE);
    PROCEDURE UPD_COMPUTER_CFG_CPU(p_computer_cfg_id computer_configurations.computer_cfg_id_pk%TYPE,
                                   p_cpu computer_configurations.cpu%TYPE);
    PROCEDURE UPD_COMPUTER_CFG_GPU(p_computer_cfg_id computer_configurations.computer_cfg_id_pk%TYPE,
                                   p_gpu computer_configurations.gpu%TYPE);
    PROCEDURE UPD_COMPUTER_CFG_RAM(p_computer_cfg_id computer_configurations.computer_cfg_id_pk%TYPE,
                                   p_ram computer_configurations.ram%TYPE);
    PROCEDURE UPD_COMPUTER_CFG_MONITOR(p_computer_cfg_id computer_configurations.computer_cfg_id_pk%TYPE,
                                       p_monitor computer_configurations.monitor%TYPE);
    PROCEDURE UPD_COMPUTER_CFG_MOUSE(p_computer_cfg_id computer_configurations.computer_cfg_id_pk%TYPE,
                                     p_mouse computer_configurations.mouse%TYPE);
    PROCEDURE UPD_COMPUTER_CFG_KEYBOARD(p_computer_cfg_id computer_configurations.computer_cfg_id_pk%TYPE,
                                        p_keyboard computer_configurations.keyboard%TYPE);
    PROCEDURE DEL_COMPUTER_CFG(p_computer_cfg_id computer_configurations.computer_cfg_id_pk%TYPE);
END computer_cfg_crud;


CREATE OR REPLACE PACKAGE BODY computer_cfg_crud
IS
    PROCEDURE ADD_COMPUTER_CFG(p_cpu computer_configurations.cpu%TYPE,
                               p_gpu computer_configurations.gpu%TYPE,
                               p_ram computer_configurations.ram%TYPE,
                               p_monitor computer_configurations.monitor%TYPE,
                               p_mouse computer_configurations.mouse%TYPE,
                               p_keyboard computer_configurations.keyboard%TYPE)
                               IS
    BEGIN
        INSERT INTO computer_configurations values(NULL, p_cpu, p_cpu, p_ram, p_monitor, p_mouse, p_keyboard);
    EXCEPTION
          WHEN DUP_VAL_ON_INDEX
            THEN dbms_output.put_line('There are multiple values with [..]');
    END ADD_COMPUTER_CFG;

    PROCEDURE UPD_COMPUTER_CFG_CPU(p_computer_cfg_id computer_configurations.computer_cfg_id_pk%TYPE,
                                   p_cpu computer_configurations.cpu%TYPE)
                                   IS
    e_exp EXCEPTION;
    BEGIN
        UPDATE computer_configurations SET cpu=p_cpu WHERE computer_cfg_id_pk = p_computer_cfg_id;
        IF SQL%ROWCOUNT = 0 THEN RAISE e_exp;
        END IF;
    EXCEPTION
        WHEN e_exp THEN dbms_output.put_line('There is no computer configuration with the given id.');
    END UPD_COMPUTER_CFG_CPU;

    PROCEDURE UPD_COMPUTER_CFG_GPU(p_computer_cfg_id computer_configurations.computer_cfg_id_pk%TYPE,
                                   p_gpu computer_configurations.gpu%TYPE)
                                   IS
    e_exp EXCEPTION;
    BEGIN
        UPDATE computer_configurations SET gpu=p_gpu WHERE computer_cfg_id_pk = p_computer_cfg_id;
        IF SQL%ROWCOUNT = 0 THEN RAISE e_exp;
        END IF;
    EXCEPTION
        WHEN e_exp THEN dbms_output.put_line('There is no computer configuration with the given id.');
    END UPD_COMPUTER_CFG_GPU;

    PROCEDURE UPD_COMPUTER_CFG_RAM(p_computer_cfg_id computer_configurations.computer_cfg_id_pk%TYPE,
                                   p_ram computer_configurations.ram%TYPE)
                                   IS
    e_exp EXCEPTION;
    BEGIN
        UPDATE computer_configurations SET ram=p_ram WHERE computer_cfg_id_pk = p_computer_cfg_id;
        IF SQL%ROWCOUNT = 0 THEN RAISE e_exp;
        END IF;
    EXCEPTION
        WHEN e_exp THEN dbms_output.put_line('There is no computer configuration with the given id.');
    END UPD_COMPUTER_CFG_RAM;

    PROCEDURE UPD_COMPUTER_CFG_MONITOR(p_computer_cfg_id computer_configurations.computer_cfg_id_pk%TYPE,
                                       p_monitor computer_configurations.monitor%TYPE)
                                       IS
    e_exp EXCEPTION;
    BEGIN
        UPDATE computer_configurations SET monitor=p_monitor WHERE computer_cfg_id_pk = p_computer_cfg_id;
        IF SQL%ROWCOUNT = 0 THEN RAISE e_exp;
        END IF;
    EXCEPTION
        WHEN e_exp THEN dbms_output.put_line('There is no computer configuration with the given id.');
    END UPD_COMPUTER_CFG_MONITOR;

    PROCEDURE UPD_COMPUTER_CFG_MOUSE(p_computer_cfg_id computer_configurations.computer_cfg_id_pk%TYPE,
                                     p_mouse computer_configurations.mouse%TYPE)
                                     IS
    e_exp EXCEPTION;
    BEGIN
        UPDATE computer_configurations SET mouse=p_mouse WHERE computer_cfg_id_pk = p_computer_cfg_id;
        IF SQL%ROWCOUNT = 0 THEN RAISE e_exp;
        END IF;
    EXCEPTION
        WHEN e_exp THEN dbms_output.put_line('There is no computer configuration with the given id.');
    END UPD_COMPUTER_CFG_MOUSE;

    PROCEDURE UPD_COMPUTER_CFG_KEYBOARD(p_computer_cfg_id computer_configurations.computer_cfg_id_pk%TYPE,
                                        p_keyboard computer_configurations.keyboard%TYPE)
                                        IS
    e_exp EXCEPTION;
    BEGIN
        UPDATE computer_configurations SET keyboard=p_keyboard WHERE computer_cfg_id_pk = p_computer_cfg_id;
        IF SQL%ROWCOUNT = 0 THEN RAISE e_exp;
        END IF;
    EXCEPTION
        WHEN e_exp THEN dbms_output.put_line('There is no computer configuration with the given id.');
    END UPD_COMPUTER_CFG_KEYBOARD;

    PROCEDURE DEL_COMPUTER_CFG(p_computer_cfg_id computer_configurations.computer_cfg_id_pk%TYPE) IS
    e_exp EXCEPTION;
    BEGIN
        DELETE FROM computer_configurations WHERE computer_cfg_id_pk = p_computer_cfg_id;
        IF SQL%ROWCOUNT = 0 THEN RAISE e_exp;
        END IF;
    EXCEPTION
        WHEN e_exp THEN dbms_output.put_line('There is no computer configuration with the given id.');
    END DEL_COMPUTER_CFG;
END computer_cfg_crud;