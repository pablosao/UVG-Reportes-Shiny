create table users
(
    id      bigint       not null
        constraint users_pkey
            primary key,
    consent boolean      not null,
    nametag varchar(100) not null
        constraint uk_5rgum2wdkd0mtnngdlpvhh97p
            unique,
    useruvg varchar(100) not null
);

alter table users
    owner to postgres;

INSERT INTO public.users (id, consent, nametag, useruvg) VALUES (1824, true, '6130', 'JUAN CARLOS ROMERO');
INSERT INTO public.users (id, consent, nametag, useruvg) VALUES (1909, true, '3584', 'CORDON');
INSERT INTO public.users (id, consent, nametag, useruvg) VALUES (1945, true, '3245', 'FLORES');
INSERT INTO public.users (id, consent, nametag, useruvg) VALUES (2079, true, '191530', 'GARCIA');
INSERT INTO public.users (id, consent, nametag, useruvg) VALUES (2164, true, '191525', 'MORALES');
INSERT INTO public.users (id, consent, nametag, useruvg) VALUES (2228, true, '8062', 'DIAZ');
INSERT INTO public.users (id, consent, nametag, useruvg) VALUES (2334, true, '3859', 'SOSA');
INSERT INTO public.users (id, consent, nametag, useruvg) VALUES (2440, true, '3882', 'DIAZ');
INSERT INTO public.users (id, consent, nametag, useruvg) VALUES (2525, true, '191526', 'GORDILLO');