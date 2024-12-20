{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  openssl,
  stdenv,
  darwin,
}:

rustPlatform.buildRustPackage rec {
  pname = "devai";
  version = "0.5.3";

  src = fetchFromGitHub {
    owner = "jeremychone";
    repo = "rust-devai";
    rev = "v${version}";
    hash = "sha256-oPn9ZLWy8iaclIHR935enCtqXwcCE9Fo9eimRf3t3uc=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
  };

  postPatch = ''
    ln -s ${./Cargo.lock} Cargo.lock
  '';

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs =
    [
      openssl
    ]
    ++ lib.optionals stdenv.isDarwin [
      darwin.apple_sdk.frameworks.CoreFoundation
      darwin.apple_sdk.frameworks.CoreServices
      darwin.apple_sdk.frameworks.Security
      darwin.apple_sdk.frameworks.SystemConfiguration
    ];

  checkFlags = [
    "--skip=agent::agent_locator::tests::test_find_command_agent_custom_and_validate_ctx"
    "--skip=agent::agent_locator::tests::test_find_command_agent_direct_and_validate_ctx"
    "--skip=agent::agent_locator::tests::test_load_solo_agent_and_validate_ctx"
    "--skip=run::run_command::tests_run_agent_llm::test_run_agent_llm_c_on_file_ok"
    "--skip=run::run_command::tests_run_agent_llm::test_run_agent_llm_c_simple_ok"
    "--skip=run::run_command::tests_run_agent_llm::test_run_agent_llm_full_chat_ok"
    "--skip=run::run_command::tests_run_agent_script::test_run_agent_script_before_all_inputs_gen"
    "--skip=run::run_command::tests_run_agent_script::test_run_agent_script_before_all_inputs_reshape"
    "--skip=run::run_command::tests_run_agent_script::test_run_agent_script_before_all_simple"
    "--skip=run::run_command::tests_run_agent_script::test_run_agent_script_hello_ok"
    "--skip=run::run_solo::tests::test_run_agent_s_simple_ok"
  ];

  meta = {
    description = "Command Agent runner to accelerate production coding. File based, fully customizable, NOT for building snake games";
    homepage = "https://github.com/jeremychone/rust-devai";
    changelog = "https://github.com/jeremychone/rust-devai/blob/${src.rev}/CHANGELOG.md";
    license = with lib.licenses; [
      mit
      asl20
    ];
    maintainers = [ ];
    mainProgram = "devai";
  };
}
