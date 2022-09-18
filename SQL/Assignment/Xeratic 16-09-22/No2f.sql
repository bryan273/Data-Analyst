-- i
with tmp as(
	select 
		mc.nama_cabang  ,mk.nama_kota,
		extract(year from tp.tgl_transaksi) tahun,
		extract(month from tp.tgl_transaksi) bulan,
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
	group by 2,1,3,4
)
select * , total_profit-prev_month as selisih,
		(total_profit-prev_month)::decimal/prev_month as persentase,
		round((total_profit-prev_month)::decimal/prev_month*100,2) 
				|| ' %' as persentase_text
from (
		 select * , LAG(total_profit)
		 OVER (PARTITION BY nama_kota,nama_cabang, tahun
         ORDER BY nama_kota, nama_cabang, tahun)
         AS prev_month
		 from tmp) tmp2

-- ii
with tmp as(
	select 
		mp.nama_produk  ,mk.nama_kota,
		extract(year from tp.tgl_transaksi) tahun,
		extract(month from tp.tgl_transaksi) bulan,
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
	join ms_produk mp
	on mp.kode_produk = tp.kode_produk 
	group by 2,1,3,4
)
select * , total_profit-prev_month as selisih,
		(total_profit-prev_month)::decimal/prev_month as persentase,
		round((total_profit-prev_month)::decimal/prev_month*100,2) 
				|| ' %' as persentase_text
from (
		 select * , LAG(total_profit)
		 OVER (PARTITION BY nama_kota,nama_produk, tahun
         ORDER BY nama_kota, nama_produk, tahun)
         AS prev_month
		 from tmp) tmp2

