defmodule SwsPhxWeb.Router do
  use SwsPhxWeb, :router

  alias SwsPhx.Auth
  alias SwsPhx.Repo

  pipeline :api do
    plug CORSPlug, origin: "http://localhost:8080"
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug CORSPlug, origin: "http://localhost:8080"
    plug :accepts, ["json"]
    plug Auth, repo: Repo
  end

  scope "/api", SwsPhxWeb do
    pipe_through :api
  end

  scope "/user", SwsPhxWeb do
    pipe_through :api

    options "/", UserController, :options
    post "/", UserController, :create_user

    options "/login", UserController, :options
    post "/login", UserController, :login

    options "/dash", UserController, :options
    get "/dash", UserController, :get_dash_data
  end

  scope "/user/device", SwsPhxWeb do
    pipe_through :auth

    options "/", UserController, :options
    post "/", UserController, :add_device
    delete "/", UserController, :delete_device

    options "/all", UserController, :options
    get "/all", UserController, :get_all_devices

    options "/data", UserController, :options
    post "/data", UserController, :get_device_data
  end

  scope "/device", SwsPhxWeb do
    pipe_through :api

    options "/", DeviceController, :options
    post "/", DeviceController, :insert_device_data

    options "/watering", DeviceController, :options
    post "/watering", DeviceController, :insert_watering_system_data
  end
end
