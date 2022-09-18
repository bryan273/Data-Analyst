select kode_transaksi, tgl_transaksi,
		mc.kode_cabang, mc.nama_cabang,
		mk.nama_kota, mp.nama_propinsi,
		tp.kode_kasir, 
		mk2.nama_depan || ' ' || mk2.nama_belakang nama_karyawan,
		mk2.jenis_kelamin ,
		tp.kode_item , tp.kode_produk , 
		mp2.nama_produk , mk3.nama_kategori ,
		tp.jumlah_pembelian 
from tr_penjualan tp 
join ms_cabang mc 
on tp.kode_cabang = mc.kode_cabang 
join ms_kota mk 
on mc.kode_kota = mk.kode_kota 
join ms_propinsi mp 
on mk.kode_propinsi = mp.kode_propinsi
join ms_karyawan mk2 
on mk2.kode_karyawan = tp.kode_kasir
join ms_produk mp2 
on tp.kode_produk = mp2.kode_produk 
join ms_kategori mk3 
on mp2.kode_kategori = mk3.kode_kategori 
order by 1