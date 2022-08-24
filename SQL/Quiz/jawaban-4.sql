with temp as(
	select kode_barang, 
		case when ts.satuan="krat" then ts.qty*24
		when ts.satuan="dus" then ts.qty*30
		else ts.qty end as qty
	from tr_so ts
) select mp.nama_product , convert(sum(qty),signed) as qty
from temp tp 
join ms_product mp
on tp.kode_barang = mp.kode_produk 
group by 1
order by 2 desc, 1 asc
limit 3