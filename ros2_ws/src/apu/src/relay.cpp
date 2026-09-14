#include <chrono>
#include <functional>
#include <memory>
#include <string>

#include "rclcpp/rclcpp.hpp"
#include "ackermann_msgs/msg/ackermann_drive_stamped.hpp"

using namespace std::chrono_literals;

class relay : public rclcpp::Node
{
    public:
        relay() : Node("relay")
        {
            subscriber_ = this->create_subscription<ackermann_msgs::msg::AckermannDriveStamped>("drive", 10, std::bind(&relay::listener_callback, this, std::placeholders::_1));
            
            publisher_ = this->create_publisher<ackermann_msgs::msg::AckermannDriveStamped>("drive_relay", 10);
        }
    private:
        void listener_callback(const ackermann_msgs::msg::AckermannDriveStamped::SharedPtr msg)
        {
            double mux_v = msg->drive.speed * 3;
            double mux_d = msg->drive.steering_angle * 3;
            
            auto mensaje = ackermann_msgs::msg::AckermannDriveStamped();
            mensaje.header.stamp = this->now();
            mensaje.drive.speed = mux_v;
            mensaje.drive.steering_angle = mux_d;

            publisher_->publish(mensaje);
        }
        rclcpp::Publisher<ackermann_msgs::msg::AckermannDriveStamped>::SharedPtr publisher_;
        rclcpp::Subscription<ackermann_msgs::msg::AckermannDriveStamped>::SharedPtr subscriber_;
};

int main(int argc, char *argv[])
{
  rclcpp::init(argc, argv);
  rclcpp::spin(std::make_shared<relay>());
  rclcpp::shutdown();
  return 0;
}