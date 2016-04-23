module WaitForAjax
  # Capybara.default_max_wait_time = 5

  # def wait_for_ajax
    # Timeout.timeout(Capybara.default_wait_time) do
  #   Timeout.timeout(5) do
  #     active = page.evaluate_script('jQuery.active')
  #     until active == 0
  #       active = page.evaluate_script('jQuery.active')
  #     end
  #   end
  # end
#
  def wait_for_ajax
    # Timeout.timeout(Capybara.default_max_wait_time) do
    #   # loop until finished_all_ajax_requests?
    #   loop until !page.has_content?("n/a")
    # end
  end
#
#   def finished_all_ajax_requests?
#     page.evaluate_script('jQuery.active').zero?
#   end
end

def wait_until
  Timeout.timeout(Capybara.default_max_wait_time) do
    sleep(0.1) until value = yield
    value
  end
end

RSpec.configure do |config|
  config.include WaitForAjax, type: :feature
end
