defimpl Canada.Can, for: BaltimoreAi.Accounts.User do

  alias BaltimoreAi.Jobs.Listing
  alias BaltimoreAi.Accounts.User
  alias BaltimoreAi.Companies.Company
  alias BaltimoreAi.Repo

  import Ecto.Query

  def can?(%User{id: id}, action, %Listing{poster_id: poster_id}) when action in [:edit, :update, :delete] do
    id == poster_id
  end

  def can?(%User{id: _id}, action, %User{id: _user_id}) when action in [:edit, :update, :delete] do
    # it seems like that it doesn't work when subject and resource is a user struct
    # let's just deny access to these actions for now as we don't intend to give such abilities
    # to users at the moment.
    false
  end

  def can?(%User{id: id}, action, %Company{} = company) when action in [:edit, :update, :delete] do
    # checks if company is associate with any job offers posted by the current user
    query =
      from(l in Listing,
        where: l.poster_id == ^id,
        where: l.company_id == ^company.id
      )

    Repo.all(query) != []
  end

end
