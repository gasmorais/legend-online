package com.road.yishi.proto.steel
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SteelRankDetailMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.steel.SteelRankMsg")]
      public var steelRankMsg:Array = [];
      
      private var redTeamScore$field:int;
      
      private var hasField$0:uint = 0;
      
      private var blueTeamScore$field:int;
      
      private var score$field:int;
      
      public function SteelRankDetailMsg()
      {
         super();
      }
      
      public function removeRedTeamScore() : void
      {
         hasField$0 &= 4294967294;
         redTeamScore$field = new int();
      }
      
      public function get hasRedTeamScore() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set redTeamScore(param1:int) : void
      {
         hasField$0 |= 1;
         redTeamScore$field = param1;
      }
      
      public function get redTeamScore() : int
      {
         return redTeamScore$field;
      }
      
      public function removeBlueTeamScore() : void
      {
         hasField$0 &= 4294967293;
         blueTeamScore$field = new int();
      }
      
      public function get hasBlueTeamScore() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set blueTeamScore(param1:int) : void
      {
         hasField$0 |= 2;
         blueTeamScore$field = param1;
      }
      
      public function get blueTeamScore() : int
      {
         return blueTeamScore$field;
      }
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967291;
         score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 4;
         score$field = param1;
      }
      
      public function get score() : int
      {
         return score$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < steelRankMsg.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,steelRankMsg[_loc2_]);
            _loc2_++;
         }
         if(hasRedTeamScore)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,redTeamScore$field);
         }
         if(hasBlueTeamScore)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,blueTeamScore$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:SteelRankMsg = null;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc4_ = new SteelRankMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  steelRankMsg.push(_loc4_);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SteelRankDetailMsg.redTeamScore cannot be set twice.");
                  }
                  _loc5_++;
                  redTeamScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SteelRankDetailMsg.blueTeamScore cannot be set twice.");
                  }
                  _loc3_++;
                  blueTeamScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SteelRankDetailMsg.score cannot be set twice.");
                  }
                  _loc7_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

