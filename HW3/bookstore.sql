use bookstore;

create table author
(
    name    varchar(256) primary key,
    address varchar(256),
    url     varchar(256)
);

create table publisher
(
    name    varchar(256) primary key,
    address varchar(256),
    phone   int,
    url     varchar(256)
);

create table customer
(
    email   varchar(256) primary key,
    name    varchar(256),
    address varchar(256),
    phone   int
);

create table shopping_basket
(
    basket_id int primary key
);

create table book
(
    isbn  int primary key,
    title varchar(256),
    year  int,
    price float
);

create table warehouse
(
    code    int primary key,
    address varchar(256),
    phone   int
);

create table written_by
(
    name varchar(257),
    isbn int,
    foreign key (name) references author (name),
    foreign key (isbn) references book (isbn),
    primary key (name, isbn)
);

create table published_by
(
    name varchar(256),
    isbn int,
    foreign key (name) references publisher (name),
    foreign key (isbn) references book (isbn),
    primary key (name, isbn)
);

create table basket_of
(
    email     varchar(256),
    basket_id int,
    foreign key (email) references customer (email),
    foreign key (basket_id) references shopping_basket (basket_id),
    primary key (email, basket_id)
);

create table contains
(
    isbn      int,
    basket_id int,
    number    int,
    foreign key (isbn) references book (isbn),
    foreign key (basket_id) references shopping_basket (basket_id),
    primary key (isbn, basket_id)
);

create table stocks
(
    isbn   int,
    code   int,
    number int,
    foreign key (isbn) references book (isbn),
    foreign key (code) references warehouse (code),
    primary key (isbn, code)
);

create table video
(
    video_id int primary key,
    title    varchar(256),
    creator  varchar(256)
);

create table bluray
(
    video_id int primary key,
    price    float,
    foreign key (video_id) references video (video_id)
);

create table download
(
    video_id int primary key,
    price    float,
    foreign key (video_id) references video (video_id)
);

# Part b
create table bluray
(
    disc_id  int primary key,
    video_id int,
    price    float,
    foreign key (video_id) references video (video_id)
);

alter table stocks
    add column disc_id int;

alter table stocks
    add foreign key (disc_id) references bluray (disc_id);
# ---------------------------
drop table bluray;
drop table download;
drop table video;

create table video (
    video_id int primary key,
    title varchar(256),
    creator varchar(256),
    price float
);

create table bluray (
    disc_id int primary key,
    video_id int,
    price float,
    foreign key (video_id) references video(video_id)
);

alter table stocks
    add foreign key (disc_id) references bluray(disc_id);

create table item (
    item_id int primary key,
    isbn int,
    video_id int,
    disc_id int,
    foreign key (isbn) references book(isbn),
    foreign key (video_id) references video(video_id),
    foreign key (disc_id) references bluray(disc_id)
);

drop table item;

alter table contains
    drop foreign key contains_ibfk_1,
    drop column isbn,
    add column item_id int,
    add foreign key (item_id) references item(item_id);
