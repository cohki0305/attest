# Attest

## Installation

```elixir
def deps do
  [
    {:attest, "~> 0.1.0"}
  ]
end
```

## Get Started

### Generate schema, migration and controller, etc.

You can generate following files by one command.
 - schema
 - migration
 - controller
 - view
 - template

```
mix attest.gen.html UserPage User users
```

The first argument is the context module.
The second argument is the schema module.
The third argument is the table name of schema.

## Change config.exs

add following code in `config.exs`

```elixir
config :attest,
  repo: SampleApp.Repo,
  schema_name: SampleApp.UserPage.User
```

`schema_name` must be the one you create by the command.

## Setup router

```diff
# router.ex

defmodule SampleAppWeb.Router do
  use SampleAppWeb, :router
+ use Attest.RouterHelper
  ...

  scope "/", SampleAppWeb do
    pipe_through :browser # Use the default browser stack
+   attest_for :user_page

    get "/", PageController, :index
  end


end
```

## helper methods

```elixir
# if you logged as user, you can use the following method.
current_user

# you can check whether you logged in as the resource
user_logged_in?
```
