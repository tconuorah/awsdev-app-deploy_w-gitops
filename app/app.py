from flask import Flask, render_template

app = Flask(__name__)

@app.route("/")
def index():
    return render_template("index.html", title="Welcome 1%'ers to the final lab!")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)