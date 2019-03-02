defmodule BaltimoreAiWeb.ListingControllerTest do
  use BaltimoreAiWeb.ConnCase

  alias BaltimoreAi.Jobs

  @create_attrs %{
    description: Faker.Lorem.sentence(),
    location: Faker.Address.city(),
    job_place: Enum.random(["remote", "onsite"]),
    job_type: Enum.random(["full-time", "part-time", "contract"]),
    external_url: Faker.Internet.url(:safe),
    title: Faker.Name.title(),
    published_at: Faker.Date.forward(1..5),
    slug: Faker.Internet.user_name()
  }

  @update_attrs %{
    description: Faker.Lorem.sentence(),
    location: Faker.Address.city(),
    job_place: Enum.random(["remote", "onsite"]),
    job_type: Enum.random(["full-time", "part-time", "contract"]),
    external_url: Faker.Internet.url(:safe),
    title: Faker.Name.title(),
    published_at: Faker.Date.forward(1..5),
    slug: Faker.Internet.user_name()
  }
  @invalid_attrs %{
    description: nil,
    location: nil,
    job_place: nil,
    job_type: nil,
    external_url: nil,
    title: nil,
    published_at: nil,
    slug: nil
  }

  setup do
    {:ok, conn: conn, user: user} = authenticated_session()

    listing = insert(:listing, poster: user)

    {:ok, %{conn: conn, listing: listing}}
  end

  describe "index" do
    test "lists all listings", %{conn: conn} do
      conn = get(conn, Routes.listing_path(conn, :index))
      assert html_response(conn, 200) =~ "There is nothing here"
    end
  end

  describe "new listing" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.listing_path(conn, :new))
      assert html_response(conn, 200) =~ "Publishing a listing on Baltimore AI is free"
    end
  end

  describe "create listing" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.listing_path(conn, :create), listing: @create_attrs)

      assert %{slug_or_id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.listing_path(conn, :show, id)

      conn = get(conn, Routes.listing_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Listing"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.listing_path(conn, :create), listing: @invalid_attrs)
      assert length(conn.assigns.changeset.errors) == 3
    end
  end

  describe "edit listing" do
    test "renders form for editing chosen listing", %{conn: conn, listing: listing} do
      conn = get(conn, Routes.listing_path(conn, :edit, listing))
      assert html_response(conn, 200) =~ "Edit Listing"
    end
  end

  describe "update listing" do
    test "redirects when data is valid", %{conn: conn, listing: listing} do
      conn = put(conn, Routes.listing_path(conn, :update, listing), listing: @update_attrs)
      assert redirected_to(conn) == Routes.listing_path(conn, :show, listing)

      conn = get(conn, Routes.listing_path(conn, :show, listing))
      assert html_response(conn, 200) =~ @update_attrs.description
    end

    test "renders errors when data is invalid", %{conn: conn, listing: listing} do
      conn = put(conn, Routes.listing_path(conn, :update, listing), listing: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Listing"
    end
  end

  describe "delete listing" do
    test "deletes chosen listing", %{conn: conn, listing: listing} do
      conn = delete(conn, Routes.listing_path(conn, :delete, listing))
      assert redirected_to(conn) == Routes.listing_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.listing_path(conn, :show, listing))
      end
    end
  end
end
