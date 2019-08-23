-- select * from movie_actors order by movie_title

with movie_revenue_clean as (select * from movie_revenue where revenue <> 0 group by id, title, original_title, revenue),

movie_rev_and_actor as (select movie_revenue_clean.revenue as revenue, movie_actors.movie_title as title, movie_actors.title_year as year, movie_actors.actor_1_name as lead_actor, movie_actors.director_name as director_name 
from movie_revenue_clean
inner join movie_actors
on movie_revenue_clean.title = movie_actors.movie_title
group by movie_title, revenue, actor_1_name, director_name, title_year
order by revenue desc)


select inflation.year, inflation.cumulative, movie_rev_and_actor.revenue, (movie_rev_and_actor.revenue * inflation.cumulative) as rev_infl, movie_rev_and_actor.title, movie_rev_and_actor.title, movie_rev_and_actor.lead_actor, movie_rev_and_actor.director_name
from movie_rev_and_actor
join inflation
on movie_rev_and_actor.year = inflation.year;
