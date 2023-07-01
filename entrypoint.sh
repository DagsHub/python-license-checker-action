#!/bin/bash
set -e
set -x # TODO: remove

script_dir="$(dirname "$0")"
default_allowed_licenses="$script_dir/allowed-licenses.txt"

# Default to file if not specified
ALLOWED_LICENSES="${ALLOWED_LICENSES:-$(cat $default_allowed_licenses | tr '\n' ';'| sed 's/;$//')}"
echo "Allowed licenses: $ALLOWED_LICENSES"

TARGET_DIR=${TARGET_DIR:-.}
cd "$TARGET_DIR"

if [ "${DO_PIP_INSTALL:-true}" = "true" ]; then
    eval "${PIP_INSTALL_CMD:-python3 -m venv myenv && source myenv/bin/activate && pip install -r requirements.txt }"
fi

IGNORE_PKGS_ARGS=("--ignore-packages" "pip-licenses" "pipdeptree")
if [ -n "$IGNORE_PACKAGES" ]; then
    # Split string_variable by semicolon into an array
    IFS=";" read -ra new_elements <<< "$IGNORE_PACKAGES"
    IGNORE_PKGS_ARGS+=("${new_elements[@]}")
else

fi

ALL_OUTPUT_FILE="${ALL_OUTPUT_FILE:-licenses.csv}"
DISALLOWED_OUTPUT_FILE="${DISALLOWED_OUTPUT_FILE:-disallowed-licenses.csv}"

if [ "${RUN_PIPDEPTREE:-true}" = "true" ]; then
    pip install pipdeptree
    pipdeptree
fi

pip install pip-licenses

set -x
pip-licenses ${*:---format csv --with-urls "${IGNORE_PKGS_ARGS[@]}" } | tee "$ALL_OUTPUT_FILE"
pip-licenses ${*:---format csv --with-urls --allow-only "$ALLOWED_LICENSES" "${IGNORE_PKGS_ARGS[@]}" }
set +x
