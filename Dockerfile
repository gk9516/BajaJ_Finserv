# Step 1: Set up the Backend with Python
FROM python:3.9 AS backend

WORKDIR /app
COPY requirements.txt .  # Copy requirements file for backend
RUN pip install -r requirements.txt  # Install Python dependencies

COPY app.py .  # Copy the backend code

# Step 2: Production Setup - Combine Frontend and Backend
FROM nginx:alpine AS production

# Copy frontend files directly to Nginx's web root
COPY frontend/index.html /usr/share/nginx/html/

# Copy backend code
COPY --from=backend /app /app/

# Copy Nginx configuration for frontend and backend routing
COPY nginx.conf /etc/nginx/nginx.conf

# Expose ports for Nginx (80) and Flask backend (5000)
EXPOSE 80 5000

# Start Flask backend and Nginx server
CMD ["sh", "-c", "python3 /app/app.py & nginx -g 'daemon off;'"]
