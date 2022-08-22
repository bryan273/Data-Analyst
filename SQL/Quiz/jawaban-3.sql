with temp as (
	select td.no_do, mc.nama_customer, td.tgl_do, 
		   date("2018-02-01") as date_measurement
	from tr_do td
	join tr_so ts
	using(no_entry_so)
	join ms_customer mc 
	using(kode_customer)
	where td.no_entry_do not in (select no_entry_do from tr_inv)
) select * , DATEDIFF(date_measurement, tgl_do) as aging
from temp
order by aging desc