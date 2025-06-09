from flask import Flask, jsonify, session, request
from flask_cors import CORS
from flask_session import Session
import time
import uuid

# --- App Configuration ---
app = Flask(__name__)
# IMPORTANT: Change this secret key in a real application!
app.config["SECRET_KEY"] = "a_different_super_secret_key"
app.config["SESSION_TYPE"] = "filesystem"
CORS(app, supports_credentials=True)
Session(app)

# --- In-Memory Data Store ---
# Job listings are now more distinct to show differences in orders.
JOBS = [
    {
        "id": "job_1",
        "jobGiver": "Toko Roti Enak",
        "posted": "1 hour ago",
        "address": "Jl. Mawar No. 12, Jakarta",
        "dropAt": "Jl. Melati No. 34, Jakarta",
        "deadline": "15/09/2025",
        "priceOffer": "Rp 35,000",
    },
    {
        "id": "job_2",
        "jobGiver": "Warung Kopi Senja",
        "posted": "8 hours ago",
        "address": "Jl. Soekarno-Hatta No. 101, Bandung",
        "dropAt": "Jl. Asia Afrika No. 55, Bandung",
        "deadline": "18/09/2025",
        "priceOffer": "Rp 42,000",
    },
]

ORDERS = {}

# --- API Endpoints ---
@app.route("/api/jobs", methods=["GET"])
def get_jobs():
    return jsonify(JOBS)

@app.route("/api/orders", methods=["GET"])
def get_orders():
    session_id = session.sid
    user_orders = ORDERS.get(session_id, [])
    return jsonify(user_orders)

@app.route("/api/apply/<job_id>", methods=["POST"])
def apply_for_job(job_id):
    session_id = session.sid
    if session_id not in ORDERS:
        ORDERS[session_id] = []

    # Check for existing active jobs
    active_jobs = [o for o in ORDERS[session_id] if o.get('status') in ['Pending', 'Accepted']]
    if active_jobs:
        return jsonify({"error": "You already have an active job. Please resign first."}), 409

    job = next((job for job in JOBS if job["id"] == job_id), None)
    if not job:
        return jsonify({"error": "Job not found"}), 404

    new_order = {
        "orderId": str(uuid.uuid4()),
        "jobDetails": job,
        "status": "Pending",
        "createdAt": time.time(),
    }
    ORDERS[session_id].append(new_order)
    return jsonify(new_order), 201

@app.route("/api/orders/<order_id>/update", methods=["POST"])
def update_order_status(order_id):
    session_id = session.sid
    user_orders = ORDERS.get(session_id, [])
    for order in user_orders:
        if order["orderId"] == order_id:
            if order["status"] == "Pending":
                order["status"] = "Accepted"
            elif order["status"] == "Accepted":
                order["status"] = "Completed"
            return jsonify(order)
    return jsonify({"error": "Order not found"}), 404

@app.route("/api/orders/<order_id>/resign", methods=["POST"])
def resign_from_job(order_id):
    session_id = session.sid
    user_orders = ORDERS.get(session_id, [])
    order_to_remove = next((o for o in user_orders if o['orderId'] == order_id), None)
    if order_to_remove:
        ORDERS[session_id].remove(order_to_remove)
        return jsonify({"message": "Successfully resigned from job."}), 200
    return jsonify({"error": "Order not found"}), 404

if __name__ == "__main__":
    app.run(debug=True)