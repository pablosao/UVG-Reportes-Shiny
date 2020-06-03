create table search
(
    id       bigserial    not null
        constraint search_pkey
            primary key,
    name_tag varchar(100) not null
        constraint uk_730q2nywadjf20xirkvjhnu4t
            unique,
    useruvg  varchar(100) not null
);

alter table search
    owner to postgres;

INSERT INTO public.search (id, name_tag, useruvg) VALUES (51, '6130', 'JUAN CARLOS ROMERO');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (52, '1234', 'PRUEBAS');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (53, '4567', 'PRUEBAS 1');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (54, '7890', 'PRUEBAS 2');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (55, '0123', 'PRUEBAS 3');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (1, '3584', 'CORDON');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (2, '3882', 'DIAZ');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (3, '3009', 'ALVAREZ');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (4, '3831', 'GARCIA');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (5, '9294', 'AVILA');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (6, '4311', 'MCCRACKEN');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (7, '3844', 'LOPEZ');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (8, '3586', 'PADILLA');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (9, '3585', 'MENDIZABAL');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (10, '6426', 'GARCIA');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (11, '5249', 'LOL');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (12, '8285', 'CASTAÑEDA');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (13, '4981', 'GRANADOS');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (14, '5465', 'RAMIREZ');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (15, '9327', 'FLORES');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (16, '7186', 'MOLLINEDO');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (17, '6447', 'GONZALEZ');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (18, '8084', 'AGUIRRE');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (19, '6461', 'PINEDA');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (20, '3310', 'RAMAY');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (21, '8711', 'ESTRADA');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (22, '8327', 'AREVALO');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (23, '8382', 'SOTO');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (24, '2541', 'PENNINGTON');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (25, '6432', 'ILLESCAS');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (26, '8062', 'DIAZ');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (27, '4648', 'DE LEON');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (28, '6467', 'CONTRERAS');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (29, '6443', 'LOY');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (30, '7749', 'GONZALEZ');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (31, '6438', 'REAL');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (32, '3859', 'SOSA');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (33, '1903', 'MORENO');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (34, '3514 ', 'STEIN');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (35, '2471 ', 'CORREA');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (36, '4342 ', 'MURALLES');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (37, '9213', 'NIMATUJ');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (38, '3760', 'RODAS');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (39, '884', 'RUIZ');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (40, '9212', 'GOMEZ');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (41, '8519', 'DE LEON');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (42, '8631', 'PAIZ');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (43, '692', 'DURANDO');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (44, '6481', 'REYES');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (45, '3282', 'ALDANA');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (46, '2066', 'GIL');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (47, '7225', 'MONROY');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (48, '7817', 'IVOY');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (49, '3912', 'VELIZ');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (50, '9005', 'MURALLES');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (56, '1821', 'LIBARDO');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (57, '1111', 'JUAN');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (58, '0001', 'PAIZ');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (59, '0002', 'LEAL');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (61, '0004', 'ZIELINSKY');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (62, '0005', 'ASTURIAS');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (63, '7963', 'FIGUEREDO');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (64, '3245', 'FLORES');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (65, '191521', 'BRAVO');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (66, '191530', 'GARCIA');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (67, '191526', 'GORDILLO');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (68, '191525', 'MORALES');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (60, '6439', 'CONTRERAS');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (96, '9016', 'RODRIGUEZ');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (97, '3604', 'ROSALES');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (98, '5947', 'ANDRADE');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (99, '8272', 'MONTERROSO');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (100, '8673', 'GUZMAN');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (101, '8964', 'RODRIGUEZ');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (103, '6707', 'DUBON');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (104, '8370', 'PONCIANO');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (105, '7631', 'HERRERA');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (106, '5454', 'GOMEZ');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (107, '7455', 'CORONADO');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (108, '5121', 'GALVEZ');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (109, '6599', 'MOLINA');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (110, '9267', 'ALVAREZ');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (112, '4056', 'ALVAREZ');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (113, '8976', 'RAMIREZ');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (114, '1548', 'CASTELLANOS');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (115, '7823', 'SALAZAR ');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (116, '1106', 'ZURITA');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (117, '5680', 'SAQUI');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (118, '7593', 'NORIEGA');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (119, '5422', 'BOCEL');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (120, '8917', 'GARCIA');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (121, '3876', 'SOLANO');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (122, '7352', 'SANCHEZ');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (123, '8960', 'ARGUETA');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (125, '8563', 'GARCIA');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (126, '1964', 'REYNOSO');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (127, '8579', 'FERNANDEZ');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (128, '326', 'FURLAN');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (124, '6207', 'LAU');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (102, '8921', 'ALONZO');
INSERT INTO public.search (id, name_tag, useruvg) VALUES (111, '1385', 'ARIANO');