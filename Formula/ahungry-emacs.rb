require File.expand_path("../../Homebrew/emacs_formula", __FILE__)

class AhungryEmacs < EmacsFormula
  desc "Bright and bold color theme for Emacs"
  homepage "https://github.com/ahungry/color-theme-ahungry"
  url "https://elpa.gnu.org/packages/ahungry-theme-1.8.0.tar"
  sha256 "fbacbbeecbbd94511eae99e18fb1bcddbe556a141fb81769993d7fb968b6b091"
  head "https://github.com/ahungry/color-theme-ahungry.git"

  depends_on EmacsRequirement => "24.1"

  def install
    byte_compile "ahungry-theme.el", "color-theme-ahungry.el"
    elisp.install "ahungry-theme.el", "color-theme-ahungry.el",
                  "ahungry-theme.elc", "color-theme-ahungry.elc"
  end

  test do
    (testpath/"test.el").write <<~EOS
      (add-to-list 'custom-theme-load-path "#{elisp}")
      (load-theme 'ahungry t)
      (print (minibuffer-prompt-width))
    EOS
    assert_equal "0", shell_output("emacs -Q --batch -l #{testpath}/test.el").strip
  end
end
