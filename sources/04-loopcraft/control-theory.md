Tools
move to sidebar
hide
Actions
General
- <span id="t-permalink">[Permanent link](/w/index.php?title=Control_loop&oldid=1359243231 "Permanent link to this revision of this page")</span>
- <span id="t-info">[Page information](/w/index.php?title=Control_loop&action=info "More information about this page")</span>
- <span id="t-cite">[Cite this page](/w/index.php?title=Special:CiteThisPage&page=Control_loop&id=1359243231&wpFormIdentifier=titleform "Information on how to cite this page")</span>
- <span id="t-urlshortener">[Get shortened URL](/w/index.php?title=Special:UrlShortener&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FControl_loop)</span>
Print/export
- <span id="coll-download-as-rl">[Download as PDF](/w/index.php?title=Special:DownloadAsPdf&page=Control_loop&action=show-download-screen "Download this page as a PDF file")</span>
In other projects
Appearance
move to sidebar
hide
From Wikipedia, the free encyclopedia
Fundamental building block of control systems
A **control loop** is the fundamental building block of [control systems](/wiki/Control_system "Control system") in general and [industrial control systems](/wiki/Industrial_control_system "Industrial control system") in particular. It consists of the process [sensor](/wiki/Sensor "Sensor"), the controller function, and the final control element (FCE) which controls the process necessary to automatically adjust the value of a measured [process variable](/wiki/Process_variable "Process variable") (PV) to equal the value of a desired set-point (SP).
There are two common classes of control loop: open loop and closed loop.
- In an open-loop control system, the control action from the controller is independent of the process variable. An example of this is a central heating boiler controlled only by a [timer](/wiki/Timer "Timer"). The control action is the switching on or off of the boiler. The process variable is the building temperature. This controller operates the heating system for a constant time regardless of the temperature of the building.
## Open-loop and closed-loop
- In open-loop control, the control action from the controller is independent of the "process output" (or "controlled process variable"). A good example of this is a central heating boiler controlled only by a timer, so that heat is applied for a constant time, regardless of the temperature of the building. The control action is the switching on/off of the boiler, but the controlled variable should be the building temperature, but is not because this is open-loop control of the boiler, which does not give closed-loop control of the temperature.
### Other examples
</figure>
An example of a control system is a car's [cruise control](/wiki/Cruise_control "Cruise control"), which is a device designed to maintain vehicle speed at a constant *desired* or *reference* speed provided by the driver. The *controller* is the cruise control, the *plant* is the car, and the *system* is the car and the cruise control. The system output is the car's speed, and the control itself is the engine's [throttle](/wiki/Throttle "Throttle") position which determines how much power the engine delivers.
A primitive way to implement cruise control is simply to lock the throttle position when the driver engages cruise control. However, if the cruise control is engaged on a stretch of non-flat road, then the car will travel slower going uphill and faster when going downhill. This type of controller is called an *[open-loop controller](/wiki/Open-loop_controller "Open-loop controller")* because there is no [feedback](/wiki/Feedback "Feedback"); no measurement of the system output (the car's speed) is used to alter the control (the throttle position.) As a result, the controller cannot compensate for changes acting on the car, like a change in the slope of the road.
In a *[closed-loop control system](/wiki/Closed-loop_controller "Closed-loop controller")*, data from a sensor monitoring the car's speed (the system output) enters a controller which continuously compares the quantity representing the speed with the reference quantity representing the desired speed. The difference, called the error, determines the throttle position (the control). The result is to match the car's speed to the reference speed (maintain the desired system output). Now, when the car goes uphill, the difference between the input (the sensed speed) and the reference continuously determines the throttle position. As the sensed speed drops below the reference, the difference increases, the throttle opens, and engine power increases, speeding up the vehicle. In this way, the controller dynamically counteracts changes to the car's speed. The central idea of these control systems is the *feedback loop*, the controller affects the system output, which in turn is measured and fed back to the controller.
## Application
<figcaption>Example of a single industrial control loop; showing continuously modulated control of process flow.</figcaption>
</figure>
In this example, the value of the PV is always the same as the MV, as they are in series in the pipeline. However, if the feed from the valve was to a tank, and the controller function was to control the level using the fill valve, the PV would be the tank level, and the MV would be the flow to the tank.
At a detailed level, the control loop connection diagram is created to show the electrical and pneumatic connections. This greatly aids diagnostics and repair, as all the connections for a single control function are on one diagram.
## Loop and control equipment tagging
The first identification letter is for the measured value, the second is a modifier, 3rd indicates the passive/readout function, 4th - active/output function, and the 5th is the function modifier. This is followed by loop number, which is unique to that loop.
For instance, FIC045 means it is the Flow Indicating Controller in control loop 045. This is also known as the "tag" identifier of the field device, which is normally given to the location and function of the instrument. The same loop may have FT045 - which is the flow transmitter in the same loop.
|  |  |  |  |  |  |
|----|----|----|----|----|----|
| **Letter** | **Column 1** Measured value | **Column 2** Modifier | **Column 3** Readout/passive function | **Column 4** Output/active function | **Column 5** Function modifier |
| A | Analysis |  | Alarm |  |  |
| B | Burner, combustion |  | User choice | User choice | User choice |
| C | User's choice - usually conductivity |  |  | Control | Close |
| D | User's choice - usually density | Difference |  |  | Deviation |
| E | Voltage |  | Sensor |  |  |
| F | Flow rate | Ratio |  |  |  |
| G | User's choice (usually gaging/gauging) | Gas | Glass/gauge/viewing |  |  |
| H | Hand |  |  |  | High |
| I | Current |  | Indicate |  |  |
| J | Power | Scan |  |  |  |
| K | Time, time schedule | Time rate of change |  | Control station |  |
| L | Level |  | Light |  | Low |
| M | User's choice |  |  |  | Middle / intermediate |
| N | User's choice (usually torque) |  | User choice | User choice | User choice |
| O | User's choice |  | Orifice |  | Open |
| P | Pressure |  | Point/test connection |  |  |
| Q | Quantity | Totalize/integrate | Totalize/integrate |  |  |
| R | Radiation |  | Record |  | Run |
| S | Speed, frequency |  |  | Switch | Stop |
| T | Temperature |  |  | Transmit |  |
| U | Multivariable |  | Multifunction | Multifunction |  |
| V | Vibration, mechanical analysis |  |  | Valve or damper |  |
| W | Weight, force |  | Well or probe |  |  |
| X | User's choice - usually on-off valve as XV | X-axis | Accessory devices, unclassified | Unclassified | Unclassified |
| Y | Event, state, presence | Y-axis |  | Auxiliary devices |  |
| Z | Position, dimension | Z-axis or Safety |  | Actuator, driver or unclassified final control element |  |
## References
<style data-mw-deduplicate="TemplateStyles:r1327269900">.mw-parser-output .reflist-columns-2{column-width:30em}.mw-parser-output .reflist-columns-3{column-width:25em}body.skin-vector-2022 .mw-parser-output .reflist-columns-2{column-width:27em}body.skin-vector-2022 .mw-parser-output .reflist-columns-3{column-width:22.5em}.mw-parser-output .references[data-mw-group=upper-alpha]{list-style-type:upper-alpha}.mw-parser-output .references[data-mw-group=upper-roman]{list-style-type:upper-roman}.mw-parser-output .references[data-mw-group=lower-alpha]{list-style-type:lower-alpha}.mw-parser-output .references[data-mw-group=lower-greek]{list-style-type:lower-greek}.mw-parser-output .references[data-mw-group=lower-roman]{list-style-type:lower-roman}.mw-parser-output div.reflist-liststyle-upper-alpha .references{list-style-type:upper-alpha}.mw-parser-output div.reflist-liststyle-upper-roman .references{list-style-type:upper-roman}.mw-parser-output div.reflist-liststyle-lower-alpha .references{list-style-type:lower-alpha}.mw-parser-output div.reflist-liststyle-lower-greek .references{list-style-type:lower-greek}.mw-parser-output div.reflist-liststyle-lower-roman .references{list-style-type:lower-roman}</style>
[Categories](/wiki/Help:Category "Help:Category"):
- [Control engineering](/wiki/Category:Control_engineering "Category:Control engineering")
- [Control loop theory](/wiki/Category:Control_loop_theory "Category:Control loop theory")
Hidden categories:
- [Articles with short description](/wiki/Category:Articles_with_short_description "Category:Articles with short description")
- [Short description is different from Wikidata](/wiki/Category:Short_description_is_different_from_Wikidata "Category:Short description is different from Wikidata")
