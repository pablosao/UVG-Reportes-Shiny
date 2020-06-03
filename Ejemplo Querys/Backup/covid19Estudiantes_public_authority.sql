create table authority
(
    id   bigint      not null
        constraint authority_pkey
            primary key,
    name varchar(50) not null
);

alter table authority
    owner to postgres;

INSERT INTO public.authority (id, name) VALUES (1, 'ROLE_USER');
INSERT INTO public.authority (id, name) VALUES (2, 'ROLE_ADMIN');