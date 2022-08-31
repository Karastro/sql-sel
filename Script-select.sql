select name_albom, year_of_publication from albom 
where year_of_publication = 2018;

select name_track, duration from track
order by duration desc  
limit 1;

select name_track from track
where duration >= 210;

select name_collection from collection
where year_of_issue >= 2018 and year_of_issue <=2020;

select name_artist from artist
where name_artist not like '% %';

select name_track from track
where name_track like '%мой%' or name_track like 'my'