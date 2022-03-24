from src import app


def test_app_wo_args(capfd):
    app.run()

    out, err = capfd.readouterr()
    assert out == "Hello World!\n"


def test_app_w_arg(capfd):
    app.run("Giacomo")

    out, err = capfd.readouterr()
    assert out == "Hello Giacomo!\n"
