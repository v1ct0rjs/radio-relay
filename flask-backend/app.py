from flask import Flask, request
import socket

app = Flask(__name__)

@app.route("/stream", methods=["POST"])
def update_stream():
    data = request.get_json(force=True)
    new_url = data.get("url")
    if not new_url:
        return {"error": "URL missing"}, 400

    try:
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.connect(("localhost", 1234))
            s.sendall(f"url.set {new_url}\n".encode())
    except Exception as e:
        return {"error": str(e)}, 500

    return {"message": "Stream actualizado correctamente"}, 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)