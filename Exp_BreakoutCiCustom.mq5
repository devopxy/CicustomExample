//+------------------------------------------------------------------+
//|                                       TemplateSimpleBreakout.mq5 |
//|                             Copyright 2023, Woodston Capital Ltd |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, Woodston Capital Ltd."
#property link      "https://www.woodstoncapital.com"
#property version   "1.00"
#include <Expert\Expert.mqh>
#include <Indicators\Indicators.mqh>
#include <Trade\PositionInfo.mqh>
#include <Trade\Trade.mqh>



// Declare a CiCustom object
CiCustom breakoutIndicator;

// Initialize the Breakout indicator
bool InitBreakoutIndicator()
  {

//--- Set indicator parameters
   MqlParam parameters[8];
//---
   parameters[0].type=TYPE_STRING;
   parameters[0].string_value="Downloads\\Breakout.ex5";
   parameters[1].type=TYPE_INT;
   parameters[1].integer_value=2;
   parameters[2].type=TYPE_INT;
   parameters[2].integer_value=0;
   parameters[3].type=TYPE_INT;
   parameters[3].integer_value=7;
   parameters[4].type=TYPE_INT;
   parameters[4].integer_value=0;
   parameters[5].type=TYPE_INT;
   parameters[5].integer_value=23;
   parameters[7].type=TYPE_INT;
   parameters[7].integer_value=0;

      // Create the custom Breakout indicator (assuming it's located in the MQL5\Indicators\Downloads folder)
      if(!breakoutIndicator.Create(Symbol(), Period(),IND_CUSTOM,8,parameters))
        {
         Print("Error creating Breakout indicator");
         return (false);
        }
   return (true);
  }


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- Initialize the Breakout indicator
   if(!InitBreakoutIndicator())
     {
      Print("Error initializing Breakout indicator");
      return(INIT_FAILED);
     }
   return(INIT_SUCCEEDED);
  }



//+------------------------------------------------------------------+
//| Expert tick function |
//+------------------------------------------------------------------+
void OnTick()
  {
// Implement your trading strategy here, using the Pivot Point indicator values.

   int index = 0; // The most recent bar

   breakoutIndicator.Refresh();
   double asian_upper =  NormalizeDouble(breakoutIndicator.GetData(2,index),_Digits);
   double asian_lower =  NormalizeDouble(breakoutIndicator.GetData(3,index),_Digits);
   
// Use the Asian Range levels in your trading strategy logic
// ...
  }
//+------------------------------------------------------------------+

