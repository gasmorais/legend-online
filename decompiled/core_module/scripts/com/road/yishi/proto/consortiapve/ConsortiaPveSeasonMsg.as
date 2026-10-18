package com.road.yishi.proto.consortiapve
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaPveSeasonMsg extends Message implements IExternalizable
   {
      
      private var seasonId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var state$field:int;
      
      private var beginTime$field:String;
      
      private var endTime$field:String;
      
      public function ConsortiaPveSeasonMsg()
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
      
      public function removeState() : void
      {
         hasField$0 &= 4294967293;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 2;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeBeginTime() : void
      {
         beginTime$field = null;
      }
      
      public function get hasBeginTime() : Boolean
      {
         return beginTime$field != null;
      }
      
      public function set beginTime(param1:String) : void
      {
         beginTime$field = param1;
      }
      
      public function get beginTime() : String
      {
         return beginTime$field;
      }
      
      public function removeEndTime() : void
      {
         endTime$field = null;
      }
      
      public function get hasEndTime() : Boolean
      {
         return endTime$field != null;
      }
      
      public function set endTime(param1:String) : void
      {
         endTime$field = param1;
      }
      
      public function get endTime() : String
      {
         return endTime$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasSeasonId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,seasonId$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasBeginTime)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,beginTime$field);
         }
         if(hasEndTime)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,endTime$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaPveSeasonMsg.seasonId cannot be set twice.");
                  }
                  _loc3_++;
                  seasonId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaPveSeasonMsg.state cannot be set twice.");
                  }
                  _loc5_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaPveSeasonMsg.beginTime cannot be set twice.");
                  }
                  _loc7_++;
                  beginTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaPveSeasonMsg.endTime cannot be set twice.");
                  }
                  _loc4_++;
                  endTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

