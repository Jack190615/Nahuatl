# Náhuatl Clásico — App Móvil de Aprendizaje (Flutter + Drift FTS5 + Riverpod + AutoRoute)

Aplicación móvil estilo Duolingo para el aprendizaje estructurado de **Náhuatl Clásico**, diseñada bajo **Clean Architecture**, **Principios SOLID**, **Patrón Repositorio** e interfaz **100% responsiva** para teléfonos y tabletas (Android en Etapa 1 y preparada para iOS).

---

## Arquitectura y Stack Técnico

- **Framework**: Flutter (Dart 3).
- **Base de Datos Local**: `Drift` (SQLite) con índice nativo **FTS5** (`dictionary_fts`) y triggers automáticos de sincronización.
- **Gestión de Estado e Inyección de Dependencias**: `flutter_riverpod`.
- **Navegación Declarativa Tipada**: `auto_route`.
- **Configuración de Entorno**: `flutter_dotenv` con archivo `.env` en la raíz del proyecto (`/.env`).

---

## Ubicación y Estructura de los Archivos `.json` (Seeding Local y Futuro Backend)

Todos los archivos `.json` con la información lingüística residen en:

```text
assets/data/
├── lessons.json          # Catálogo de lecciones y orden de desbloqueo
├── grammar_rules.json    # Explicaciones gramaticales asociadas a cada lección
├── dictionary.json       # Vocabulario en Náhuatl, traducción, categoría gramatical y ruta de audio
├── phrases.json          # Oraciones para los constructores (Word Bank) y traducción libre
└── initial_seed.json     # Respaldo unificado con las 4 colecciones
```

Durante la primera instalación, [`DatabaseSeederService`](lib/data/datasources/local/database_seeder_service.dart) lee estos archivos y ejecuta un **Batch Insert transaccional** en SQLite/Drift. Cuando la infraestructura migre a una base de datos remota, estos mismos archivos `.json` conservan exactamente la estructura relacional (`id`, `lesson_id`, `grammar_rule_id`, `audio_path`) para importarse en PostgreSQL/MySQL/Supabase y servirse mediante [`ApiNahuatlRepository`](lib/data/repositories/api_nahuatl_repository_stub.dart).

---

## Comandos de Inicialización y Ejecución

```bash
# 1. Crear carpetas nativas de Android e iOS (si se clona sólo el código Dart)
flutter create --platforms=android,ios --project-name nahuatl_clasico_app .

# 2. Copiar archivo de variables de entorno en la raíz
cp .env.example .env

# 3. Instalar dependencias
flutter pub get

# 4. Generar código de Drift y AutoRoute
dart run build_runner build --delete-conflicting-outputs

# 5. Ejecutar pruebas automatizadas
flutter test
```
