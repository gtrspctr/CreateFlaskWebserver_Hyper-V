from website import create_app

# Initialize webserver app
app = create_app()

# Run webserver
if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True, port=8000)