# Mesos CLI (+ others)

Mesos CLI is a light-weight tool for reading and interpreting the responses of various mesos http endpoints. It is written using bash 4, curl, and jq (1.5+).

Because it is so simple, many of the same command invocations to read data about a cluster can also be used against an unzipped DCOS diagnostic bundle.

The easiest way to use Mesos CLI is to use docker:

```
docker run --rm -it timcharper/mcli
```

By default, it assumes Marathon is running at `http://marathon.mesos:8080`, and Mesos at `http://leader.mesos:5050`. These can be changed modifying (and EXPORTING) the environment variables, seen in the section `Configuration`

# Provided tools

- `mesos-cli` - A tool for reading and interpreting Mesos HTTP responses (aliased `mcli`)
- `marathon-cli` - A tool for reading and interpreting Marathon HTTP responses

# Configuration

Several environment variables can be customized in order to specify credentials and URLs. To customize, use `export <VARNAME>=<VALUE>`; if you do not export the variable, then the mesos-cli tools will not see the value.

- `MARATHON_MASTER_URL` (default: http://marathon.mesos:8080)
- `MESOS_MASTER_URL` (default: http://leader.mesos:5050)
- `MARATHON_PRINCIPAL` - Basic auth username for marathon requests (default: none)
- `MARATHON_SECRET` - Basic auth password for marathon requests (default: none)
- `MESOS_PRINCIPAL` - Basic auth username for mesos requests (default: none)
- `MESOS_SECRET` - Basic auth password for mesos requests (default: none)

# Auto completion

Mesos CLI has extensive support for bash completion, supporting completion for both Marathon app IDs, task IDs, and Mesos task IDs. Try the following to get a sense of the support:

```
marathon-cli app <tab><tab>
marathon-cli app instance <tab><tab>
marathon-cli app list -c default,<tab><tab>
mesos-cli tasks -c default,<tab><tab>
mesos-cli task <tab><tab>
marathon-cli app list -<tab><tab>
```

# Launching

## Launching from OS X (without Docker)

You must first install jq, bash 4; homebrew is recommended.

```
brew install bash
brew install jq
# default version targets bash 3 and is too old
brew install bash-completion@2
```

Bash 4 must be linked to `/usr/local/bin/bash`; it may not be, by default. To link it:

```
brew link bash
```

From here, a helper utility exists for setting up a shell with the necessary environment variables:

```
<mesos-cli-path>/osx/shell
```

(this can be run with any current working directory; it is not necessary to cd to the mesos-cli path first)

## Launching from Linux

Prerequisites:

* jq (at least 1.5.0)
* bash-completion (at least version 2.8)
* bash (at least version 4)

From here, a helper utility exists for setting up a shell with the necessary environment variables:

```
<mesos-cli-path>/linux/shell
```

Since Mcli is just a collection of bash scripts; you can set the appropriate environment variables in your bashrc if you'd like to always keep it active, and use bash as your primary shell.

## Launching using Docker

Easy!

```
docker run --rm -it timcharper/mcli
```

Note: if using diagnostic bundles, you'll need to mount the bundle in to the container

# Diagnostic bundles

To use with a diagnostic bundle, first, initialize mcli.

Then, unzip the bundle

```
# note the bundle is unzipped to the current working directory; if you do not wish to clutter the current folder, create a new folder and put the zip file in it first
$ unzip bundle-xxxxx.zip
Unzipping ...
..
$ target-bundle
Master IP is 159.202.228.100
Marathon port is 8443

$ mcli tasks
id                                           host             state         started
task-1.6a6d9870-762e-11e7-87da-d6f4e6f28347  159.202.228.101  TASK_RUNNING  2017-07-31T20:25:44Z
task-2.f0b65f17-760f-11e7-a3c0-5276ce99eeb5  159.202.228.101  TASK_RUNNING  2017-07-31T16:47:46Z
```

# Targeting a DCOS cluster

If you have the dcos-cli configured to connect to your cluster, mesos-cli can piggy-back on top of this tool to authenticate itself and extract data over the publicly exposed admin-router.

```
$ target-dcos
```

If you are not using a trusted (by curl) cert, then you will either need to fix that, or turn off cert verification (not recommended):

```
$ auto-trust-cert
```


