all: setup

setup: venv

activate:
	echo '. venv/bin/activate' | xclip -sel clip

venv:
	python3 -m venv venv
	echo '. venv/bin/activate && pip install numpy matplotlib scikit-image signal scipy' | xclip -sel clip

clean:
	rm -rf venv

.phony: all clean setup activate
