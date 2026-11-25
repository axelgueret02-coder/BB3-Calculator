# Mettre en ligne le Calculateur BB3 (avec comptes)

Durée : environ 20 minutes. Tout est gratuit. Pas besoin de savoir coder.

Contenu du dossier :

| Fichier | À quoi il sert |
|---|---|
| `index.html` | L'appli (connexion + calculateur) |
| `config.js` | Les 2 clés de ta base Supabase, à remplir (étape 3) |
| `schema.sql` | La base de données, à coller dans Supabase (étape 2) |
| `confidentialite.html` | Page de confidentialité (RGPD), à compléter (étape 4) |

---

## Étape 1 : créer la base de données (Supabase)

1. Va sur **supabase.com**, clique sur **Start your project** et crée un compte (avec GitHub ou ton e-mail).
2. Clique sur **New project** :
   - **Name** : `calculateur-bb3`
   - **Database Password** : clique sur *Generate* et garde-le quelque part (tu n'en auras normalement plus besoin).
   - **Region** : choisis **Europe (Paris)** ou **Europe (Frankfurt)**. C'est important pour le RGPD.
3. Clique sur **Create new project** et attends 1 à 2 minutes.

## Étape 2 : créer la table des notes

1. Dans le menu de gauche, ouvre **SQL Editor**, puis **New query**.
2. Ouvre le fichier `schema.sql` avec le Bloc-notes (ou TextEdit), copie **tout** le contenu et colle-le dans Supabase.
3. Clique sur **Run**. Le message *Success. No rows returned* doit s'afficher.

## Étape 3 : copier les clés dans `config.js`

1. Dans Supabase, va dans **Project Settings** (roue crantée), puis **API** (ou **Data API** / **API Keys** selon la version).
2. Copie :
   - le **Project URL** (du type `https://abcdefgh.supabase.co`) ;
   - la clé **anon public** (une longue suite de caractères qui commence souvent par `eyJ`).
3. Ouvre `config.js` avec le Bloc-notes et remplace les deux valeurs entre guillemets :

```js
window.BB3_CONFIG = {
  SUPABASE_URL: "https://abcdefgh.supabase.co",
  SUPABASE_ANON_KEY: "eyJhbGciOi..."
};
```

4. Enregistre le fichier.

> La clé *anon* peut être publique, c'est prévu pour. Par contre, ne mets **jamais** la clé *service_role* dans ce fichier.

## Étape 4 : compléter la page de confidentialité

Ouvre `confidentialite.html` avec le Bloc-notes et remplace les 3 commentaires `<!-- ... -->` par la date, ton nom et ton e-mail de contact. Enregistre.

## Étape 5 : mettre le site en ligne (Netlify)

1. Va sur **app.netlify.com/drop** et crée un compte.
2. **Glisse le dossier `calculateur-bb3` entier** dans la zone de dépôt.
3. Après quelques secondes, Netlify te donne une adresse du type `https://nom-aleatoire-123.netlify.app`.
4. Pour avoir une plus jolie adresse : **Site configuration**, puis **Change site name**, par exemple `calculateur-bb3` (si le nom est libre). Ton adresse devient `https://calculateur-bb3.netlify.app`.

## Étape 6 : dire à Supabase quelle est l'adresse de ton site

Sans ça, les liens de confirmation et de mot de passe oublié reçus par e-mail ne ramèneront pas au bon endroit.

1. Dans Supabase : **Authentication**, puis **URL Configuration**.
2. **Site URL** : colle l'adresse Netlify, par exemple `https://calculateur-bb3.netlify.app`.
3. **Redirect URLs** : clique sur *Add URL* et ajoute la même adresse suivie de `/**`, par exemple `https://calculateur-bb3.netlify.app/**`.
4. Clique sur **Save**.

## Étape 7 : tester

1. Ouvre ton adresse Netlify, clique sur **Créer un compte**, entre ton e-mail et un mot de passe.
2. Ouvre l'e-mail de confirmation reçu (regarde dans les spams) et clique sur le lien.
3. Entre une note, puis ouvre le site sur ton téléphone avec le même compte : la note doit y être.

---

## À savoir

- **E-mails de confirmation** : le service d'e-mails gratuit de Supabase est limité à quelques e-mails par heure. Pour quelques personnes, ça suffit. Si toute ta promo s'inscrit le même jour, deux solutions :
  - désactiver la confirmation (**Authentication**, puis **Sign In / Providers**, **Email**, et décocher **Confirm email**) ;
  - ou brancher un service d'e-mails gratuit comme Resend (**Authentication**, puis **SMTP Settings**).
- **Mettre à jour le site** : modifie les fichiers, puis dans Netlify, va dans **Deploys** et glisse à nouveau le dossier dans la zone prévue.
- **Mise en pause** : un projet Supabase gratuit est mis en pause après environ 1 semaine sans aucune visite. Il suffit alors de cliquer sur *Restore* dans Supabase. Dès que le site est utilisé régulièrement, ça n'arrive pas.
- **Voir les inscrits** : dans Supabase, **Authentication**, puis **Users**. Tu vois les e-mails des inscrits. Tu peux techniquement voir les notes dans **Table Editor** : en tant que gestionnaire du site, ne les regarde pas et ne les partage pas.
- **Ajouter à l'écran d'accueil** : sur iPhone, ouvre le site dans Safari, puis **Partager** et **Sur l'écran d'accueil**. Sur Android, ouvre-le dans Chrome, puis le menu **⋮** et **Ajouter à l'écran d'accueil**.
