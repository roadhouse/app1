Rails.application.routes.draw do
  namespace "api" do
    namespace "v1" do
      get "find_ubs", to: "ubs#find_ubs"
    end
  end
end
