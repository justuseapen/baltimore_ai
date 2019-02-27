# BaltimoreAi

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Nanobox Setup

### System Requirements

- [Docker](https://docs.docker.com/engine/installation/linux/)
- Add your user to the docker group ([instructions](https://docs.docker.com/engine/installation/linux/linux-postinstall/))

### Download the Nanobox Package

Download the Nanobox package appropriate for your Linux distribution from the [Nanobox downloads page](https://dashboard.nanobox.io/download). Unpack and install the package as you normally install packages in your specific distro.

After having the Nanobox Package installed, you can build the project with:

```
$ nanobox run
```

### Run & Setup Nanobox

The first time you run any Nanobox command, it will walk you through an initial setup process specifying options for your local environment. The first question it will ask you is how you would like to run Nanobox. Select the `Via Docker Native` option.

### Add a local DNS

Add a convenient way to access your app from the browser:

```
nanobox dns add local phoenix.local
```

### Start Hacking!

With Nanobox installed, the [Getting Started Guides](https://guides.nanobox.io/) walk you through getting popular languages and frameworks up and running with Nanobox.

### Environment variables

To add environment variables to production:

```
$ nanobox evar add remote PORT=8080
```

To add environment variables to your local environment:

```
$ nanobox evar add local PORT=8080
```

To list local variables:

```
$ nanobox evar ls local
```

## Deploy your app

### Add a remote

```
$ nanobox remote add baltimore-ai
```

### Deploy

```
$ nanobox deploy
```

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
