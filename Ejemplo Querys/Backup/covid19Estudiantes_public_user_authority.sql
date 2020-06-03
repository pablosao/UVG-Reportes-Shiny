create table user_authority
(
    user_id      bigint not null
        constraint fk9d6lv4xtbijpua5cp9fh1lgbp
            references useruvg,
    authority_id bigint not null
        constraint fkgvxjs381k6f48d5d2yi11uh89
            references authority
);

alter table user_authority
    owner to postgres;

INSERT INTO public.user_authority (user_id, authority_id) VALUES (1, 1);
INSERT INTO public.user_authority (user_id, authority_id) VALUES (1, 2);
INSERT INTO public.user_authority (user_id, authority_id) VALUES (2, 1);
INSERT INTO public.user_authority (user_id, authority_id) VALUES (3, 1);