--1. количество исполнителей в каждом жанре
select genre_id, count(*) c from artist_genre
group by genre_id 
order by c desc;

--2. количество треков, вошедших в альбомы 2019-2020 годов
select  count(*) from track t
join albom a on t.albom_id = a.id
where year_of_publication between 2019 and 2020;

--3. средняя продолжительность треков по каждому альбому
select name_albom , avg(duration) from albom a
join track t on a.id = t.albom_id 
group by name_albom, a.id 
order by a.id;

--4. все исполнители, которые не выпустили альбомы в 2020 году
select name_artist from artist a 
join artist_albom aa on a.id = aa.artist_id 
join albom a2 on aa.albom_id = a2.id
where not a2.year_of_publication = 2020;

--5. названия сборников, в которых присутствует конкретный исполнитель (выберите сами)
select c.name_collection from collection c
join track_collection tc on c.id = tc.collection_id
join track t on tc.track_id = t.id 
join artist_albom aa on t.albom_id = aa.albom_id 
join artist a on aa.artist_id = a.id
where a.name_artist like 'zemfira'
group by c.name_collection;

--6. название альбомов, в которых присутствуют исполнители более 1 жанра
select  a.name_albom from albom a 
join artist_albom aa on a.id = aa.albom_id 
join artist a2 on aa.artist_id = a2.id 
join artist_genre ag on a2.id = ag.artist_id 
group by a.name_albom 
having count(ag.genre_id) > 1;

--7. наименование треков, которые не входят в сборники
select t.name_track from track t 
left join track_collection tc on t.id = tc.track_id
where tc.track_id is null;

--8. исполнителя(-ей), написавшего самый короткий по продолжительности трек (теоретически таких треков может быть несколько)
select a.name_artist from artist a
join artist_albom aa on a.id = aa.artist_id 
join albom a2 on aa.albom_id = a2.id
join track t on a2.id = t.albom_id 
where t.duration = (select min(t2.duration) from track t2 );

--9. название альбомов, содержащих наименьшее количество треков
select name_albom from albom a
join track t on a.id = t.albom_id
group by name_albom 
having count(t.albom_id) = (select min(c) from (select count(*) c from track group by albom_id) cm);