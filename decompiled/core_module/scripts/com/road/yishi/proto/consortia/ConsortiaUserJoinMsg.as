package com.road.yishi.proto.consortia
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaUserJoinMsg extends Message implements IExternalizable
   {
      
      private var quest_site$field:ByteArray;
      
      [ArrayElementType("com.road.yishi.proto.consortia.ConsortiaConditionMsg")]
      public var conditionList:Array = [];
      
      private var reputation$field:int;
      
      private var hasField$0:uint = 0;
      
      private var active_point$field:int;
      
      private var weekly_active_point$field:int;
      
      public function ConsortiaUserJoinMsg()
      {
         super();
      }
      
      public function removeQuestSite() : void
      {
         quest_site$field = null;
      }
      
      public function get hasQuestSite() : Boolean
      {
         return quest_site$field != null;
      }
      
      public function set questSite(param1:ByteArray) : void
      {
         quest_site$field = param1;
      }
      
      public function get questSite() : ByteArray
      {
         return quest_site$field;
      }
      
      public function removeReputation() : void
      {
         hasField$0 &= 4294967294;
         reputation$field = new int();
      }
      
      public function get hasReputation() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set reputation(param1:int) : void
      {
         hasField$0 |= 1;
         reputation$field = param1;
      }
      
      public function get reputation() : int
      {
         return reputation$field;
      }
      
      public function removeActivePoint() : void
      {
         hasField$0 &= 4294967293;
         active_point$field = new int();
      }
      
      public function get hasActivePoint() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set activePoint(param1:int) : void
      {
         hasField$0 |= 2;
         active_point$field = param1;
      }
      
      public function get activePoint() : int
      {
         return active_point$field;
      }
      
      public function removeWeeklyActivePoint() : void
      {
         hasField$0 &= 4294967291;
         weekly_active_point$field = new int();
      }
      
      public function get hasWeeklyActivePoint() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set weeklyActivePoint(param1:int) : void
      {
         hasField$0 |= 4;
         weekly_active_point$field = param1;
      }
      
      public function get weeklyActivePoint() : int
      {
         return weekly_active_point$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasQuestSite)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_BYTES(param1,quest_site$field);
         }
         _loc2_ = 0;
         while(_loc2_ < conditionList.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,conditionList[_loc2_]);
            _loc2_++;
         }
         if(hasReputation)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,reputation$field);
         }
         if(hasActivePoint)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,active_point$field);
         }
         if(hasWeeklyActivePoint)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,weekly_active_point$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc6_:ConsortiaConditionMsg = null;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaUserJoinMsg.questSite cannot be set twice.");
                  }
                  _loc5_++;
                  questSite = ReadUtils.read$TYPE_BYTES(param1);
                  break;
               case 1:
                  _loc6_ = new ConsortiaConditionMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  conditionList.push(_loc6_);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaUserJoinMsg.reputation cannot be set twice.");
                  }
                  _loc3_++;
                  reputation = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaUserJoinMsg.activePoint cannot be set twice.");
                  }
                  _loc7_++;
                  activePoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaUserJoinMsg.weeklyActivePoint cannot be set twice.");
                  }
                  _loc4_++;
                  weeklyActivePoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

