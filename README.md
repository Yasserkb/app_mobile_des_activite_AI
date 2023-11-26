# mobile_ai

an ai based flutter app

## Getting Started

L'application Flutter que j'ai construite fonctionne de la manière suivante : le logo s'affiche avant tout au début à l'aide d'une page de splash_screen qui gère cela. Ensuite, je redirige l'utilisateur vers la page de connexion après avoir saisi les données de connexion correctes qui seront vérifiées dans le code pour leur validation. Si les données sont correctes, vous serez redirigé vers la page d'accueil qui affiche une liste de toutes les activités que l'utilisateur a obtenues à partir d'une méthode de récupération de données depuis Firestore de l'application Firebase. Ensuite, elles sont affichées sous forme de liste déroulante que vous pouvez faire défiler. Vous pouvez cliquer sur chaque élément et voir la page de détails de chaque élément.

Vous remarquerez une barre de navigation en bas qui vous amène à 3 pages : accueil, ajout et profil. La barre de navigation en bas est dans un fichier séparé pour respecter le SRP, c'est-à-dire le principe de responsabilité unique de SOLID.

Aussi, sur la page d'accueil, vous verrez un filtre en haut de l'écran pour filtrer toutes les activités, de toutes à football ou équitation.

Pour la page d'ajout, vous trouverez un formulaire avec des champs pour une image depuis la galerie, ainsi que pour le titre, l'emplacement, le prix et le nombre de personnes pouvant participer. Cependant, pour la catégorie, vous ne pouvez pas la changer car seule l'entrée d'image déterminera la catégorie de l'activité en fonction d'une IA formée pour reconnaître l'activité football et équitation.

Mais après la soumission, vous verrez un message qui confirme la transformation des données. Si vous pouvez simplement accéder à la page d'accueil et actualiser la page, vous verrez l'élément qui a été ajouté là.

images of the app :

## Splash_screen:
![splash](https://github.com/Yasserkb/app_mobile_des_activite_AI/assets/61334314/d7065ec2-4e38-473d-a4e3-64f0e4a5d70c){ width=300px height=200px }


## LogIn:

![login](https://github.com/Yasserkb/app_mobile_des_activite_AI/assets/61334314/56e93c87-a059-4f39-8d42-223a3359fa20){ width=300px height=600px }


## HomePage:

![home](https://github.com/Yasserkb/app_mobile_des_activite_AI/assets/61334314/73c37b37-f911-4d63-85d2-3265594d327b){ width=300px height=600px }



  
## AddPage :

![addpage](https://github.com/Yasserkb/app_mobile_des_activite_AI/assets/61334314/cf6ba3f4-dba5-4454-9ea6-7e85ece59e64){ width=300px height=600px }


## the toast feature :

![toast](https://github.com/Yasserkb/app_mobile_des_activite_AI/assets/61334314/fa5651aa-8008-4be1-97df-7237e5710df5){ width=300px height=600px }



## DetailsPage :

![details](https://github.com/Yasserkb/app_mobile_des_activite_AI/assets/61334314/4d84959e-a6b4-488a-b495-779e52952241){ width=300px height=600px }

