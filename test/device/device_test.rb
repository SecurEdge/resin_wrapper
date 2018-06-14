# test/car/car_test.rb
require './test/test_helper'

class ResinWrapperDeviceTest < Minitest::Test
  def test_exists
    assert ResinWrapper::Device
  end

  def test_it_gives_back_a_single_device
    VCR.use_cassette('one_device') do
      device = ResinWrapper::Device.find(1131087)
      assert_equal ResinWrapper::Device, device.class

      # Check that the fields are accessible by our model
      assert_equal 1131087, device.id
      assert_equal "4c28d5cc7e45e9f325f4b6223103a698", device.uuid
      assert_equal "sen-charlotte-serverroom", device.name
    end
  end

  def test_it_gives_back_all_devices
    VCR.use_cassette('all_devices') do
      devices = ResinWrapper::Device.all
      # assert_equal ResinWrapper::Device, devices.first.class
      assert_equal devices.count, 10

      # Check that the fields are accessible by our model
      # assert_equal 1131087, device.id
      # assert_equal "4c28d5cc7e45e9f325f4b6223103a698", device.uuid
    end
  end
end
