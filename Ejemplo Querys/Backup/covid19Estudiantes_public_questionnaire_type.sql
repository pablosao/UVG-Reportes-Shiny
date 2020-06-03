create table questionnaire_type
(
    id          bigint not null
        constraint questionnaire_type_pkey
            primary key,
    description varchar(255),
    status      boolean
);

alter table questionnaire_type
    owner to postgres;

INSERT INTO public.questionnaire_type (id, description, status) VALUES (1, 'REPORTE', true);
INSERT INTO public.questionnaire_type (id, description, status) VALUES (2, 'EXPEDIENTE', true);
INSERT INTO public.questionnaire_type (id, description, status) VALUES (3, 'REPORTE CONVIVIENTE', true);