package com.road.yishi.proto.module
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RemainsExploreMsg extends Message implements IExternalizable
   {
      
      private var tinder$field:int;
      
      private var hasField$0:uint = 0;
      
      private var canBuyTimes$field:int;
      
      private var dayLiveness$field:int;
      
      private var weekLiveness$field:int;
      
      private var boss1NodeId$field:int;
      
      private var boss2NodeId$field:int;
      
      private var boxStates$field:String;
      
      [ArrayElementType("com.road.yishi.proto.module.RemainsExploreNodeMsg")]
      public var nodeList:Array = [];
      
      public function RemainsExploreMsg()
      {
         super();
      }
      
      public function removeTinder() : void
      {
         hasField$0 &= 4294967294;
         tinder$field = new int();
      }
      
      public function get hasTinder() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set tinder(param1:int) : void
      {
         hasField$0 |= 1;
         tinder$field = param1;
      }
      
      public function get tinder() : int
      {
         return tinder$field;
      }
      
      public function removeCanBuyTimes() : void
      {
         hasField$0 &= 4294967293;
         canBuyTimes$field = new int();
      }
      
      public function get hasCanBuyTimes() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set canBuyTimes(param1:int) : void
      {
         hasField$0 |= 2;
         canBuyTimes$field = param1;
      }
      
      public function get canBuyTimes() : int
      {
         return canBuyTimes$field;
      }
      
      public function removeDayLiveness() : void
      {
         hasField$0 &= 4294967291;
         dayLiveness$field = new int();
      }
      
      public function get hasDayLiveness() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set dayLiveness(param1:int) : void
      {
         hasField$0 |= 4;
         dayLiveness$field = param1;
      }
      
      public function get dayLiveness() : int
      {
         return dayLiveness$field;
      }
      
      public function removeWeekLiveness() : void
      {
         hasField$0 &= 4294967287;
         weekLiveness$field = new int();
      }
      
      public function get hasWeekLiveness() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set weekLiveness(param1:int) : void
      {
         hasField$0 |= 8;
         weekLiveness$field = param1;
      }
      
      public function get weekLiveness() : int
      {
         return weekLiveness$field;
      }
      
      public function removeBoss1NodeId() : void
      {
         hasField$0 &= 4294967279;
         boss1NodeId$field = new int();
      }
      
      public function get hasBoss1NodeId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set boss1NodeId(param1:int) : void
      {
         hasField$0 |= 16;
         boss1NodeId$field = param1;
      }
      
      public function get boss1NodeId() : int
      {
         return boss1NodeId$field;
      }
      
      public function removeBoss2NodeId() : void
      {
         hasField$0 &= 4294967263;
         boss2NodeId$field = new int();
      }
      
      public function get hasBoss2NodeId() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set boss2NodeId(param1:int) : void
      {
         hasField$0 |= 32;
         boss2NodeId$field = param1;
      }
      
      public function get boss2NodeId() : int
      {
         return boss2NodeId$field;
      }
      
      public function removeBoxStates() : void
      {
         boxStates$field = null;
      }
      
      public function get hasBoxStates() : Boolean
      {
         return boxStates$field != null;
      }
      
      public function set boxStates(param1:String) : void
      {
         boxStates$field = param1;
      }
      
      public function get boxStates() : String
      {
         return boxStates$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasTinder)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,tinder$field);
         }
         if(hasCanBuyTimes)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,canBuyTimes$field);
         }
         if(hasDayLiveness)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,dayLiveness$field);
         }
         if(hasWeekLiveness)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,weekLiveness$field);
         }
         if(hasBoss1NodeId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,boss1NodeId$field);
         }
         if(hasBoss2NodeId)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,boss2NodeId$field);
         }
         if(hasBoxStates)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,boxStates$field);
         }
         _loc2_ = 0;
         while(_loc2_ < nodeList.length)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_MESSAGE(param1,nodeList[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc5_:RemainsExploreNodeMsg = null;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc11_:uint = 0;
         var _loc8_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: RemainsExploreMsg.tinder cannot be set twice.");
                  }
                  _loc9_++;
                  tinder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RemainsExploreMsg.canBuyTimes cannot be set twice.");
                  }
                  _loc3_++;
                  canBuyTimes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: RemainsExploreMsg.dayLiveness cannot be set twice.");
                  }
                  _loc6_++;
                  dayLiveness = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: RemainsExploreMsg.weekLiveness cannot be set twice.");
                  }
                  _loc4_++;
                  weekLiveness = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: RemainsExploreMsg.boss1NodeId cannot be set twice.");
                  }
                  _loc11_++;
                  boss1NodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: RemainsExploreMsg.boss2NodeId cannot be set twice.");
                  }
                  _loc8_++;
                  boss2NodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: RemainsExploreMsg.boxStates cannot be set twice.");
                  }
                  _loc7_++;
                  boxStates = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  _loc5_ = new RemainsExploreNodeMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  nodeList.push(_loc5_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

