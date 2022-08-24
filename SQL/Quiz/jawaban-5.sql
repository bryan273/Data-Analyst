with temp as(
	select 	mv.vendor,
			mp.harga_satuan,
			case when ts.satuan="krat" then ts.qty*24
			when ts.satuan="dus" then ts.qty*30
			else ts.qty end as qty
	from ms_vendor mv 
	join ms_product mp 
	on mp.kode_vendor = mv.kode_vendor
	join tr_so ts 
	on ts.kode_barang = mp.kode_produk 
	join tr_do td
	on ts.no_entry_so = td.no_entry_so
	join tr_inv ti 
	on td.no_entry_do = ti.no_entry_do
) select vendor, convert(sum(round(qty*harga_satuan)),signed) as amount
from temp
group by 1
order by 2 desc, 1 asc
limit 3