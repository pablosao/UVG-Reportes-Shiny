create table useruvg
(
    id                    bigint       not null
        constraint useruvg_pkey
            primary key,
    email                 varchar(50)  not null,
    enabled               boolean      not null,
    firstname             varchar(50)  not null,
    lastpasswordresetdate timestamp    not null,
    lastname              varchar(50)  not null,
    password              varchar(100) not null,
    username              varchar(50)  not null
        constraint uk_2xyfcgsrik95gqavwjmjseean
            unique
);

alter table useruvg
    owner to postgres;

INSERT INTO public.useruvg (id, email, enabled, firstname, lastpasswordresetdate, lastname, password, username) VALUES (1, 'admin@admin.com', true, 'admin', '2020-08-22 19:10:25.000000', 'admin', '$2a$08$lDnHPz7eUkSi6ao14Twuau08mzhWrL4kyZGGU5xfiGALO/Vxd5DOi', 'admin');
INSERT INTO public.useruvg (id, email, enabled, firstname, lastpasswordresetdate, lastname, password, username) VALUES (2, 'enabled@user.com', true, 'user', '2020-09-22 19:10:25.000000', 'user', '$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC', 'user');
INSERT INTO public.useruvg (id, email, enabled, firstname, lastpasswordresetdate, lastname, password, username) VALUES (3, 'disabled@user.com', false, 'user', '2020-10-22 19:10:25.000000', 'user', '$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC', 'disabled');