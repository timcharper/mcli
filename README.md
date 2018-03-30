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
- `md` - A Mesos/Marathon enriched docker task inspection tool with a silly name (aliased `dr`)

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
marathon-cli task <tab><tab>
marathon-cli apps -c default,<tab><tab>
mesos-cli tasks -c default,<tab><tab>
mesos-cli task <tab><tab>
marathon-cli apps -<tab><tab>
```

# Launching from OS X (without Docker)

## Setup

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

# Diagnostic bundles

To use with a diagnostic bundle:

```
# note the bundle is unzipped to the current working directory; create a new folder and put the zip file in first if you do not wish to clutter the current folder
$ unzip bundle-xxxxx.zip
Unzipping ...
..
$ docker run --rm -it -v $(pwd):/bundle timcharper/mcli

# inside of docker container
bash-4.3# cd /bundle
bash-4.3# target-bundle
Master IP is 159.202.228.100
Marathon port is 8443

bash-4.3# mcli tasks
id                                           host             state         started
task-1.6a6d9870-762e-11e7-87da-d6f4e6f28347  159.202.228.101  TASK_RUNNING  2017-07-31T20:25:44Z
task-2.f0b65f17-760f-11e7-a3c0-5276ce99eeb5  159.202.228.101  TASK_RUNNING  2017-07-31T16:47:46Z
```

(note you can do the same with the osx/shell command, also)

# Targeting a DCOS cluster

If you have the dcos-cli configured to connect to your cluster, mesos-cli can piggy-back on top of this tool to authenticate itself and extract data over the publicly exposed admin-router.

```
$ target-dcos
```

If you are not using a trusted (by curl) cert, then you will either need to fix that, or turn off cert verification (not recommended):

```
$ auto-trust-cert
```


