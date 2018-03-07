//+------------------------------------------------------------------+
//|                                              SetMarginTarget.mq5 |
//|                                   Copyright 2018, Jade Corroding |
//|                            https://www.twitter.com/jadecorroding |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property description "Set a percentage of the used margin to define profit taking."
#property description "for example [ Used Margin * PCT ] = [TotalAccountProfit]"
#property description "Used Margin = 100 | 10 PCT of the margin = TotalAccountProft 10 Base Currency."

#include <Trade/Trade.mqh>
CTrade m_trade;

input int InpSetPercentage=0; // Set Percentage of Margin
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---

//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---

  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   Calculate();

  }
//+------------------------------------------------------------------+

void Calculate()
  {
   double SetAccountMargin,
   SetAccountBalance,
   SetTotalAccountProfit,
   SetAccountEquity,
   SetCalculation;

   SetAccountBalance= AccountInfoDouble(ACCOUNT_BALANCE);
   SetAccountEquity = AccountInfoDouble(ACCOUNT_EQUITY);
   SetTotalAccountProfit=AccountInfoDouble(ACCOUNT_PROFIT);
   SetAccountMargin=AccountInfoDouble(ACCOUNT_MARGIN);

   SetCalculation=(SetAccountMargin/100)*InpSetPercentage;

   if(SetTotalAccountProfit>=SetCalculation)
     {
      int i=PositionsTotal()-1;
      while(i<0)
        {
         if(m_trade.PositionClose(PositionGetSymbol(i)))i--;
        }
     }
  }
//+------------------------------------------------------------------+
