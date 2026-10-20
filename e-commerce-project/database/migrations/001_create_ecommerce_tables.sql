select current_database(), current_schema();

create table public.geolocation (
    geolocation_id bigint generated always as identity,
    geolocation_zip_code_prefix varchar(5) NOT NULL,
    geolocation_city VARCHAR(100) NOT NULL,
    geolocation_state VARCHAR(2) NOT NULL,

    constraint pk_geolocation
        primary key (geolocation_id),

    constraint chk_geolocation_zip_code_prefix
        check (geolocation_zip_code_prefix ~ '^[0-9]{5}$')
);


create table public.sellers (
    seller_id varchar(32) NOT NULL,
    geolocation_id bigint NOT NULL,

    constraint pk_sellers
        primary key (seller_id),

    constraint fk_seller_geolocation
        foreign key (geolocation_id)
        references public.geolocation(geolocation_id)
);

