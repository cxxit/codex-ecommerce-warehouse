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

