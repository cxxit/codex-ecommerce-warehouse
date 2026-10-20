
select distinct
    lpad(geolocation_zip_code_prefix::TEXT,5,'0')
        as geolocation_zip_code_prefix,
    LOWER(trim(public.unaccent(geolocation_city))) as geolocation_city,
    upper(trim(geolocation_state)) as geolocation_state
from olist_geolocation_dataset; -- 19617




