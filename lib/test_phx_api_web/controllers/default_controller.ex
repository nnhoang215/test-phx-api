defmodule TestPhxApiWeb.DefaultController do 
  use TestPhxApiWeb, :controller
  
  def index(conn, _params) do
    text conn, "The Real Deal API is LIVE - #{Mix.env()}"
  end
end