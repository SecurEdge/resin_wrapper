# test/car/car_test.rb
require './test/test_helper'

class ResinIODeviceTest < Minitest::Test
  def test_exists
    assert ResinIO::Device
  end

  def test_it_gives_back_a_single_device
    VCR.use_cassette('one_device') do
      device = ResinIO::Device.find(1131087)
      assert_equal ResinIO::Device, device.class

      # Check that the fields are accessible by our model
      assert_equal 1_131_087, device.id
      assert_equal '4c28d5cc7e45e9f325f4b6223103a698', device.uuid
      assert_equal 'sen-charlotte-serverroom', device.device_name
      assert_equal 'raspberrypi3', device.device_type
      assert_equal true, device.is_online
      assert_equal 'Idle', device.status
      assert_equal 'dev', device.os_variant
      assert_equal 'Charlotte, North Carolina, United States', device.location
      assert_equal '12fe382498b5fc7777fcc2d0b05ceb1f09c52122', device.commit
      assert_equal 'Resin OS 2.12.7+rev1', device.os_version
      assert_equal '7.4.3', device.supervisor_version
      assert_equal '-80.8262', device.longitude
      assert_equal '35.2157', device.latitude
    end
  end

  def test_it_gives_back_all_devices
    VCR.use_cassette('all_devices') do
      devices = ResinIO::Device.all
      assert_equal ResinIO::Device, devices.first.class
      assert_equal devices.count, 10

      # Check that the fields are accessible by our model
      # assert_equal 1131087, device.id
      # assert_equal "4c28d5cc7e45e9f325f4b6223103a698", device.uuid
    end
  end
end
