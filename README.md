# St Louis Jubilee School Library: put it online with Vercel

You need three free accounts: **Supabase** (stores the records), **GitHub** (holds the file) and **Vercel** (puts it online).

## 1. Create the database (Supabase)
1. Go to supabase.com, sign up, and create a new project. Save the database password.
2. Open **SQL Editor → New query**, paste everything from `setup.sql`, and press **Run**.
3. Open **Authentication → Sign In / Providers → Email** and turn **off** "Allow new users to sign up". Only people you add can then log in.
4. Open **Authentication → Users → Add user**. Create an account (email and password) for every administrator and monitor. Tick "Auto confirm user".
5. In **SQL Editor**, edit the two `update auth.users ...` lines at the bottom of `setup.sql` so they use the real email addresses (one line per person, `admin` or `monitor`), then run them. People must sign in again after a role is set.

## 2. Add your project details to the page
1. In Supabase open **Project Settings → API**. Copy the **Project URL** and the **anon public** key.
2. Open `index.html` in Notepad and paste them near the top, replacing `PASTE_PROJECT_URL` and `PASTE_ANON_PUBLIC_KEY`.
   The anon key is meant to be public. The database rules stop monitors and strangers from changing anything.

## 3. Publish on Vercel
1. On github.com create a new repository and upload `index.html` to it.
2. On vercel.com choose **Add New → Project**, import that repository, and press **Deploy**. You get an address like `your-project.vercel.app`.

## 4. Use your own domain name
1. In Vercel open the project, then **Settings → Domains → Add**, and type your domain (for example `library.yourschool.edu.gh`).
2. Vercel shows the DNS records to add. Add them where you bought the domain (or buy it inside Vercel). It usually works within an hour.

## 5. Move your existing records
In the Claude version go to **Admin → Download backup**. Then sign in to the new site as an administrator, open **Admin → Restore backup**, and choose that file. Everything is copied to the shared database.

Roles: `admin` can add and change records. `monitor` can only view. Add or remove people any time in Supabase under Authentication. Use the Supabase dashboard's backup or the app's **Download backup** button regularly.
