require "tanka_renderer/renderer"
require "cairo"

class RendererTest < Test::Unit::TestCase
  def setup
    @renderer = TankaRenderer::Renderer::Image.new
  end

  class GuessFontTest < self
    def test_found
      part_of_name = "M"
      assert_match(/#{part_of_name}/, @renderer.guess_font(part_of_name))
    end

    def test_not_found
      part_of_name = "ABCDE12345"
      assert_nil(@renderer.guess_font(part_of_name))
    end
  end

  class DrawTest < self
    def test_ten_characters
      assert_nothing_raised_in_draw("1234567890")
    end

    private
    def assert_nothing_raised_in_draw(text)
      width =  200
      height = 200
      assert_nothing_raised do
        Cairo::ImageSurface.new(:argb32, width, height) do |surface|
          Cairo::Context.new(surface) do |context|
            @renderer.draw(context, text)
          end
        end
      end
    end
  end
end
