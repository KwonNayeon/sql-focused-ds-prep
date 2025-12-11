select
  distinct gen.name as genre,
  round(avg(case when g.year = 2011 then g.critic_score end),2) as score_2011,
  round(avg(case when g.year = 2012 then g.critic_score end),2) as score_2012,
  round(avg(case when g.year = 2013 then g.critic_score end),2) as score_2013,
  round(avg(case when g.year = 2014 then g.critic_score end),2) as score_2014,
  round(avg(case when g.year = 2015 then g.critic_score end),2) as score_2015
from
  games g
  left join genres gen on g.genre_id = gen.genre_id
group by gen.name
;
