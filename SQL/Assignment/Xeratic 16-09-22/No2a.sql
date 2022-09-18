-- i
select sum(jumlah_pembelian) total_jumlah_pembelian
from tr_penjualan tp;

-- ii
select mc.nama_cabang , 
		sum(tp.jumlah_pembelian) as total_jumlah_pembelian
from tr_penjualan tp 
join ms_cabang mc 
on tp.kode_cabang = mc.kode_cabang 
group by 1;

-- iii
select mk.nama_kota  ,
		sum(tp.jumlah_pembelian) as total_jumlah_pembelian
from tr_penjualan tp 
join ms_cabang mc 
on tp.kode_cabang = mc.kode_cabang 
join ms_kota mk
on mc.kode_kota = mk.kode_kota 
group by 1;

-- iv
select mp.nama_propinsi ,
		sum(tp.jumlah_pembelian) as total_jumlah_pembelian
from tr_penjualan tp 
join ms_cabang mc 
on tp.kode_cabang = mc.kode_cabang 
join ms_kota mk
on mc.kode_kota = mk.kode_kota
join ms_propinsi mp 
on mk.kode_propinsi = mp.kode_propinsi 
group by 1;

-- v
select mp.nama_produk  , 
		sum(tp.jumlah_pembelian) as total_jumlah_pembelian
from tr_penjualan tp 
join ms_produk mp
on mp.kode_produk = tp.kode_produk 
group by 1;

-- vi
select mk.nama_kategori  , 
		sum(tp.jumlah_pembelian) as total_jumlah_pembelian
from tr_penjualan tp 
join ms_produk mp
on mp.kode_produk = tp.kode_produk 
join ms_kategori mk 
on mp.kode_kategori = mk.kode_kategori 
group by 1;
