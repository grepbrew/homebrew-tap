cask "hose" do
  version "0.2.10"
  sha256 "48048da11e2b9f9d73c068d5844234a23a7495884b4d718b9aa081816c4569de"

  url "https://github.com/grepbrew/Hose/releases/download/v#{version}/Hose_#{version}_universal.dmg"
  name "Hose"
  desc "Deploy Hugging Face chat models on RunPod GPUs and watch the cost"
  homepage "https://github.com/grepbrew/Hose"

  depends_on macos: :monterey

  app "Hose.app"

  # Not notarized yet: clear the quarantine flag so macOS opens it without the "damaged" warning.
  # Homebrew 7 deprecates postflight blocks; install steps take {{appdir}} as a token.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Hose.app"]
  end

  zap trash: [
    "~/Library/Application Support/com.grepbrew.hose",
    "~/Library/Caches/com.grepbrew.hose",
    "~/Library/WebKit/com.grepbrew.hose",
  ]

  caveats <<~EOS
    Hose is not notarized by Apple yet. If macOS still refuses to open it, go to
    System Settings > Privacy & Security and click "Open Anyway" next to Hose.
  EOS
end
