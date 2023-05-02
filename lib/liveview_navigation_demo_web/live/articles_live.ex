defmodule LiveviewNavigationDemoWeb.ArticlesLive do
  use LiveviewNavigationDemoWeb, :live_view

  @seed "0.102077593167|0.102086648815|4380075|0"

  defp req(rncontinue) do
    %Req.Response{
      status: 200,
      body: body
    } =
      URI.encode(
        "https://en.wikipedia.org/w/api.php?action=query&format=json&list=random&rnnamespace=0&rnlimit=50&rncontinue=#{rncontinue}"
      )
      |> Req.get!()

    body
  end

  def mount(_, _, socket) do
    body = req(@seed)
    rncontinue = body["continue"]["rncontinue"]
    articles = Enum.map(body["query"]["random"], &%{id: &1["id"], title: &1["title"]})

    {:ok,
     socket
     |> assign(:rncontinue, rncontinue)
     |> stream(:articles, articles)}
  end

  def handle_event("load_more", _, socket) do
    body = req(socket.assigns.rncontinue)
    rncontinue = body["continue"]["rncontinue"]
    articles = Enum.map(body["query"]["random"], &%{id: &1["id"], title: &1["title"]})

    socket =
      Enum.reduce(articles, socket, fn item, acc ->
        Phoenix.LiveView.stream_insert(acc, :articles, item)
      end)
      |> assign(:rncontinue, rncontinue)

    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="prose">
      <h1>Articles</h1>
      <ul id="articles" phx-update="append">
        <li :for={{id, article} <- @streams.articles} id={id}>
          <a href={"https://en.wikipedia.org/w/index.php?curid=#{article.id}"}>
            <%= article.title %>
          </a>
        </li>
      </ul>
      <button phx-click="load_more">Load more</button>
    </div>
    """
  end
end
