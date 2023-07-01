# python-license-checker-action
GitHub action to check licenses on python package dependencies.

If any license is found which isn't allowed (including missing licenses), the action will exit with code 1, thereby failing the build.

We recommend to put this action on pushes to your main branch, and pull requests to your main branch.

See the `entrypoint.sh` for configurable environment variables, things which can be controlled are:
* `ALLOWED_LICENSES` - a semicolon separated list of license names. Default is in `allowed-licenses.txt`.
* `ALL_OUTPUT_FILE` - where to put the CSV report of all discovered licenses. Defaults to `licenses.csv`. Consider making it a build artifact.
* `TARGET_DIR` - where you want the scan to run, instead of the root of the repo. Relative paths should work.
* `EXCLUDE_PACKAGES` - space separated list of pip packages to ignore scanning for licenses - use this if you have a package you know is OK, such as an internal dependency.
* `DO_PIP_INSTALL` - whether to automatically create a new python virtual env, and pip install the package in TARGET_DIR. Default: true

The arguments to [`pip-licenses`](https://github.com/raimon49/pip-licenses) can be overriden by adding args to the action.
