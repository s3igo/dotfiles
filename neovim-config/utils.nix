{
  mapMode =
    mode:
    {
      key,
      action,
      options ? { },
    }:
    {
      inherit
        mode
        key
        action
        options
        ;
    };
}
