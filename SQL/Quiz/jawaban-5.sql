-- Set only full group by
SET sql_mode=(SELECT CONCAT(@@sql_mode, ',ONLY_FULL_GROUP_BY'));

with temp as(
	select 	mv.vendor, 
			mp.harga_satuan,
			mc.ongkos_kirim,
			case when ts.satuan="krat" then ts.qty*24
			when ts.satuan="dus" then ts.qty*30
			else ts.qty end as qty
	from ms_vendor mv 
	join ms_product mp 
	using(kode_vendor)
	join tr_so ts 
	on ts.kode_barang = mp.kode_produk 
	join tr_do td
	using(no_entry_so)
	join tr_inv ti 
	using(no_entry_do)
	join ms_customer mc 
	using(kode_customer)
)
select vendor, sum(round(qty*harga_satuan)) as amount
from temp
group by 1
order by 2 desc
