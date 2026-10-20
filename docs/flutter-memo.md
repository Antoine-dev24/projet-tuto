# Mémo Flutter & Bloc

Aide-mémoire construit à partir du projet `projet_tuto`, avec des équivalences Angular / Spring quand elles aident.

---

## 1. Commandes Flutter

| Commande | Rôle | Équivalent |
|---|---|---|
| `flutter create mon_app` | Crée un nouveau projet | `ng new` |
| `flutter pub get` | Installe les dépendances de `pubspec.yaml` | `npm install` / `mvn install` |
| `flutter pub add flutter_bloc` | Ajoute une dépendance (et met à jour `pubspec.yaml`) | `npm install x --save` |
| `flutter run` | Lance l'app sur un appareil / émulateur / navigateur | `ng serve` |
| `flutter run -d chrome` | Lance sur un appareil précis (`flutter devices` pour la liste) | |
| `flutter analyze` | Analyse statique (erreurs, lints) | `ng lint` |
| `dart format lib` | Formate le code | Prettier |
| `flutter test` | Lance les tests de `test/` | `ng test` / `mvn test` |
| `flutter clean` | Supprime `build/` (à tenter quand un build est « bizarre ») | |
| `flutter doctor` | Vérifie l'installation (SDK, Android, Chrome…) | |
| `flutter build apk` / `flutter build web` | Build de production | `ng build` |

### Pendant un `flutter run`

| Touche | Effet |
|---|---|
| `r` | **Hot reload** : réinjecte le code, garde l'état (les compteurs ne repartent pas à zéro) |
| `R` | **Hot restart** : relance l'app, l'état est perdu |
| `q` | Quitte |

> Hot reload ne suffit pas quand tu modifies `main()`, un état initial (`super(10)`) ou un `create:` de provider → utilise `R`.

---

## 2. Tout est un Widget

Un **Widget** est une description immuable d'un morceau d'UI. Flutter reconstruit l'arbre de widgets à chaque changement, c'est peu coûteux.

### StatelessWidget vs StatefulWidget

```dart
class DotaTopBar extends StatelessWidget {
  const DotaTopBar({required this.title, super.key});
  final Widget title;               // champs toujours final

  @override
  Widget build(BuildContext context) => Text('...');
}
```

| | StatelessWidget | StatefulWidget |
|---|---|---|
| État interne | Aucun | Un objet `State` qui survit aux rebuilds |
| Rebuild déclenché par | Le parent | Le parent **ou** `setState(() {...})` |
| Usage | La majorité des widgets | Animations, champs de saisie, état très local |

Avec Bloc, on garde presque tout en **Stateless** : l'état vit dans le Cubit.

### `const`

`const` = instance créée à la compilation et réutilisée. Flutter ne reconstruit pas un widget `const`. Mets-le dès que c'est possible (le lint te le rappelle).
Impossible si une valeur n'est connue qu'à l'exécution (`Theme.of(context)`, `ThemeData(...)`).

### BuildContext

La « position » d'un widget dans l'arbre. Il sert à **remonter** l'arbre pour trouver quelque chose fourni plus haut :
`Theme.of(context)`, `Navigator.of(context)`, `context.read<MonCubit>()`.

> Piège classique : utiliser le `context` du widget qui *crée* le provider au lieu d'un context situé *en dessous*. C'est pour ça que `HomeScreen` crée les providers et `_HomeView` les utilise.

---

## 3. Widgets de mise en page

| Widget | Rôle |
|---|---|
| `Scaffold` | Structure d'une page (body, appBar, drawer, floatingActionButton) |
| `SafeArea` | Évite l'encoche / la barre de statut |
| `Column` / `Row` | Empilement vertical / horizontal (≈ flexbox) |
| `Expanded` | Prend tout l'espace restant dans une `Row`/`Column` (≈ `flex: 1`) |
| `SizedBox` | Taille fixe, ou espace vide (`SizedBox(height: 8)`) |
| `Padding` | Marge intérieure |
| `Container` | Couteau suisse : taille, couleur, bordure, padding |
| `Center` | Centre son enfant |
| `Stack` | Superpose des widgets (≈ `position: absolute`) |
| `ListView.builder` | Liste scrollable, construit seulement les éléments visibles |
| `GridView.builder` | Pareil en grille (utilisé dans `DotaCards`) |
| `Card` | Surface Material avec ombre et coins arrondis |
| `Image.network` / `Image.asset` | Image depuis une URL / depuis les assets du projet |
| `AspectRatio` | Force un ratio largeur/hauteur |

### La règle des contraintes

> **Les contraintes descendent, les tailles remontent, le parent place l'enfant.**

Erreur fréquente : `Vertical viewport was given unbounded height`.
Une `Column` donne une hauteur **infinie** à ses enfants ; une `ListView`/`GridView` veut toute la hauteur dispo → infini. Solution : l'envelopper dans `Expanded`.

```dart
Column(children: [
  DotaTopBar(...),
  const Expanded(child: DotaCards()), // hauteur bornée = le reste de l'écran
])
```

---

## 4. Bloc / Cubit : la gestion d'état

### Le principe

```
 UI ──(appelle une méthode)──▶ Cubit ──emit(nouvelState)──▶ UI se reconstruit
```

L'UI ne modifie jamais l'état directement : elle demande au Cubit, qui **émet** un nouvel état.

### Cubit

```dart
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(10);          // état initial
  void increment() => emit(state + 1); // state = état courant
}
```

- `Cubit<T>` : `T` est le type de l'état (`int`, `List<DotaCard>`, une classe…).
- `emit(x)` publie un nouvel état. Si `x == state`, rien ne se passe.
- ≈ un **service Angular avec un `BehaviorSubject`** : `state` = `.value`, `emit` = `.next()`.

> L'état doit être **immuable** : on émet un nouvel objet, on ne modifie pas l'ancien. `state.add(x); emit(state);` ne déclenche **rien** (même référence). Fais `emit([...state, x])`.

### Bloc (le grand frère)

Même idée, mais l'UI envoie des **événements** au lieu d'appeler des méthodes :

```dart
bloc.add(IncrementPressed());   // au lieu de cubit.increment()
```

Plus verbeux, mais traçable (on voit chaque événement) et utile pour les flux complexes (debounce, annulation). **Commence par Cubit**, passe à Bloc si besoin.

---

## 5. Les widgets de flutter_bloc

### BlocProvider : fournir

Crée le Cubit et le rend accessible à **tous les widgets en dessous** dans l'arbre. Il le ferme (`close()`) automatiquement quand il disparaît.

```dart
BlocProvider(
  create: (_) => DotaCardsCubit(InMemoryDotaCardsRepository())..load(),
  child: const _HomeView(),
)
```

≈ `providers: [...]` d'un composant Angular, ou un bean Spring injecté dans un sous-arbre.
Le `..load()` (cascade) appelle `load()` puis renvoie le cubit lui-même.

### MultiBlocProvider : en fournir plusieurs

Évite d'imbriquer des `BlocProvider` :

```dart
MultiBlocProvider(
  providers: [
    BlocProvider(create: (_) => CounterCubit()),
    BlocProvider(create: (_) => DotaCardsCubit(...)..load()),
  ],
  child: const _HomeView(),
)
```

### BlocBuilder : afficher l'état

**Reconstruit son `builder` à chaque nouvel état émis.** C'est le widget que tu utiliseras le plus.

```dart
BlocBuilder<DotaCardsCubit, List<DotaCard>>(
  builder: (context, cards) {
    if (cards.isEmpty) return const CircularProgressIndicator();
    return GridView.builder(...);
  },
)
```

- 1er type générique : le Cubit à écouter (trouvé en remontant l'arbre).
- 2e type : le type de son état.
- `builder` doit être une **fonction pure** : elle renvoie de l'UI, rien d'autre (pas de navigation, pas de SnackBar, pas d'appel réseau).
- Seul le contenu du `BlocBuilder` est reconstruit, pas toute la page → place-le au plus près de ce qui change.
- ≈ `*ngIf="cards$ | async as cards"` en Angular.

Option `buildWhen` pour filtrer les rebuilds :

```dart
BlocBuilder<CounterCubit, int>(
  buildWhen: (previous, current) => current.isEven, // rebuild seulement si pair
  builder: (context, count) => Text('$count'),
)
```

### BlocListener : réagir une seule fois

Pour les **effets de bord** déclenchés par un changement d'état : naviguer, afficher une SnackBar, une boîte de dialogue. Il ne construit pas d'UI.

```dart
BlocListener<CounterCubit, int>(
  listenWhen: (prev, curr) => curr == 0,
  listener: (context, state) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Remis à zéro !')));
  },
  child: ...,
)
```

≈ un `.subscribe()` qui fait une action, sans affichage.

### BlocConsumer : les deux à la fois

`BlocBuilder` + `BlocListener` en un seul widget (`builder` + `listener`, `buildWhen` + `listenWhen`).

### BlocSelector : n'écouter qu'une partie de l'état

Reconstruit seulement si la valeur **sélectionnée** change.

```dart
BlocSelector<DotaCardsCubit, List<DotaCard>, int>(
  selector: (cards) => cards.length,
  builder: (context, count) => Text('$count héros'),
)
```

### Résumé : lequel choisir ?

| Je veux… | Widget |
|---|---|
| Créer / fournir un cubit | `BlocProvider` / `MultiBlocProvider` |
| Afficher l'état | `BlocBuilder` |
| Afficher une petite partie de l'état | `BlocSelector` |
| Naviguer, SnackBar, dialog quand l'état change | `BlocListener` |
| Afficher **et** réagir | `BlocConsumer` |

---

## 6. Accéder au Cubit depuis le code

| Écriture | Effet | Où l'utiliser |
|---|---|---|
| `context.read<CounterCubit>()` | Récupère le cubit **sans** écouter | Dans un `onPressed`, un callback |
| `context.watch<CounterCubit>()` | Récupère **et** rebuild le widget à chaque état | Dans `build()` (préfère `BlocBuilder`) |
| `context.select((CounterCubit c) => c.state.isEven)` | Rebuild seulement si la valeur choisie change | Dans `build()` |

```dart
IconButton(
  icon: const Icon(Icons.add),
  onPressed: () => context.read<CounterCubit>().increment(), // read, pas watch
)
```

> Règle : **`read` dans les callbacks, `watch` / `BlocBuilder` dans `build`.**

---

## 7. Architecture du projet (hexagonale)

```
lib/
├── domain/entities/      Entités pures (DotaCard) : aucun import Flutter
├── repositories/         Port (interface) + adaptateurs (InMemory, API…)
├── cubits/               Logique d'état, dépend du port, pas de l'adaptateur
├── widgets/              Composants réutilisables
└── screens/              Pages : branchent providers et widgets
```

- `DotaCardsRepository` = **port** (≈ interface Spring `@Repository`).
- `InMemoryDotaCardsRepository` = **adaptateur**. Demain : `OpenDotaCardsRepository` qui appelle `https://api.opendota.com/api/heroStats`, sans toucher au cubit ni à l'UI.
- Le cubit reçoit le repository par son constructeur = **injection de dépendance**.

---

## 8. Rappels Dart

| Syntaxe | Sens |
|---|---|
| `final` | Assigné une fois (à l'exécution) |
| `const` | Constante de compilation |
| `String?` | Peut être `null` (null safety) |
| `x!` | « Je garantis que ce n'est pas null » (plante sinon) |
| `x ?? 'défaut'` | Valeur par défaut si null |
| `required this.name` | Paramètre nommé obligatoire |
| `..methode()` | Cascade : appelle puis renvoie l'objet d'origine |
| `[...liste, x]` | Nouvelle liste (spread) |
| `if (cond) widget` dans une liste | Ajout conditionnel d'enfant |
| `switch (x) { A => ..., B => ... }` | Switch-expression, exhaustif sur un enum |
| `Future<T>` + `async`/`await` | ≈ `Promise` / `CompletableFuture` |
| `Stream<T>` | ≈ `Observable` RxJS |
