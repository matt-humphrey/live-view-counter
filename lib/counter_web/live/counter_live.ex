defmodule CounterWeb.CounterLive do
  use CounterWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, count: 0, increment_by: 1)}
  end

  def render(assigns) do
    ~H"""
    <h1>Counter</h1>
    <%= assigns.count %>
    <button phx-click="increment">+</button>

    <.form let={f} for={:increment_form} phx-change="change_increment_by" phx-submit="increment_by">
      <%= number_input f, :increment_by, value: @increment_by %>
      <%= submit "Increment" %>
    </.form>
    """
  end

  def handle_event("increment", _params, socket) do
    {:noreply, assign(socket, :count, socket.assigns.count + 1)}
  end

  def handle_event(
    "change_increment_by",
    %{"increment_form" => %{"increment_by" => increment_by}},
    socket
  ) do
    {:noreply, assign(socket, :increment_by, increment_by)}
  end

  def handle_event(
    "increment_by",
     %{"increment_form" => %{"increment_by" => increment_by}},
     socket
     ) do
    increment =
      case Integer.parse(increment_by) do
        {integer, _} -> integer
        :error -> 1
      end

    {:noreply, assign(socket, :count, socket.assigns.count + increment)}
  end
end
