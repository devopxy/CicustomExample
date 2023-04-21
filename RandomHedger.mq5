//+------------------------------------------------------------------+
//|                                              HedgingCoinToss.mq5 |
//|                         Copyright 2023, AnonymousTrader          |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, AnonymousTrader"
#property version "1.00"
#property description "An example of hedging coin toss EA"

#include <Trade\Trade.mqh>

//---- input parameters
input string Symbol1 = "EURUSD";     // First symbol for trading
input string Symbol2 = "GBPUSD";     // Second symbol for trading
input int Magic = 12345;             // Magic number
input double Lots = 0.1;             // Trade volume
input bool ReallyRandom = true;      // True for random coin toss, false for deterministic
input ulong Slippage = 30;           // Maximum slippage in points
input int StopLoss = 100;            // Stop loss in points
input int TakeProfit = 200;          // Take profit in points

CTrade trade1, trade2;

int OnInit()
{
    trade1.SetExpertMagicNumber(Magic);
    trade2.SetExpertMagicNumber(Magic + 1);
    
    trade1.SetDeviationInPoints(Slippage);
    trade2.SetDeviationInPoints(Slippage);
    
    if (ReallyRandom)
        MathSrand(int(TimeLocal())); // Initialize random number generator
    else
        MathSrand(1); // Same every time

    return(INIT_SUCCEEDED);
}

void OnTick()
{
    if (PositionsTotal() == 0) {
        double ask1, bid1, ask2, bid2;
        
        SymbolInfoDouble(Symbol1, SYMBOL_ASK, ask1);
        SymbolInfoDouble(Symbol1, SYMBOL_BID, bid1);
        SymbolInfoDouble(Symbol2, SYMBOL_ASK, ask2);
        SymbolInfoDouble(Symbol2, SYMBOL_BID, bid2);

        int coinToss = MathRand() % 2; // Simulate coin toss

        if (coinToss == 0) // Heads - Open BUY on Symbol1, SELL on Symbol2
        {
            trade1.Buy(Lots, Symbol1, ask1, bid1 - StopLoss * _Point, bid1 + TakeProfit * _Point);
            trade2.Sell(Lots, Symbol2, bid2, ask2 + StopLoss * _Point, ask2 - TakeProfit * _Point);
        }
        else // Tails - Open SELL on Symbol1, BUY on Symbol2
        {
            trade1.Sell(Lots, Symbol1, bid1, ask1 + StopLoss * _Point, ask1 - TakeProfit * _Point);
            trade2.Buy(Lots, Symbol2, ask2, bid2 - StopLoss * _Point, bid2 + TakeProfit * _Point);
        }
    }
}

