FROM quay.io/keycloak/keycloak:21.1.2

COPY jar/keycloakify-starter-keycloak-theme-4.7.3.jar /opt/keycloak/providers/keycloakify-starter-keycloak-theme-4.7.3.jar

RUN /opt/keycloak/bin/kc.sh build
