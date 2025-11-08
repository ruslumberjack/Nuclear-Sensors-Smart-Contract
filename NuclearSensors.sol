// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NuclearSensors{

    //Constant Values for normal metric ranges

    int public constant RADIATION_VALUE = 11; // Divide by 10000

    int public constant TEMPERATURE_MIN = 298;
    int public constant TEMPERATURE_MAX = 311;

    int public constant STEAM_A_PRESSURE_MIN = 67;
    int public constant STEAM_A_PRESSURE_MAX = 79;

    int public constant STEAM_B_PRESSURE_MIN = 67;
    int public constant STEAM_B_PRESSURE_MAX = 79;

    int public constant LEVEL_PRESSURE_MIN = 32;
    int public constant LEVEL_PRESSURE_MAX = 63;

    int public constant TURBINE_LOAD_MIN = 40;
    int public constant TURBINE_LOAD_MAX = 100;

    int public constant RCS_PRESSURE_MIN = 148;
    int public constant RCS_PRESSURE_MAX = 158;

    int public constant TOTAL_LEAKAGE_MIN = 665; //Divide by 1000
    int public constant TOTAL_LEAKAGE_MAX = 4015;

    struct Sensor{
        int Time;
        int Radiation;
        int TemperatureAverage;
        int PressureA;
        int PressureB;
        int LevelPressure;
        int Power_Turbine_load;
        int RCS_Pressure;
        int Total_Leakage;

        uint256 timestamp;

        bool Values_In_Range;
    }

    Sensor[] public Sensor_Array;     

    event SensorRecordAdded(
        int Time,
        int Radiation,
        int TemperatureAverage,
        int PressureA,
        int PressureB,
        int LevelPressure,
        int Power_Turbine_load,
        int RCS_Pressure,
        int Total_Leakage
    );

    function add_sensor_data (
        int Time_Input,
        int Radiation_Input,
        int Temperature_Average_Input,
        int PressureA_Input,
        int PressureB_Input,
        int Level_Pressure_Input,
        int Power_Turbine_load_Input,
        int RCS_Pressure_Input,
        int Total_Leakage_Input
    ) public

        {
            Sensor memory new_sensor;

            new_sensor.Time = Time_Input;
            new_sensor.Radiation = Radiation_Input;
            new_sensor.TemperatureAverage = Temperature_Average_Input;
            new_sensor.PressureA = PressureA_Input;
            new_sensor.PressureB = PressureB_Input;
            new_sensor.LevelPressure = Level_Pressure_Input;
            new_sensor.Power_Turbine_load = Power_Turbine_load_Input;
            new_sensor.RCS_Pressure = RCS_Pressure_Input;
            new_sensor.Total_Leakage = Total_Leakage_Input;

            new_sensor.timestamp = block.timestamp;

            bool values_in_range = 
                check_if_in_range(
                    Radiation_Input,
                    Temperature_Average_Input,
                    PressureA_Input,
                    PressureB_Input,
                    Level_Pressure_Input,
                    Power_Turbine_load_Input,
                    RCS_Pressure_Input,
                    Total_Leakage_Input
                );
            
            if (values_in_range == false){
                emit("One or more sensor values in data with timestamp: " + Time_Input + " are not in range.\n");
                new_sensor.Values_In_Range = false;
            }

            else{
                new_sensor.Values_In_Range = true;
            }
            



            Sensor_Array.push(new_sensor);
            
            emit SensorRecordAdded(
                Time_Input,
                Radiation_Input, 
                Temperature_Average_Input, 
                PressureA_Input, 
                PressureB_Input, 
                Level_Pressure_Input, 
                Power_Turbine_load_Input, 
                RCS_Pressure_Input,
                Total_Leakage_Input
            );


        }

    function check_if_in_range (
            
        int Radiation_Input,
        int Temperature_Average_Input,
        int PressureA_Input,
        int PressureB_Input,
        int Level_Pressure_Input,
        int Power_Turbine_load_Input,
        int RCS_Pressure_Input,
        int Total_Leakage_Input
        ) pure public returns(bool){
            if (Radiation_Input != RADIATION_VALUE){
                return false;
            }

            else if(Temperature_Average_Input < TEMPERATURE_MIN || Temperature_Average_Input > TEMPERATURE_MAX){
                return false;
            }

            else if(PressureA_Input < STEAM_A_PRESSURE_MIN || STEAM_A_PRESSURE_MAX > 79){
                return false;
            }

            else if(PressureB_Input < STEAM_B_PRESSURE_MIN || PressureB_Input > STEAM_B_PRESSURE_MAX){
                return false;
            }

            else if(Level_Pressure_Input < LEVEL_PRESSURE_MIN || Level_Pressure_Input > LEVEL_PRESSURE_MAX){
                return false;
            }

            else if(Power_Turbine_load_Input < TURBINE_LOAD_MIN || Power_Turbine_load_Input > TURBINE_LOAD_MAX){
                return false;
            }

            else if(RCS_Pressure_Input < RCS_PRESSURE_MIN || RCS_Pressure_Input > RCS_PRESSURE_MAX){
                return false;
            }

            else if(Total_Leakage_Input < TOTAL_LEAKAGE_MIN || Total_Leakage_Input > TOTAL_LEAKAGE_MAX){
                return false;
            }

            else{
                return true;
            }
        }
}
