require File.expand_path("../../Homebrew/emacs_formula", __FILE__)

class Seq < EmacsFormula
  desc "Sequence manipulation library for Emacs"
  homepage "https://elpa.gnu.org/packages/seq.html"
  url "https://elpa.gnu.org/packages/seq-2.20.tar"
  sha256 "1634947f0944908c7dbfb3b11c7c899b6d486b7ceadb79bd7e60496fade9376f"

  bottle :disable

  depends_on EmacsRequirement => "24.1"

  # Submitted upstream via email on 2016-10-28
  patch :p3 do
    url "https://github.com/dunn/elpa/commit/195320c704cbc721f945d59fa54cd20d8e024a57.diff"
    sha256 "0cf5ba33945af4db2fe6e0ad914e5a684f12dc07cc613e145fbe273f247a9a9c"
  end

  def install
    ert_run_tests "tests/seq-tests.el" if Emacs.version >= Version.create("25.1")
    byte_compile Dir["*.el"]
    elisp.install Dir["*.el"], Dir["*.elc"]
  end

  test do
    (testpath/"test.el").write <<~EOS
      (add-to-list 'load-path "#{share}/emacs/site-lisp/seq")
      (load "seq")
      (print (seq-max '(1 5 10)))
    EOS
    assert_equal "10", shell_output("emacs -Q --batch -l #{testpath}/test.el").strip
  end
end
