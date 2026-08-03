# CORRECCIÓN CONTENEDOR: Imagen base moderna y actualizada
FROM python:3.11-slim

WORKDIR /app

# Crear usuario no privilegiado
RUN useradd -m appuser

COPY app/ /app/
RUN pip install --no-cache-dir -r requirements.txt

# Cambiar a usuario no-root
USER appuser

# CORRECCIÓN IaC/Checkov: Añadir HEALTHCHECK
HEALTHCHECK --interval=30s --timeout=3s CMD curl -f http://localhost:8080/ || exit 1

EXPOSE 8080
CMD ["python", "app.py"]
