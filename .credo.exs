%{
  configs: [
    %{
      name: "default",
      files: %{
        excluded: ["test/support/", "deps/", "_build/", "assets/"]
      }
    }
  ]
}
