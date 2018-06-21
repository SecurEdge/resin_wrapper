# test/car/car_test.rb
require './test/test_helper'

class ResinIOApplicationTest < Minitest::Test
  def test_exists
    assert ResinIO::Application
  end

  def test_it_gives_back_a_single_application
    VCR.use_cassette('one_application') do
      application = ResinIO::Application.find(1032362)
      assert_equal ResinIO::Application, application.class

      # Check that the fields are accessible by our model
      assert_equal 1032362, application.id
      assert_equal "tickRpi3Staging", application.app_name
      assert_equal "bb6746a8e135fc7b869daaeda3183321cb5d3a5e", application.commit
      assert_equal "raspberrypi3", application.device_type


    end
  end

  # def test_it_gives_back_all_devices
  #   VCR.use_cassette('all_devices') do
  #     devices = ResinIO::Device.all
  #     assert_equal ResinIO::Device, devices.first.class
  #     assert_equal devices.count, 10
  #
  #     # Check that the fields are accessible by our model
  #     # assert_equal 1131087, device.id
  #     # assert_equal "4c28d5cc7e45e9f325f4b6223103a698", device.uuid
  #   end
  # end
end
