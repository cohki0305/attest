defmodule Mix.Tasks.Attest.Gen.Html do
  require Mix.Phoenix.Schema
  alias Mix.Phoenix.{Context, Schema}
  use Mix.Task
  alias Mix.Tasks.Phx.Gen

  def run(args) do
    if Mix.Project.umbrella?() do
      Mix.raise "mix phx.gen.schema can only be run inside an application directory"
    end

    {context, schema} = Gen.Context.build(args)
    IO.inspect context
    binding = [context: context, schema: schema]

    paths = Attest.generator_paths()

    copy_new_files(schema, context, paths, binding)
  end

  def copy_new_files(schema, context, paths, binding) do
    copy_file_for_schema(schema, paths, binding)
    copy_file_for_migration(schema, paths, binding)
    copy_file_for_controller(schema, context, paths, binding)
    schema
  end

  defp copy_file_for_schema(schema, paths, binding) do
    Mix.Phoenix.copy_from paths, "priv/templates/attest.gen.schema", binding, [
      {:eex, "schema.ex", schema.file}
    ]
  end

  defp copy_file_for_migration(%Schema{context_app: ctx_app} = schema, paths, binding) do
    migration_path = Mix.Phoenix.context_app_path(ctx_app, "priv/repo/migrations/#{timestamp()}_create_#{schema.table}.exs")
    Mix.Phoenix.copy_from paths, "priv/templates/attest.gen.schema", binding, [
      {:eex, "migration.exs", migration_path},
    ]
  end

  defp copy_file_for_controller(%Schema{context_app: context_app}, %Context{basename: basename}, paths, binding) do
    web_prefix = Mix.Phoenix.web_path(context_app)
    Mix.Phoenix.copy_from paths, "priv/templates/attest.gen.controller", binding, [
      {:eex, "registartions_controller.ex", "#{web_prefix}/controllers/#{basename}/registartions_controller.ex"},
      {:eex, "sessions_controller.ex",      "#{web_prefix}/controllers/#{basename}/sessions_controller.ex"},
    ]
  end

  defp timestamp do
    {{y, m, d}, {hh, mm, ss}} = :calendar.universal_time()
    "#{y}#{pad(m)}#{pad(d)}#{pad(hh)}#{pad(mm)}#{pad(ss)}"
  end
  defp pad(i) when i < 10, do: << ?0, ?0 + i >>
  defp pad(i), do: to_string(i)
end
