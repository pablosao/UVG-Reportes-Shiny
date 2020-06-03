create table sections
(
    id                    bigint not null
        constraint sections_pkey
            primary key,
    correlative           integer,
    description           varchar(255),
    image                 varchar(255),
    status                boolean,
    id_questionnaire_type bigint not null
        constraint fk1rxndmyhih7of6rh2jxwtkuyq
            references questionnaire_type
            on delete cascade
);

alter table sections
    owner to postgres;

INSERT INTO public.sections (id, correlative, description, image, status, id_questionnaire_type) VALUES (1, 1, 'DATOS GENERALES', 'https://app-covid19-uvg.herokuapp.com/images/DatosGenerales.svg', true, 2);
INSERT INTO public.sections (id, correlative, description, image, status, id_questionnaire_type) VALUES (2, 3, 'TU LOCALIDAD', 'https://app-covid19-uvg.herokuapp.com/images/Localidad.svg', true, 2);
INSERT INTO public.sections (id, correlative, description, image, status, id_questionnaire_type) VALUES (9, 2, 'UBICACIÓN EN SU CAMPUS', 'https://app-covid19-uvg.herokuapp.com/images/Localidad.svg', true, 2);
INSERT INTO public.sections (id, correlative, description, image, status, id_questionnaire_type) VALUES (10, 4, 'TU LOCALIDAD 2', 'https://app-covid19-uvg.herokuapp.com/images/Localidad.svg', true, 2);
INSERT INTO public.sections (id, correlative, description, image, status, id_questionnaire_type) VALUES (3, 5, 'AFECCIONES MEDICAS', 'https://app-covid19-uvg.herokuapp.com/images/Afecciones.svg', true, 2);
INSERT INTO public.sections (id, correlative, description, image, status, id_questionnaire_type) VALUES (4, 6, 'CONVIVENCIA EN CASA', 'https://app-covid19-uvg.herokuapp.com/images/Convivientes.svg', true, 2);
INSERT INTO public.sections (id, correlative, description, image, status, id_questionnaire_type) VALUES (5, 7, 'TRANSPORTE', 'https://app-covid19-uvg.herokuapp.com/images/Transporte.svg', true, 2);
INSERT INTO public.sections (id, correlative, description, image, status, id_questionnaire_type) VALUES (6, 8, 'TRABAJADORES DE LA SALUD', 'https://app-covid19-uvg.herokuapp.com/images/TrabajadorSalud.svg', true, 2);
INSERT INTO public.sections (id, correlative, description, image, status, id_questionnaire_type) VALUES (7, 9, 'REPORTE DIARIO', 'https://app-covid19-uvg.herokuapp.com/images/DatosGenerales.svg', true, 1);
INSERT INTO public.sections (id, correlative, description, image, status, id_questionnaire_type) VALUES (8, 10, 'REPORTE DIARIO CONVIVIENTE', 'https://app-covid19-uvg.herokuapp.com/images/DatosGenerales.svg', true, 1);