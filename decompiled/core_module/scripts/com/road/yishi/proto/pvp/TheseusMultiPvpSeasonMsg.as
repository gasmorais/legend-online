package com.road.yishi.proto.pvp
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TheseusMultiPvpSeasonMsg extends Message implements IExternalizable
   {
      
      private var seasonId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var startDate$field:String;
      
      private var stopDate$field:String;
      
      private var closeDate$field:String;
      
      public function TheseusMultiPvpSeasonMsg()
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
      
      public function removeStartDate() : void
      {
         startDate$field = null;
      }
      
      public function get hasStartDate() : Boolean
      {
         return startDate$field != null;
      }
      
      public function set startDate(param1:String) : void
      {
         startDate$field = param1;
      }
      
      public function get startDate() : String
      {
         return startDate$field;
      }
      
      public function removeStopDate() : void
      {
         stopDate$field = null;
      }
      
      public function get hasStopDate() : Boolean
      {
         return stopDate$field != null;
      }
      
      public function set stopDate(param1:String) : void
      {
         stopDate$field = param1;
      }
      
      public function get stopDate() : String
      {
         return stopDate$field;
      }
      
      public function removeCloseDate() : void
      {
         closeDate$field = null;
      }
      
      public function get hasCloseDate() : Boolean
      {
         return closeDate$field != null;
      }
      
      public function set closeDate(param1:String) : void
      {
         closeDate$field = param1;
      }
      
      public function get closeDate() : String
      {
         return closeDate$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasSeasonId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,seasonId$field);
         }
         if(hasStartDate)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,startDate$field);
         }
         if(hasStopDate)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,stopDate$field);
         }
         if(hasCloseDate)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,closeDate$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusMultiPvpSeasonMsg.seasonId cannot be set twice.");
                  }
                  _loc3_++;
                  seasonId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusMultiPvpSeasonMsg.startDate cannot be set twice.");
                  }
                  _loc7_++;
                  startDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusMultiPvpSeasonMsg.stopDate cannot be set twice.");
                  }
                  _loc4_++;
                  stopDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusMultiPvpSeasonMsg.closeDate cannot be set twice.");
                  }
                  _loc5_++;
                  closeDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

