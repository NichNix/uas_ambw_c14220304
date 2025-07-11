# Mood Journal Flutter App

Aplikasi Flutter sederhana untuk mencatat suasana hati harian.

## Fitur Utama

- Autentikasi dengan Supabase (Sign Up, Sign In, Sign Out)
- Database cloud menggunakan Supabase
- Simpan sesi login menggunakan SharedPreferences
- Get Started Screen hanya tampil saat pertama aplikasi dibuka
- UI sederhana namun responsif
- Validasi email dan password saat login


## Dummy User (Testing)

akun dummy untuk login:

- **Email:** `cobauser@contoh.com`
- **Password:** `password123`

> Atau buat akun baru dari halaman sign up.


## Teknologi yang digunakan

- Flutter
- Supabase
- SharedPreferences
- Dart


## Cara Install & Jalankan

- git clone https://github.com/Nichnix/uas_ambw_c14220304.git
- cd uas_ambw_c14220304
- flutter pub get
- Buat project baru di Supabase -> SQL Editor -> jalankan SQL berikut:
create table if not exists mood_entries (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid references auth.users(id) on delete cascade,
  emoji text not null,
  note text,
  created_at timestamp with time zone default now()
);
- flutter run
