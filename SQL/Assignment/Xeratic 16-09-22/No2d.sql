-- i
with tmp as(
	select 
		mc.nama_cabang ,
		extract(year from tp.tgl_transaksi) tahun,
		extract(month from tp.tgl_transaksi) bulan,
		sum(jumlah_pembelian) jumlah_pembelian,
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
	group by 1,2,3
)
select * ,
	sum(jumlah_pembelian) 
		OVER (PARTITION BY nama_cabang, tahun
         ORDER BY nama_cabang, tahun
         rows between unbounded preceding and current row)
         AS jumlah_pembelian_ytd
	from tmp

-- ii
with tmp as(
	select 
		mk.nama_kota  ,
		extract(year from tp.tgl_transaksi) tahun,
		extract(month from tp.tgl_transaksi) bulan,
		sum(jumlah_pembelian) jumlah_pembelian,
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
	group by 1,2,3
)
select * ,
	sum(jumlah_pembelian) 
		OVER (PARTITION BY nama_kota, tahun
         ORDER BY nama_kota, tahun
         rows between unbounded preceding and current row)
         AS jumlah_pembelian_ytd
	from tmp

-- iii
with tmp as(
	select 
		mp.nama_propinsi  ,
		extract(year from tp.tgl_transaksi) tahun,
		extract(month from tp.tgl_transaksi) bulan,
		sum(jumlah_pembelian) jumlah_pembelian,
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
	group by 1,2,3
)
select * ,
	sum(jumlah_pembelian) 
		OVER (PARTITION BY nama_propinsi, tahun
         ORDER BY nama_propinsi, tahun
         rows between unbounded preceding and current row)
         AS jumlah_pembelian_ytd
	from tmp

-- iv
with tmp as(
	select 
		mp.nama_produk  ,
		extract(year from tp.tgl_transaksi) tahun,
		extract(month from tp.tgl_transaksi) bulan,
		sum(jumlah_pembelian) jumlah_pembelian,
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
	group by 1,2,3
)
select * ,
	sum(jumlah_pembelian) 
		OVER (PARTITION BY nama_produk, tahun
         ORDER BY nama_produk, tahun
         rows between unbounded preceding and current row)
         AS jumlah_pembelian_ytd
	from tmp