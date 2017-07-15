defmodule Styx.Web.PageController do
  use Styx.Web, :controller

  def index(conn, params) do
    page =
    Styx.RfcList
      |> Styx.Repo.paginate(params)

    render conn, "index.html",
      rfcs: page.entries,
      page: page,
      page_number: page.page_number,
      page_size: page.page_size,
      total_pages: page.total_pages,
      total_entries: page.total_entries
  end
end
