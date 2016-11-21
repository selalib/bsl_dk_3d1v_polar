Command line instructions


Git global setup

```
git config --global user.name "Pierre NAVARO"
git config --global user.email "pierre.navaro@irisa.fr"
```

Create a new repository

```
git clone https://gitlab.inria.fr/ipso/bsl_dk_3d1v_polar.git
cd bsl_dk_3d1v_polar
touch README.md
git add README.md
git commit -m "add README"
git push -u origin master
```

Existing folder or Git repository

```
cd existing_folder
git init
git remote add origin https://gitlab.inria.fr/ipso/bsl_dk_3d1v_polar.git
git add .
git commit
git push -u origin master
```
