select author
from books
where genre = 'Fiction'
group by author
having count(name) >=2
and avg(user_rating) >= 4.5
and avg(reviews) >= (select avg(reviews) from books where genre = 'Fiction')
order by author
;
