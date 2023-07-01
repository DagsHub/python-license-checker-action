# node-license-checker-action
GitHub action to check licenses on node module dependencies.

If any license is found which isn't allowed (including missing licenses), the action will exit with code 1, thereby failing the build.

We recommend to put this action on pushes to your main branch, and pull requests to your main branch.

**The action assumes the code is already checked out and `node_modules` was already downloaded** - so preface this action with `actions/checkout` and `npm ci --ignore-scripts` to fetch `node-modules`.

See the `entrypoint.sh` for configurable environment variables, things which can be controlled are:
* `ALLOWED_LICENSES` - a comma separated list of license names. Default is in `allowed-licenses.txt`.
* `ALL_OUTPUT_FILE` - where to put the CSV report of all discovered licenses. Defaults to `licenses.csv`. Consider making it a build artifact.
* `DISALLOWED_OUTPUT_FILE` - where to put the CSV report of disallowed licenses. Defaults to `disallowed-licenses.csv`. Consider making it a build artifact.
* `TARGET_DIR` - where you want the scan to run, instead of the root of the repo. Relative paths should work.
* `EXCLUDE_PACKAGES` - semicolon separated list of npm packages to ignore scanning for licenses - use this if you have a package you know is OK, such as an internal dependency.
* `DO_NPM_INSTALL` - whether to automatically download node_modules to TARGET_DIR. Default: true
* `NPM_INSTALL_CMD` - command used to download node_modules. Default: `npm ci --ignore-scripts`. Sometimes, you might change it to `yarn install` or `npm install --ignore-scripts`

The arguments to [`license-checker-rseidelsohn`](https://github.com/RSeidelsohn/license-checker-rseidelsohn) can be overriden by adding args to the action.
