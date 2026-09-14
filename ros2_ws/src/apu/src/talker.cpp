#include <chrono>
#include <functional>
#include <memory>
#include <string>

#include "rclcpp/rclcpp.hpp"
#include "ackermann_msgs/msg/ackermann_drive_stamped.hpp"

using namespace std::chrono_literals;

class talker : public rclcpp::Node
{
    public:
    talker() : Node("talker")
    {
        this->declare_parameter<double>("v", 0.0);
        this->declare_parameter<double>("d", 0.0);

        publisher_ = this->create_publisher<ackermann_msgs::msg::AckermannDriveStamped>("drive", 10);

        timer_ = this->create_wall_timer(
        0ms,
        std::bind(&talker::timer_callback, this)
        );
    }

    private:
    void timer_callback()
    {
        double v = this->get_parameter("v").as_double();
        double d = this->get_parameter("d").as_double();

        auto mensaje = ackermann_msgs::msg::AckermannDriveStamped();
        mensaje.header.stamp = this->now();
        mensaje.drive.speed = v;
        mensaje.drive.steering_angle = d;

        publisher_->publish(mensaje);
    }
    rclcpp::Publisher<ackermann_msgs::msg::AckermannDriveStamped>::SharedPtr publisher_;
    rclcpp::TimerBase::SharedPtr timer_;
};


int main(int argc, char *argv[])
{
  rclcpp::init(argc, argv);
  rclcpp::spin(std::make_shared<talker>());
  rclcpp::shutdown();
  return 0;
}