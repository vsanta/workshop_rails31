class Profiler
  def initialize app
    @app = app
  end

  def call env
    RubyProf.start
    @app.call env
    ensure
      result = RubyProf.stop
      printer = RubyProf::CallStackPrinter.new result
      printer.print File.open "output.html", "w+"
  end
end