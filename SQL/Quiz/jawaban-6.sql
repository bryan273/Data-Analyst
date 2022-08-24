select node,
	case when parent is null then "Akar"
		 when node in (select parent from nodes) 
		 		   and node is not null then "Batang"
		 else "Daun" end as position
from nodes n
order by 1