# Use the official Python image
FROM python:3.9

# Set the working directory inside the container
WORKDIR /BajaJ_Finserv

# Copy the requirements and install them
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy the backend code and the frontend files (correct casing)
COPY app.py .
COPY Frontend/ Frontend/

# Expose the Flask port
EXPOSE 5000

# Run the Flask server
CMD ["python3", "app.py"]
