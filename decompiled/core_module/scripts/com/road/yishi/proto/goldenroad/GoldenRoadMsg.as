package com.road.yishi.proto.goldenroad
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GoldenRoadMsg extends Message implements IExternalizable
   {
      
      private var playerStatue$field:int;
      
      private var hasField$0:uint = 0;
      
      private var score$field:int;
      
      [ArrayElementType("com.road.yishi.proto.goldenroad.CellInfoMsg")]
      public var cellInfo:Array = [];
      
      public function GoldenRoadMsg()
      {
         super();
      }
      
      public function removePlayerStatue() : void
      {
         hasField$0 &= 4294967294;
         playerStatue$field = new int();
      }
      
      public function get hasPlayerStatue() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set playerStatue(param1:int) : void
      {
         hasField$0 |= 1;
         playerStatue$field = param1;
      }
      
      public function get playerStatue() : int
      {
         return playerStatue$field;
      }
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967293;
         score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 2;
         score$field = param1;
      }
      
      public function get score() : int
      {
         return score$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasPlayerStatue)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,playerStatue$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         _loc2_ = 0;
         while(_loc2_ < cellInfo.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,cellInfo[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:CellInfoMsg = null;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GoldenRoadMsg.playerStatue cannot be set twice.");
                  }
                  _loc4_++;
                  playerStatue = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: GoldenRoadMsg.score cannot be set twice.");
                  }
                  _loc6_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  _loc3_ = new CellInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  cellInfo.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

