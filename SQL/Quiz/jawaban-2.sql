with temp as(
	select td.no_do, ts.kode_customer, td.tgl_do, 
		   mp.harga_satuan, mc.ongkos_kirim,
	case when ts.satuan="krat" then ts.qty*24
	when ts.satuan="dus" then ts.qty*30
	else ts.qty end as qty
	from tr_do td
	join tr_so ts
	using(no_entry_so)
	join ms_customer mc 
	using(kode_customer)
	join ms_product mp 
	on ts.kode_barang = mp.kode_produk
) select no_do, kode_customer, tgl_do, qty,
	   round(1.1*qty*(harga_satuan)+ongkos_kirim) as amount
from temp
order by 1