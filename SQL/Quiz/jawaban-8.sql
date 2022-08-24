with temp as(
	select regexp_substr(strdata, "\\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])") as tanggal,
		   regexp_substr(strdata, "\\d+ (lusin|buah)") as jumlah,
		   regexp_substr(strdata, "(?<=Rp )\\d+") as total
	from strdata
),
temp2 as(
	select tanggal,
			   case when regexp_substr(jumlah, "[A-Za-z]+")="lusin" then
			   			 regexp_substr(jumlah, "\\d+")*12
			   else regexp_substr(jumlah, "\\d+") end as qty,	
			total
	from temp
) select date(tanggal) as tanggal, convert(qty*1,signed) as qty, 
		convert(total/qty,signed) as harga_satuan, 
		convert(total*1,signed) as total
from temp2
order by 1