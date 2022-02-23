#!/bin/bash

# Regenerate settings.json with Poetry environment folder
# by using the absolute path instead of the relative one

env_path=$(poetry env info --path)

echo $env

echo "{
    \"python.pythonPath\": \"${env_path}/bin/python\",
    \"python.languageServer\": \"Pylance\",
    \"python.linting.mypyPath\": \"${env_path}/bin/mypy\",
	\"python.linting.flake8Path\": \"${env_path}/bin/flake8\",
	\"python.linting.mypyEnabled\": true,
	\"python.linting.flake8Enabled\": true,
    \"python.linting.pylintEnabled\": false,
    \"python.linting.pycodestyleEnabled\": false,
    \"python.formatting.blackPath\": \"${env_path}/bin/black\",
    \"python.formatting.provider\": \"black\",
	\"python.formatting.blackArgs\": [\"--line-length\", \"79\"],
    \"python.testing.pytestPath\": \"${env_path}/bin/pytest\",
    \"python.testing.unittestEnabled\": false,
    \"python.testing.pytestEnabled\": true,
    \"python.testing.pytestArgs\": [
        \"tests\"
    ],
    \"[python]\": {
        \"editor.formatOnSave\": true,
        \"editor.formatOnPaste\": false,
        \"editor.rulers\": [72, 79]
    }
}" > settings.json
