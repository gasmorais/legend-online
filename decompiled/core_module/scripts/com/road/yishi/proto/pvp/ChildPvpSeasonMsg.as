package com.road.yishi.proto.pvp
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChildPvpSeasonMsg extends Message implements IExternalizable
   {
      
      private var seasonId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var seasonStartDate$field:String;
      
      private var seasonStopDate$field:String;
      
      private var matchStartDate$field:String;
      
      private var matchStopDate$field:String;
      
      private var totalDay$field:int;
      
      public function ChildPvpSeasonMsg()
      {
         super();
      }
      
      public function removeSeasonId() : void
      {
         hasField$0 &= 4294967294;
         seasonId$field = new int();
      }
      
      public function get hasSeasonId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set seasonId(param1:int) : void
      {
         hasField$0 |= 1;
         seasonId$field = param1;
      }
      
      public function get seasonId() : int
      {
         return seasonId$field;
      }
      
      public function removeSeasonStartDate() : void
      {
         seasonStartDate$field = null;
      }
      
      public function get hasSeasonStartDate() : Boolean
      {
         return seasonStartDate$field != null;
      }
      
      public function set seasonStartDate(param1:String) : void
      {
         seasonStartDate$field = param1;
      }
      
      public function get seasonStartDate() : String
      {
         return seasonStartDate$field;
      }
      
      public function removeSeasonStopDate() : void
      {
         seasonStopDate$field = null;
      }
      
      public function get hasSeasonStopDate() : Boolean
      {
         return seasonStopDate$field != null;
      }
      
      public function set seasonStopDate(param1:String) : void
      {
         seasonStopDate$field = param1;
      }
      
      public function get seasonStopDate() : String
      {
         return seasonStopDate$field;
      }
      
      public function removeMatchStartDate() : void
      {
         matchStartDate$field = null;
      }
      
      public function get hasMatchStartDate() : Boolean
      {
         return matchStartDate$field != null;
      }
      
      public function set matchStartDate(param1:String) : void
      {
         matchStartDate$field = param1;
      }
      
      public function get matchStartDate() : String
      {
         return matchStartDate$field;
      }
      
      public function removeMatchStopDate() : void
      {
         matchStopDate$field = null;
      }
      
      public function get hasMatchStopDate() : Boolean
      {
         return matchStopDate$field != null;
      }
      
      public function set matchStopDate(param1:String) : void
      {
         matchStopDate$field = param1;
      }
      
      public function get matchStopDate() : String
      {
         return matchStopDate$field;
      }
      
      public function removeTotalDay() : void
      {
         hasField$0 &= 4294967293;
         totalDay$field = new int();
      }
      
      public function get hasTotalDay() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set totalDay(param1:int) : void
      {
         hasField$0 |= 2;
         totalDay$field = param1;
      }
      
      public function get totalDay() : int
      {
         return totalDay$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasSeasonId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,seasonId$field);
         }
         if(hasSeasonStartDate)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,seasonStartDate$field);
         }
         if(hasSeasonStopDate)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,seasonStopDate$field);
         }
         if(hasMatchStartDate)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,matchStartDate$field);
         }
         if(hasMatchStopDate)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,matchStopDate$field);
         }
         if(hasTotalDay)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,totalDay$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPvpSeasonMsg.seasonId cannot be set twice.");
                  }
                  _loc3_++;
                  seasonId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPvpSeasonMsg.seasonStartDate cannot be set twice.");
                  }
                  _loc9_++;
                  seasonStartDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPvpSeasonMsg.seasonStopDate cannot be set twice.");
                  }
                  _loc5_++;
                  seasonStopDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPvpSeasonMsg.matchStartDate cannot be set twice.");
                  }
                  _loc6_++;
                  matchStartDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPvpSeasonMsg.matchStopDate cannot be set twice.");
                  }
                  _loc4_++;
                  matchStopDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPvpSeasonMsg.totalDay cannot be set twice.");
                  }
                  _loc7_++;
                  totalDay = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

