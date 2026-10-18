package com.road.yishi.proto.blackjack
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BlackJackMsg extends Message implements IExternalizable
   {
      
      private var iD$field:int;
      
      private var hasField$0:uint = 0;
      
      private var cost$field:int;
      
      private var winItemReward$field:String;
      
      private var generalItemReward$field:String;
      
      private var winScoreReward$field:int;
      
      private var generalScoreReward$field:int;
      
      private var changeCardCost$field:int;
      
      public function BlackJackMsg()
      {
         super();
      }
      
      public function removeID() : void
      {
         hasField$0 &= 4294967294;
         iD$field = new int();
      }
      
      public function get hasID() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set iD(param1:int) : void
      {
         hasField$0 |= 1;
         iD$field = param1;
      }
      
      public function get iD() : int
      {
         return iD$field;
      }
      
      public function removeCost() : void
      {
         hasField$0 &= 4294967293;
         cost$field = new int();
      }
      
      public function get hasCost() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set cost(param1:int) : void
      {
         hasField$0 |= 2;
         cost$field = param1;
      }
      
      public function get cost() : int
      {
         return cost$field;
      }
      
      public function removeWinItemReward() : void
      {
         winItemReward$field = null;
      }
      
      public function get hasWinItemReward() : Boolean
      {
         return winItemReward$field != null;
      }
      
      public function set winItemReward(param1:String) : void
      {
         winItemReward$field = param1;
      }
      
      public function get winItemReward() : String
      {
         return winItemReward$field;
      }
      
      public function removeGeneralItemReward() : void
      {
         generalItemReward$field = null;
      }
      
      public function get hasGeneralItemReward() : Boolean
      {
         return generalItemReward$field != null;
      }
      
      public function set generalItemReward(param1:String) : void
      {
         generalItemReward$field = param1;
      }
      
      public function get generalItemReward() : String
      {
         return generalItemReward$field;
      }
      
      public function removeWinScoreReward() : void
      {
         hasField$0 &= 4294967291;
         winScoreReward$field = new int();
      }
      
      public function get hasWinScoreReward() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set winScoreReward(param1:int) : void
      {
         hasField$0 |= 4;
         winScoreReward$field = param1;
      }
      
      public function get winScoreReward() : int
      {
         return winScoreReward$field;
      }
      
      public function removeGeneralScoreReward() : void
      {
         hasField$0 &= 4294967287;
         generalScoreReward$field = new int();
      }
      
      public function get hasGeneralScoreReward() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set generalScoreReward(param1:int) : void
      {
         hasField$0 |= 8;
         generalScoreReward$field = param1;
      }
      
      public function get generalScoreReward() : int
      {
         return generalScoreReward$field;
      }
      
      public function removeChangeCardCost() : void
      {
         hasField$0 &= 4294967279;
         changeCardCost$field = new int();
      }
      
      public function get hasChangeCardCost() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set changeCardCost(param1:int) : void
      {
         hasField$0 |= 16;
         changeCardCost$field = param1;
      }
      
      public function get changeCardCost() : int
      {
         return changeCardCost$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasID)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,iD$field);
         }
         if(hasCost)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,cost$field);
         }
         if(hasWinItemReward)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,winItemReward$field);
         }
         if(hasGeneralItemReward)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,generalItemReward$field);
         }
         if(hasWinScoreReward)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,winScoreReward$field);
         }
         if(hasGeneralScoreReward)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,generalScoreReward$field);
         }
         if(hasChangeCardCost)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,changeCardCost$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc10_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: BlackJackMsg.iD cannot be set twice.");
                  }
                  _loc9_++;
                  iD = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: BlackJackMsg.cost cannot be set twice.");
                  }
                  _loc5_++;
                  cost = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: BlackJackMsg.winItemReward cannot be set twice.");
                  }
                  _loc6_++;
                  winItemReward = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: BlackJackMsg.generalItemReward cannot be set twice.");
                  }
                  _loc4_++;
                  generalItemReward = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: BlackJackMsg.winScoreReward cannot be set twice.");
                  }
                  _loc10_++;
                  winScoreReward = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: BlackJackMsg.generalScoreReward cannot be set twice.");
                  }
                  _loc7_++;
                  generalScoreReward = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BlackJackMsg.changeCardCost cannot be set twice.");
                  }
                  _loc3_++;
                  changeCardCost = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

