CREATE TABLE IF NOT EXISTS tecnica_ml (
    id varchar(100),
    site_id varchar(100),
    title varchar(100),
    price decimal(10,2),
    thumbnail varchar(100),
    create_date date,
    primary key(id, create_date)
);