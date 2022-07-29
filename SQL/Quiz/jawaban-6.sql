select node as Node,
	case when parent is null then "akar"
		 when node in (select parent from nodes) 
		 		   and node is not null then "batang"
		 else "daun" end as Position
from nodes n
order by 1