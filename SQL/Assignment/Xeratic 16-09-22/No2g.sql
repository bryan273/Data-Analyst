with tmp as(
	select 
		extract(year from tp.tgl_transaksi) tahun,
		extract(month from tp.tgl_transaksi) bulan,
		mc.nama_cabang,
		 sum(tp.jumlah_pembelian * 
		 		(mhh.harga_berlaku_cabang)
		 	)  as total_penjualan_perbulan
	from tr_penjualan tp 
	join ms_harga_harian mhh 
			on tp.kode_produk = mhh.kode_produk and 
			tp.kode_cabang = mhh.kode_cabang and 
			tp.tgl_transaksi = mhh.tgl_berlaku 
	join ms_cabang mc 
	on mc.kode_cabang = tp.kode_cabang 
	group by 3,1,2
),
tmp3 as(
	select *,
		(total_penjualan_perbulan-prev_month) as selisih_dengan_bulan_lalu
	from (
		 select * , LAG(total_penjualan_perbulan)
		 OVER (PARTITION BY nama_cabang, tahun
         ORDER BY nama_cabang, tahun)
         AS prev_month
		 from tmp) tmp2
)
select 
	tahun, bulan, nama_cabang, total_penjualan_perbulan,
	selisih_dengan_bulan_lalu,
	case when selisih_dengan_bulan_lalu is null then 'Tidak ada penjualan'
		when selisih_dengan_bulan_lalu > 0 then 'Naik Sebesar Rp ' || selisih_dengan_bulan_lalu
		else 'Turun Sebesar Rp ' || selisih_dengan_bulan_lalu end as status_penjualan,
	sum(total_penjualan_perbulan)
	over(partition by nama_cabang, tahun, bulan
		order by nama_cabang, tahun, bulan) as ytd_penjualan
from tmp3