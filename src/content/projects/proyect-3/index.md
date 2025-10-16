---
title: 'MCP Libres - Colección Completa de MCPs Útiles'
image: '../images/project//mcp_libres_logo.svg'
summary: 'Colección completa de Model Context Protocols (MCPs) desarrollados con FastMCP para diferentes tareas útiles y productivas'
draft: false
isInConstruction: false
isFeatured: true
tags:
  - Python
  - FastMCP
  - MCP
  - Open Source
  - Tools
  - Automation
demoUrl: https://github.com/carvaj10/mcp_libres
repoUrl: https://github.com/carvaj10/mcp_libres
---

¡Bienvenido a MCP Libres! Esta es una colección completa de Model Context Protocols (MCPs) desarrollados con FastMCP que proporciona herramientas útiles y productivas para diferentes tareas de desarrollo y automatización.

## Descripción

MCP Libres es un proyecto de código abierto que ofrece una suite completa de MCPs diseñados para mejorar la productividad y automatizar tareas comunes en el desarrollo de software. Cada MCP está desarrollado con FastMCP para máxima compatibilidad y rendimiento.

## Características Principales

- **11 MCPs especializados**: Cada uno enfocado en un área específica de funcionalidad
- **Código abierto**: Licencia MIT para uso libre y contribuciones
- **Fácil instalación**: Soporte para uv y pip
- **Documentación completa**: Cada herramienta está bien documentada
- **Compatibilidad multiplataforma**: Windows, macOS y Linux
- **Integración con Claude Desktop**: Configuración lista para usar

## MCPs Disponibles

### 📁 File Manager MCP

Gestión completa de archivos y directorios:

- Lectura y escritura de archivos de texto
- Manejo de archivos JSON y CSV
- Operaciones de directorios recursivos
- Información detallada de archivos

### 📝 Text Processor MCP

Análisis y procesamiento de texto:

- Análisis estadístico de texto
- Extracción de emails, URLs y números de teléfono
- Detección de idioma
- Resúmenes automáticos
- Cálculo de similitud entre textos

### 🖼️ Image Processor MCP

Manipulación y procesamiento de imágenes:

- Redimensionado y conversión de formatos
- Aplicación de filtros y ajustes
- Recorte y rotación
- Creación de miniaturas
- Conversión a base64

### ⚙️ System Info MCP

Información del sistema y procesos:

- Información de CPU, memoria y disco
- Procesos en ejecución
- Información de red y batería
- Variables de entorno
- Ejecución de comandos del sistema

### 🌐 Web Utils MCP

Utilidades web y HTTP:

- Peticiones GET y POST
- Descarga de archivos
- Validación de URLs
- Codificación/decodificación base64
- Acortamiento de URLs

### 📊 Data Analysis MCP

Análisis estadístico y procesamiento de datos:

- Estadísticas básicas y análisis de frecuencia
- Detección de valores atípicos
- Cálculo de correlaciones
- Normalización de datos
- Análisis de tendencias

### 🔐 Security MCP

Herramientas de seguridad y criptografía:

- Generación de contraseñas seguras
- Cifrado y descifrado de texto
- Verificación de fortaleza de contraseñas
- Generación de claves criptográficas
- Sanitización de entrada de usuario

### 📅 Date Time MCP

Manejo avanzado de fechas y tiempo:

- Parseo de fechas en diferentes formatos
- Cálculo de diferencias entre fechas
- Conversión entre zonas horarias
- Obtención de días festivos
- Programación de recordatorios

### 🗃️ Database MCP

Operaciones con bases de datos:

- Conexión a múltiples tipos de bases de datos
- Ejecución de consultas SQL
- Respaldos y restauración
- Optimización de bases de datos
- Exportación e importación de datos

### 📧 Email MCP

Gestión de correo electrónico:

- Envío y lectura de emails
- Validación de direcciones
- Extracción de adjuntos
- Filtrado de emails
- Creación de plantillas

### 🎨 Color MCP

Herramientas de color y diseño:

- Conversión entre formatos de color
- Generación de paletas
- Cálculo de contraste
- Colores seguros para daltónicos
- Extracción de colores de imágenes

## Tecnologías Utilizadas

- **Python 3.11+**: Lenguaje principal de desarrollo
- **FastMCP**: Framework principal para MCPs
- **aiofiles**: Operaciones de archivos asíncronas
- **Pillow**: Procesamiento de imágenes
- **psutil**: Información del sistema
- **aiohttp**: Peticiones HTTP
- **cryptography**: Criptografía y seguridad
- **python-dateutil**: Manejo de fechas
- **numpy**: Análisis numérico
- **pymysql**: Conexión a MySQL
- **psycopg2-binary**: Conexión a PostgreSQL

## Instalación y Configuración

### Instalación con uv (Recomendado)

```bash
# Clonar el proyecto
git clone https://github.com/carvaj10/mcp_libres.git
cd mcp_libres

# Instalar dependencias
uv sync

# Ejecutar un MCP específico
uv run file_manager_mcp/main.py
uv run text_processor_mcp/main.py
uv run security_mcp/main.py
```

### Configuración en Claude Desktop

```json
{
  "mcpServers": {
    "file-manager-mcp": {
      "command": "uv",
      "args": ["--directory", "/ruta/a/tu/proyecto/mcp_libres", "run", "file_manager_mcp/main.py"]
    },
    "text-processor-mcp": {
      "command": "uv",
      "args": ["--directory", "/ruta/a/tu/proyecto/mcp_libres", "run", "text_processor_mcp/main.py"]
    }
  }
}
```

## Casos de Uso

### Desarrollo de Software

- Automatización de tareas de desarrollo
- Análisis de código y documentación
- Gestión de archivos de proyecto
- Procesamiento de datos de testing

### Análisis de Datos

- Procesamiento estadístico
- Detección de patrones
- Normalización de datasets
- Generación de reportes

### Seguridad y Criptografía

- Generación de contraseñas seguras
- Cifrado de datos sensibles
- Verificación de integridad
- Sanitización de entradas

### Automatización de Tareas

- Procesamiento de imágenes en lote
- Envío automatizado de emails
- Gestión de bases de datos
- Monitoreo del sistema

## Contribuciones

El proyecto está abierto a contribuciones de la comunidad. Cada MCP está diseñado para ser extensible y fácil de mantener, permitiendo que los desarrolladores agreguen nuevas funcionalidades o mejoren las existentes.

### Cómo Contribuir

1. Fork del repositorio
2. Crear una rama para tu feature
3. Implementar las mejoras
4. Enviar un pull request
5. Revisión y merge

## Impacto en la Comunidad

MCP Libres ha sido diseñado para ser una herramienta de referencia en el ecosistema de MCPs, proporcionando:

- **Estandarización**: Patrones consistentes para el desarrollo de MCPs
- **Documentación**: Ejemplos claros y documentación completa
- **Reutilización**: Componentes que pueden ser utilizados en otros proyectos
- **Educación**: Recursos para aprender sobre el desarrollo de MCPs

## Próximas Actualizaciones

- Integración con más servicios en la nube
- Mejoras en el rendimiento y optimización
- Nuevos MCPs especializados
- Interfaz web para gestión de MCPs
- Sistema de plugins para extensibilidad

## Licencia

Este proyecto está bajo la licencia MIT, permitiendo su uso libre en proyectos comerciales y no comerciales.

---

_MCP Libres representa un esfuerzo continuo para democratizar el acceso a herramientas de automatización y productividad, proporcionando una base sólida para el desarrollo de aplicaciones más eficientes y automatizadas._
