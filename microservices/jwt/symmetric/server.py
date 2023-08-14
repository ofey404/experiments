from flask import Flask, request, jsonify, make_response
from functools import wraps
import jwt
import datetime
from werkzeug.security import generate_password_hash, check_password_hash

app = Flask(__name__)
app.config["SECRET_KEY"] = "Th1s1ss3cr3t"

users = {"test": generate_password_hash("test")}


def token_required(f):

    @wraps(f)
    def decorator(*args, **kwargs):
        token = None

        if "x-access-tokens" in request.headers:
            token = request.headers["x-access-tokens"]

        if not token:
            return jsonify({"message": "a valid token is missing"})

        try:
            data = jwt.decode(token, app.config["SECRET_KEY"], algorithms=["HS256"])
            current_user = users.get(data["username"])
        except Exception as e:
            print("Error: ", e)
            return jsonify({"message": "token is invalid"})

        return f(current_user, *args, **kwargs)

    return decorator


@app.route("/protected", methods=["GET"])
@token_required
def protected_route(current_user):
    return jsonify({"message": f"Hello {current_user}, you are viewing a protected endpoint!"})


@app.route("/login", methods=["GET", "POST"])
def login():
    auth = request.authorization

    if not auth or not auth.username or not auth.password:
        return make_response(
            "could not verify",
            401,
            {"WWW.Authentication": 'Basic realm: "login required"'},
        )

    user = users.get(auth.username)

    if check_password_hash(user, auth.password):
        token = jwt.encode(
            {
                "username": auth.username,
                "exp": datetime.datetime.utcnow() + datetime.timedelta(minutes=30),
            },
            app.config["SECRET_KEY"],
        )
        return jsonify({"token": token})

    return make_response("could not verify", 401, {"WWW.Authentication": 'Basic realm: "login required"'})


if __name__ == "__main__":
    app.run(
        host="0.0.0.0",
        debug=True,
    )
