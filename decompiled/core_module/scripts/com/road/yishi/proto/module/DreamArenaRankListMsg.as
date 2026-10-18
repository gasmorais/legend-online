package com.road.yishi.proto.module
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class DreamArenaRankListMsg extends Message implements IExternalizable
   {
      
      private var myRank$field:int;
      
      private var hasField$0:uint = 0;
      
      private var myScore$field:int;
      
      [ArrayElementType("com.road.yishi.proto.module.DreamArenaRankMsg")]
      public var rankList:Array = [];
      
      public function DreamArenaRankListMsg()
      {
         super();
      }
      
      public function removeMyRank() : void
      {
         hasField$0 &= 4294967294;
         myRank$field = new int();
      }
      
      public function get hasMyRank() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set myRank(param1:int) : void
      {
         hasField$0 |= 1;
         myRank$field = param1;
      }
      
      public function get myRank() : int
      {
         return myRank$field;
      }
      
      public function removeMyScore() : void
      {
         hasField$0 &= 4294967293;
         myScore$field = new int();
      }
      
      public function get hasMyScore() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set myScore(param1:int) : void
      {
         hasField$0 |= 2;
         myScore$field = param1;
      }
      
      public function get myScore() : int
      {
         return myScore$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasMyRank)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,myRank$field);
         }
         if(hasMyScore)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,myScore$field);
         }
         _loc2_ = 0;
         while(_loc2_ < rankList.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,rankList[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:DreamArenaRankMsg = null;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: DreamArenaRankListMsg.myRank cannot be set twice.");
                  }
                  _loc3_++;
                  myRank = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: DreamArenaRankListMsg.myScore cannot be set twice.");
                  }
                  _loc5_++;
                  myScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  _loc4_ = new DreamArenaRankMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  rankList.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

