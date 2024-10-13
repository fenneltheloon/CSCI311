create table brand
(
    brand_id int primary key,
    name     varchar(256)
);

create table model
(
    model_id int primary key,
    brand_id int,
    name     varchar(256),
    year     int,
    foreign key (brand_id) references brand (brand_id)
);


create table options
(
    option_id   int primary key,
    model_id    int,
    name        varchar(256),
    description text,
    foreign key (model_id) references model (model_id)
);

create table dealer
(
    dealer_id int primary key,
    name      varchar(256),
    location  varchar(256)
);

create table customer
(
    customer_id int primary key,
    name        varchar(256)
);

create table car
(
    vin      varchar(17) primary key,
    model_id int,
    foreign key (model_id) references model (model_id)
);

create table stocks
(
    dealer_id int,
    vin       varchar(17) primary key,
    foreign key (dealer_id) references dealer (dealer_id),
    foreign key (vin) references car (vin)
);

create table owns
(
    customer_id int,
    vin         varchar(17) primary key,
    dealer_id   int,
    foreign key (customer_id) references customer (customer_id),
    foreign key (vin) references car (vin),
    foreign key (dealer_id) references dealer (dealer_id)
);

create table has_option
(
    vin       varchar(17) primary key,
    option_id int,
    foreign key (vin) references car (vin),
    foreign key (option_id) references options (option_id)
);