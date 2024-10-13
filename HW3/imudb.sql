create table album
(
    album_id     int primary key,
    name         varchar(256),
    type         enum ('single', 'EP', 'LP'),
    art          blob,
    release_date date
);

create table song
(
    song_id int primary key,
    name    varchar(256),
    # length in seconds
    length  int,
    streams int
);

create table genre
(
    genre_id int primary key,
    title    varchar(256)
);

create table person
(
    person_id int primary key,
    name      varchar(256),
    birthday  date
);

create table ensemble
(
    ensemble_id   int primary key,
    name          varchar(256),
    founding_date date
);

create table entity
(
    entity_id   int primary key,
    person_id   int,
    ensemble_id int,
    foreign key (person_id) references person (person_id),
    foreign key (ensemble_id) references ensemble (ensemble_id)
);

# A song can be in many albums
create table song_in_album
(
    song_id  int,
    album_id int,
    foreign key (song_id) references song (song_id),
    foreign key (album_id) references album (album_id),
    primary key (song_id, album_id)
);

# Genres for album are generated from the list of genres associated with songs
# in the album
create table song_has_genre
(
    song_id  int,
    genre_id int,
    foreign key (song_id) references song (song_id),
    foreign key (genre_id) references genre (genre_id),
    primary key (song_id, genre_id)
);

create table person_in_ensemble
(
    person_id   int,
    ensemble_id int,
    foreign key (person_id) references person (person_id),
    foreign key (ensemble_id) references ensemble (ensemble_id),
    primary key (person_id, ensemble_id)
);

create table role
(
    entity_id int,
    song_id   int,
    foreign key (entity_id) references entity (entity_id),
    foreign key (song_id) references song (song_id),
    primary key (entity_id, song_id)
)