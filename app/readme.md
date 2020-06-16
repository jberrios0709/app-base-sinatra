### Descripcion
Aplicacion base para desarrollo en sinatra

### Docker
Crear imagen:
```bash
docker build -t backend-app-base .
```

Iniciar el contenedor:
Ejecutar el script deploy.sh ubicado en la raiz del proyecto
```bash
sh deploy.sh
```

Conectarse al container: 
```bash
docker exec -it backend-app-base /bin/bash
```

### Crear migracion
```bash
bundle exec rake db:create_migration NAME=migration_name
bundle exec rake db:migrate
```

### Resetear migraciones
```bash
bundle exec rake db:drop
bundle exec rake db:create
bundle exec rake db:migrate
```

### Correr seeds
```bash
bundle exec rake db:seed
```