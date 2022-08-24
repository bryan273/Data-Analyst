with temp as(
	select nama, 
	datediff(tanggal_registrasi,tanggal_lahir) as diff
	from people p 
	order by diff
), temp2 as (
	select nama nama1, lead(nama) over(order by diff) nama2,
	       abs(diff-lead(diff) over(order by diff)) selisih
	from temp
) select * from temp2
  where selisih = (select min(selisih) from temp2) and
  		selisih is not null