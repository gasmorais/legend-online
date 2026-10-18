package com.road.yishi.proto.secretwar
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SecretWarResultMsg extends Message implements IExternalizable
   {
      
      private var winCamp$field:int;
      
      private var hasField$0:uint = 0;
      
      private var blueScore$field:int;
      
      private var redScore$field:int;
      
      [ArrayElementType("com.road.yishi.proto.secretwar.SecretWarRankMsg")]
      public var ranks:Array = [];
      
      public function SecretWarResultMsg()
      {
         super();
      }
      
      public function removeWinCamp() : void
      {
         hasField$0 &= 4294967294;
         winCamp$field = new int();
      }
      
      public function get hasWinCamp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set winCamp(param1:int) : void
      {
         hasField$0 |= 1;
         winCamp$field = param1;
      }
      
      public function get winCamp() : int
      {
         return winCamp$field;
      }
      
      public function removeBlueScore() : void
      {
         hasField$0 &= 4294967293;
         blueScore$field = new int();
      }
      
      public function get hasBlueScore() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set blueScore(param1:int) : void
      {
         hasField$0 |= 2;
         blueScore$field = param1;
      }
      
      public function get blueScore() : int
      {
         return blueScore$field;
      }
      
      public function removeRedScore() : void
      {
         hasField$0 &= 4294967291;
         redScore$field = new int();
      }
      
      public function get hasRedScore() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set redScore(param1:int) : void
      {
         hasField$0 |= 4;
         redScore$field = param1;
      }
      
      public function get redScore() : int
      {
         return redScore$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasWinCamp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,winCamp$field);
         }
         if(hasBlueScore)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,blueScore$field);
         }
         if(hasRedScore)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,redScore$field);
         }
         _loc2_ = 0;
         while(_loc2_ < ranks.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,ranks[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:SecretWarRankMsg = null;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarResultMsg.winCamp cannot be set twice.");
                  }
                  _loc5_++;
                  winCamp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarResultMsg.blueScore cannot be set twice.");
                  }
                  _loc3_++;
                  blueScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarResultMsg.redScore cannot be set twice.");
                  }
                  _loc7_++;
                  redScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  _loc4_ = new SecretWarRankMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  ranks.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

