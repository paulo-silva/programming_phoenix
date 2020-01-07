defmodule RumblWeb.WatchController do
  use RumblWeb, :controller
  alias Rumbl.Multimedia

  @spec show(Plug.Conn.t(), map) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    video = Multimedia.get_video!(id)
    render(conn, "show.html", video: video)
  end
end
