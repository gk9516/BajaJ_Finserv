from flask import Flask, request, jsonify, send_from_directory
from flask_cors import CORS
import os

app = Flask(__name__, static_folder='frontend')
CORS(app)

# Route to serve the frontend
@app.route('/')
def serve_frontend():
    return send_from_directory(app.static_folder, 'index.html')

# API route for data processing
@app.route('/bfhl', methods=['POST'])
def process_data():
    try:
        data = request.json.get('data')
        if not data:
            return jsonify({"is_success": False, "message": "No data provided"}), 400

        user_id = "ganeshk_02042004"
        email = "ganeshrajan2.00@gmail.com"
        roll_number = "RA2111003010298"

        numbers = [item for item in data if item.isdigit()]
        alphabets = [item for item in data if item.isalpha()]
        highest_alphabet = sorted(alphabets, key=lambda x: x.lower(), reverse=True)[:1]

        return jsonify({
            "is_success": True,
            "user_id": user_id,
            "email": email,
            "roll_number": roll_number,
            "numbers": numbers,
            "alphabets": alphabets,
            "highest_alphabet": highest_alphabet
        })

    except Exception as e:
        return jsonify({"is_success": False, "message": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
