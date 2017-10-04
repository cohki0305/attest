defmodule Mix.Tasks.Attest.Gen.Schema do
  require Mix.Phoenix.Schema
  alias Mix.Phoenix.Schema
  use Mix.Task

  def run(args) do
    if Mix.Project.umbrella?() do
      Mix.raise "mix phx.gen.schema can only be run inside an application directory"
    end

    {_, args, _} = OptionParser.parse(args)
    if length(args) >= 3, do: raise_with_help()
    [schema_name, plural | _] = validate_args!(args)

    schema = Schema.new(schema_name, plural, [], [])
    paths = Attest.generator_paths()

    schema
    |> copy_new_files(paths, schema: schema)
  end

  def copy_new_files(%Schema{context_app: ctx_app} = schema, paths, binding) do
    migration_path = Mix.Phoenix.context_app_path(ctx_app, "priv/repo/migrations/#{timestamp()}_create_#{schema.table}.exs")
    Mix.Phoenix.copy_from paths, "priv/templates/attest.gen.schema", binding, [
      {:eex, "migration.exs", migration_path},
    ]

    schema
  end

  defp validate_args!([_, plural | _] = args) do
    cond do
      plural != Phoenix.Naming.underscore(plural) ->
        Mix.raise "Expectded the second argument, #{inspect plural}, to be all lowercase using snake_case convention"
      true ->
        args
    end
  end

  defp raise_with_help do
    Mix.raise """
    mix attest.gen.model expects both singular and plural names
    of the generated resource followed by any number of attributes:

        mix phoenix.gen.model User users name:string
    """
  end

  defp timestamp do
    {{y, m, d}, {hh, mm, ss}} = :calendar.universal_time()
    "#{y}#{pad(m)}#{pad(d)}#{pad(hh)}#{pad(mm)}#{pad(ss)}"
  end
  defp pad(i) when i < 10, do: << ?0, ?0 + i >>
  defp pad(i), do: to_string(i)
end
