require 'teststrap'

context "Base" do
  setup { GamespyQuery::Base.new }

end

context "Funcs" do
  setup { GamespyQuery::Funcs }

  denies("TimeOutError") { topic::TimeOutError.new }.nil

  # TODO: Or should we simply test the Base class who includes this already?
  context "Included" do
    setup { Class.new { include GamespyQuery::Funcs } }

    context "Instance" do
      setup { topic.new }
      # TODO: This method doesnt do anything atm
      asserts("strip_tags") { topic.strip_tags "test" }.equals "test"

      asserts("convert integer") { topic.convert_type "1" }.equals 1
      asserts("convert float") { topic.convert_type "1.5" }.equals 1.5

      asserts("encode_string") { topic.encode_string("test encoding").encoding }.equals Encoding.find("UTF-8")

      asserts("handle_chr") { topic.handle_chr(25 >> 8) }.equals 0

    end
  end
end

context "Tools" do
  setup { GamespyQuery::Tools }

  denies("Logger") { topic.logger }.nil

  # TODO: Somehow returns strange string with unescaped double quotes embedded
  asserts("dbg_msg") { topic.dbg_msg Exception.new }.equals "Exception: Exception\nBackTrace: \n"

  asserts("log_exception") { topic.log_exception Exception.new }.equals true
  asserts("debug") { topic.debug{"test"} }.nil
end
