package com.road.yishi.proto.consortiaplay
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MinosDataMsg extends Message implements IExternalizable
   {
      
      private var seasonId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var state$field:int;
      
      private var beginTime$field:String;
      
      private var endTime$field:String;
      
      [ArrayElementType("com.road.yishi.proto.consortiaplay.MinosLevelMsg")]
      public var levels:Array = [];
      
      public function MinosDataMsg()
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
         var _loc2_:* = 0;
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
         _loc2_ = 0;
         while(_loc2_ < levels.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,levels[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc5_:MinosLevelMsg = null;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MinosDataMsg.seasonId cannot be set twice.");
                  }
                  _loc3_++;
                  seasonId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MinosDataMsg.state cannot be set twice.");
                  }
                  _loc6_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: MinosDataMsg.beginTime cannot be set twice.");
                  }
                  _loc8_++;
                  beginTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MinosDataMsg.endTime cannot be set twice.");
                  }
                  _loc4_++;
                  endTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  _loc5_ = new MinosLevelMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  levels.push(_loc5_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

