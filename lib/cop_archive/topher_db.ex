defmodule CopArchive.TopherDB do
  alias CopArchive.Repo
  # alias Ecto.Query, as: Q

  defmacro __using__(opts) do
    quote do
      require Ecto.Query

      # def get(list) when is_list(list),
      #   do: raise("Can't pass a list to get, did you mean get_by?")

      # def get!(list) when is_list(list),
      #   do: raise("Can't pass a list to get!, did you mean get_by!?")

      def get(id, filt \\ []), do: get_by(Keyword.merge([id: id], filt))
      def get!(id, filt \\ []), do: get_by!(Keyword.merge([id: id], filt))
      def get_by(filt), do: __MODULE__ |> apply_clauses(filt) |> Repo.first()
      def get_by!(filt), do: __MODULE__ |> apply_clauses(filt) |> Repo.first!()
      def all(filt \\ []), do: __MODULE__ |> apply_clauses(filt) |> Repo.all()
      def count(filt \\ []), do: __MODULE__ |> apply_clauses(filt) |> Repo.count()

      # def test(filt), do: __MODULE__ |> apply_clauses(filt) # Generate query structure but don't execute

      def apply_clause(query, :preload, preloads), do: Ecto.Query.preload(query, ^preloads)

      def apply_clauses(starting_query, clauses) do
        missing = unquote(opts[:required_clauses] || []) -- Keyword.keys(clauses)

        if Enum.any?(missing) do
          raise "Query is missing required clause(s): #{inspect(missing)}"
        end

        Enum.reduce(clauses, starting_query, fn {k, v}, query ->
          apply_clause(query, k, v)
        end)
      end
    end
  end
end
