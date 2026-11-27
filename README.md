# AURA MANAGER V2

Duplikat ringkas AURA Sport Manager — hanya **Round Mix** dan **Data Member**,
untuk dipakai ±10 device yang input skor bersamaan.

- Tanpa login (siapa pun yang punya link bisa input skor)
- Data bersama + realtime lewat Supabase (project `aura-manager-v2`)
- Skor ditulis dengan optimistic lock (`updated_at`) lalu digabung ulang, jadi skor
  dari device berbeda tidak saling menimpa
- Cadangan otomatis tiap ≤5 menit (tabel `sport_manager_state_history`, 100 terakhir)
- Foto pemain disimpan di bucket publik `player-photos`

Deploy: hubungkan repo ke Vercel (tanpa framework; `vercel.json` sudah ada).
`node loadtest.js` = uji beban 10 device (`FILE=index.html ROUNDS=2 node loadtest.js`).
