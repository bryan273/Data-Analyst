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
select * from (
	select RANK() OVER (
	    PARTITION by nama_kota,tahun,bulan
	    ORDER BY total_profit desc) as top3,
	    *
		from tmp
	) tmp2
where top3 <=3
order by  3,4,5,1;

-- ii
with tmp as(
	select 
		mc.nama_cabang  ,mp.nama_propinsi ,
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
	join ms_propinsi mp 
	on mp.kode_propinsi = mk.kode_propinsi 
	group by 2,1,3,4
)
select * from (
	select RANK() OVER (
	    PARTITION by nama_propinsi,tahun,bulan
	    ORDER BY total_profit desc) as top3,
	    *
		from tmp
	) tmp2
where top3 <=3
order by  3,4,5,1;

-- iii
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
select * from (
	select RANK() OVER (
	    PARTITION by nama_kota,tahun,bulan
	    ORDER BY total_profit desc) as top3,
	    *
		from tmp
	) tmp2
where top3 <=3
order by  3,4,5,1;

-- iv
with tmp as(
	select 
		mp.nama_produk  ,mp2.nama_propinsi ,
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
	join ms_propinsi mp2
	on mp2.kode_propinsi = mk.kode_propinsi 
	group by 2,1,3,4
)
select * from (
	select RANK() OVER (
	    PARTITION by nama_propinsi,tahun,bulan
	    ORDER BY total_profit desc) as top3,
	    *
		from tmp
	) tmp2
where top3 <=3
order by  3,4,5,1;