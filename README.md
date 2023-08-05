# Traffic Light Controller with State Machine

**Project Overview**

The "Traffic Light Controller with State Machine" is a VHDL project that implements a traffic light controller using a Finite State Machine (FSM). The design generates control signals for a traffic light system based on inputs from road sensors and a programmable clock divider. The FSM manages the state transitions of the traffic lights to regulate the flow of vehicles at an intersection.

**Authors**

- Ismail Walsh
- Timothy Pierce
- Alistair A. McEwan
- Irfan Mir

**Original Company**

University of Leicester

**Modification**

The code was modified in 2019 by Ismail Walsh to incorporate the traffic light controller and state machine.

**Date**

The original design was completed on 10th March 2013.

**Purpose**

The purpose of this VHDL design is to create a traffic light controller that efficiently manages traffic flow at an intersection. The FSM-based controller controls the timing and sequencing of traffic light states, considering inputs from road sensors and a programmable clock divider.

**Usage Instructions**

To use the "Traffic Light Controller with State Machine" entity in your VHDL project, follow these steps:

1. Copy the VHDL files into your project directory.

2. Include the traffic light controller entity in your main VHDL code:
   ```
   library work;
   use work.tlcontroller.all;
   ```

3. Instantiate the "Traffic Light Controller" entity in your architecture:
   ```
   entity Your_Entity_Name is
   port (
         SW: in  STD_LOGIC_VECTOR(0 downto 0);
         CLOCK: in  STD_LOGIC;
         BUTTON: in  STD_LOGIC_VECTOR(2 downto 0);
         LEDG: out STD_LOGIC_VECTOR(9 downto 0)
        );
   end entity Your_Entity_Name;

   architecture Your_Architecture_Name of Your_Entity_Name is
   begin
      U1: tlcontroller
          port map (SW => SW,
                    CLOCK => CLOCK,
                    BUTTON => BUTTON,
                    LEDG => LEDG);
   end architecture Your_Architecture_Name;
   ```

4. Set the necessary inputs for the traffic light controller:
   - `SW`: Control signal to enable or disable the traffic light controller.
   - `CLOCK`: Main clock signal for the controller.
   - `BUTTON`: Inputs from road sensors or external controls.
   - `LEDG`: Output signals to control the traffic lights.

5. Compile and simulate your VHDL project using your preferred simulation tool or FPGA synthesis tool.

**Functionality**

The "Traffic Light Controller with State Machine" entity manages the sequencing and timing of traffic lights at an intersection. The state machine (FSM) considers inputs from road sensors (`BUTTON`) and a programmable clock divider (`CLOCK`) to determine the duration of each traffic light state. The `SW` signal enables or disables the traffic light controller.

**Important Notes**

1. The `BUTTON` inputs must be connected to road sensors or external controls that provide information about vehicle presence on the roads.

2. The `CLOCK` signal must be a stable clock source with a frequency greater than the required timing for traffic light states.

3. The `SW` signal can be used to enable or disable the traffic light controller. When disabled, the traffic light controller should halt and maintain the current state.

4. The controller uses an FSM to manage the timing and sequencing of traffic light states. Ensure that the FSM transitions and state durations are appropriately designed for the specific intersection requirements.

5. The outputs (`LEDG`) are used to control the actual traffic lights at the intersection. Ensure proper connections to the physical LEDs or the interface with other control systems.

**License**

This VHDL design is provided under the license terms specified in the accompanying LICENSE file. Please refer to the LICENSE file for detailed license information.

**Support and Contact**

For any inquiries or support related to this VHDL project, please contact [Insert Your Contact Information].

**Acknowledgments**

We acknowledge the authors, Alistair A. McEwan and Irfan Mir, for their contribution to this VHDL project. We also thank Ismail Walsh for modifying the code to create the traffic light controller with a state machine.

**Disclaimer**

This VHDL project is provided as-is and without any warranty. The authors and the University of Leicester shall not be held liable for any damages or losses resulting from the use or misuse of this project. Users are advised to thoroughly test and verify the design for their specific applications.
