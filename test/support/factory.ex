defmodule BaltimoreAi.Factory do

  use ExMachina.Ecto, repo: BaltimoreAi.Repo

  alias FakerElixir, as: Faker

  def user_factory do
    %BaltimoreAi.Accounts.User{
      first_name: Faker.Name.first_name(),
      last_name: Faker.Name.last_name(),
      email: Faker.Internet.email(),
      hashed_password: "$2b$12$HaSA5EZeWPmBzynzOU.7cutROZ.5wRqM/zJwu3kWACWUZbZ7JdKwi"
    }
  end

  def listing_factory do
    %BaltimoreAi.Jobs.Listing{
      description: Faker.Lorem.sentence(),
      location: Faker.Address.city(),
      job_place: Enum.random(["remote", "onsite"]),
      job_type: Enum.random(["full-time", "part-time", "contract"]),
      external_url: Faker.Internet.url(:safe),
      title: Faker.Name.title(),
      published_at: Faker.Date.forward(1..5),
      slug: Faker.Internet.user_name(),
      poster: build(:user)
    }
  end

  def company_factory do
    %BaltimoreAi.Companies.Company{
      name: Faker.App.name(),
      description: Faker.Lorem.sentence(),
      slug: Faker.Internet.user_name()
    }
  end
end
