package com.road.yishi.proto.Glory
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GloryBetMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.Glory.PlayerBetMsg")]
      public var playerBet:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.Glory.GloryScheduleMsg")]
      public var allSchedule:Array = [];
      
      private var round$field:int;
      
      private var hasField$0:uint = 0;
      
      public function GloryBetMsg()
      {
         super();
      }
      
      public function removeRound() : void
      {
         hasField$0 &= 4294967294;
         round$field = new int();
      }
      
      public function get hasRound() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set round(param1:int) : void
      {
         hasField$0 |= 1;
         round$field = param1;
      }
      
      public function get round() : int
      {
         return round$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         _loc3_ = 0;
         while(_loc3_ < playerBet.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,playerBet[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < allSchedule.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,allSchedule[_loc2_]);
            _loc2_++;
         }
         if(hasRound)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,round$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:PlayerBetMsg = null;
         var _loc5_:GloryScheduleMsg = null;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc4_ = new PlayerBetMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  playerBet.push(_loc4_);
                  break;
               case 1:
                  _loc5_ = new GloryScheduleMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  allSchedule.push(_loc5_);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GloryBetMsg.round cannot be set twice.");
                  }
                  _loc3_++;
                  round = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

