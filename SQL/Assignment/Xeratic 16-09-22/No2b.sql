-- i
select 
	 sum(tp.jumlah_pembelian * mhh.harga_berlaku_cabang) as total_amount,
	 sum(tp.jumlah_pembelian * 
	 		(mhh.harga_berlaku_cabang - mhh.modal_cabang - mhh.biaya_cabang)
	 	)  as total_profit
from tr_penjualan tp 
join ms_harga_harian mhh 
		on tp.kode_produk = mhh.kode_produk and 
		tp.kode_cabang = mhh.kode_cabang and 
		tp.tgl_transaksi = mhh.tgl_berlaku 

-- ii
select 
	mc.nama_cabang  ,
	 sum(tp.jumlah_pembelian * mhh.harga_berlaku_cabang) as total_amount,
	 sum(tp.jumlah_pembelian * 
	 		(mhh.harga_berlaku_cabang - mhh.modal_cabang - mhh.biaya_cabang)
	 	)  as total_profit
from tr_penjualan tp 
join ms_harga_harian mhh 
		on tp.kode_produk = mhh.kode_produk and 
		tp.kode_cabang = mhh.kode_cabang and 
		tp.tgl_transaksi = mhh.tgl_berlaku 
join ms_cabang mc 
on mc.kode_cabang = tp.kode_cabang 
group by 1
		
-- iii
select 
	mk.nama_kota ,
	 sum(tp.jumlah_pembelian * mhh.harga_berlaku_cabang) as total_amount,
	 sum(tp.jumlah_pembelian * 
	 		(mhh.harga_berlaku_cabang - mhh.modal_cabang - mhh.biaya_cabang)
	 	)  as total_profit
from tr_penjualan tp 
join ms_harga_harian mhh 
		on tp.kode_produk = mhh.kode_produk and 
		tp.kode_cabang = mhh.kode_cabang and 
		tp.tgl_transaksi = mhh.tgl_berlaku 
join ms_cabang mc 
on mc.kode_cabang = tp.kode_cabang 
join ms_kota mk 
on mk.kode_kota = mc.kode_kota 
group by 1;

-- iv
select 
	mp.nama_propinsi  ,
	 sum(tp.jumlah_pembelian * mhh.harga_berlaku_cabang) as total_amount,
	 sum(tp.jumlah_pembelian * 
	 		(mhh.harga_berlaku_cabang - mhh.modal_cabang - mhh.biaya_cabang)
	 	)  as total_profit
from tr_penjualan tp 
join ms_harga_harian mhh 
		on tp.kode_produk = mhh.kode_produk and 
		tp.kode_cabang = mhh.kode_cabang and 
		tp.tgl_transaksi = mhh.tgl_berlaku 
join ms_cabang mc 
on mc.kode_cabang = tp.kode_cabang 
join ms_kota mk 
on mk.kode_kota = mc.kode_kota 
join ms_propinsi mp 
on mp.kode_propinsi = mk.kode_propinsi 
group by 1;

-- v
select 
	mp.nama_produk  ,
	 sum(tp.jumlah_pembelian * mhh.harga_berlaku_cabang) as total_amount,
	 sum(tp.jumlah_pembelian * 
	 		(mhh.harga_berlaku_cabang - mhh.modal_cabang - mhh.biaya_cabang)
	 	)  as total_profit
from tr_penjualan tp 
join ms_harga_harian mhh 
		on tp.kode_produk = mhh.kode_produk and 
		tp.kode_cabang = mhh.kode_cabang and 
		tp.tgl_transaksi = mhh.tgl_berlaku 
join ms_produk mp
on mp.kode_produk = tp.kode_produk 
group by 1;

-- vi
select 
	mk.nama_kategori  ,
	 sum(tp.jumlah_pembelian * mhh.harga_berlaku_cabang) as total_amount,
	 sum(tp.jumlah_pembelian * 
	 		(mhh.harga_berlaku_cabang - mhh.modal_cabang - mhh.biaya_cabang)
	 	)  as total_profit
from tr_penjualan tp 
join ms_harga_harian mhh 
		on tp.kode_produk = mhh.kode_produk and 
		tp.kode_cabang = mhh.kode_cabang and 
		tp.tgl_transaksi = mhh.tgl_berlaku 
join ms_produk mp
on mp.kode_produk = tp.kode_produk 
join ms_kategori mk 
on mp.kode_kategori = mk.kode_kategori 
group by 1;