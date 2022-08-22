with temp as
(
	select mp.nama_pegawai, count(distinct ts.no_so) as jumlah_so, 
        mp.target
	from tr_so ts 
	join ms_pegawai mp 
	on ts.kode_sales = mp.kode_pegawai
	group by 1,3
	order by 1
) select * , 
	case when jumlah_so<target then "ya"
	else "tidak" end
	as kurang_dari_target
from temp