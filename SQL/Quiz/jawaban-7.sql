with temp as (
	select distinct *
	from xy
)
select xy1.X as x, xy1.Y as y
from temp xy1
join temp xy2
on xy1.Y = xy2.X and xy1.X = xy2.Y
where xy1.X - xy1.Y <1
order by 1