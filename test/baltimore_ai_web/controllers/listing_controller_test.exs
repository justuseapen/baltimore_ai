defmodule BaltimoreAiWeb.ListingControllerTest do
  use BaltimoreAiWeb.ConnCase

  alias BaltimoreAi.Jobs

  @create_attrs %{description: "some description", external_url: "some external_url", poster_id: 42, title: "some title"}
  @update_attrs %{description: "some updated description", external_url: "some updated external_url", poster_id: 43, title: "some updated title"}
  @invalid_attrs %{title: ""}

  def fixture(:listing) do
    {:ok, listing} = Jobs.create_listing(@create_attrs)
    listing
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

      assert %{id: id} = redirected_params(conn)
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
    setup [:create_listing]

    test "renders form for editing chosen listing", %{conn: conn, listing: listing} do
      conn = get(conn, Routes.listing_path(conn, :edit, listing))
      assert html_response(conn, 200) =~ "Edit Listing"
    end
  end

  describe "update listing" do
    setup [:create_listing]

    test "redirects when data is valid", %{conn: conn, listing: listing} do
      conn = put(conn, Routes.listing_path(conn, :update, listing), listing: @update_attrs)
      assert redirected_to(conn) == Routes.listing_path(conn, :show, listing)

      conn = get(conn, Routes.listing_path(conn, :show, listing))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, listing: listing} do
      conn = put(conn, Routes.listing_path(conn, :update, listing), listing: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Listing"
    end
  end

  describe "delete listing" do
    setup [:create_listing]

    test "deletes chosen listing", %{conn: conn, listing: listing} do
      conn = delete(conn, Routes.listing_path(conn, :delete, listing))
      assert redirected_to(conn) == Routes.listing_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.listing_path(conn, :show, listing))
      end
    end
  end

  defp create_listing(_) do
    listing = fixture(:listing)
    {:ok, listing: listing}
  end
end
