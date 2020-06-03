create table question_type
(
    id          bigserial not null
        constraint question_type_pkey
            primary key,
    description varchar(255),
    status      boolean
);

alter table question_type
    owner to postgres;

INSERT INTO public.question_type (id, description, status) VALUES (1, 'TITTLE', true);
INSERT INTO public.question_type (id, description, status) VALUES (2, 'DATEBOX', true);
INSERT INTO public.question_type (id, description, status) VALUES (3, 'SELECTED', true);
INSERT INTO public.question_type (id, description, status) VALUES (4, 'TEXTBOX', true);
INSERT INTO public.question_type (id, description, status) VALUES (5, 'TEXTAREA', true);
INSERT INTO public.question_type (id, description, status) VALUES (6, 'CHECK', true);
INSERT INTO public.question_type (id, description, status) VALUES (7, 'LABEL', true);