# 1. Image de base minimale (Alpine Linux + Nginx)
FROM nginx:alpine

# 2. Copier notre page web personnalisee
COPY index.html /usr/share/nginx/html/index.html

# 3. DevSecOps Best Practice : Ajuster les permissions pour un utilisateur non-root
RUN touch /var/run/nginx.pid && \
    chown -R nginx:nginx /var/run/nginx.pid /var/cache/nginx /var/log/nginx /usr/share/nginx/html

# 4. Basculer sur l'utilisateur non-privilégie 'nginx'
USER nginx

# 5. Exposer le port par defaut
EXPOSE 80

# 6. Commande de démarrage
CMD ["nginx", "-g", "daemon off;"]
