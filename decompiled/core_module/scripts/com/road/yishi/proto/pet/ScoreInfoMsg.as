package com.road.yishi.proto.pet
{
   import com.netease.protobuf.Int64;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ScoreInfoMsg extends Message implements IExternalizable
   {
      
      private var nickName$field:String;
      
      private var order$field:int;
      
      private var hasField$0:uint = 0;
      
      private var score$field:int;
      
      private var team_id$field:int;
      
      private var job$field:int;
      
      private var wound$field:Int64;
      
      public function ScoreInfoMsg()
      {
         super();
      }
      
      public function removeNickName() : void
      {
         nickName$field = null;
      }
      
      public function get hasNickName() : Boolean
      {
         return nickName$field != null;
      }
      
      public function set nickName(param1:String) : void
      {
         nickName$field = param1;
      }
      
      public function get nickName() : String
      {
         return nickName$field;
      }
      
      public function removeOrder() : void
      {
         hasField$0 &= 4294967294;
         order$field = new int();
      }
      
      public function get hasOrder() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set order(param1:int) : void
      {
         hasField$0 |= 1;
         order$field = param1;
      }
      
      public function get order() : int
      {
         return order$field;
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
      
      public function removeTeamId() : void
      {
         hasField$0 &= 4294967291;
         team_id$field = new int();
      }
      
      public function get hasTeamId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set teamId(param1:int) : void
      {
         hasField$0 |= 4;
         team_id$field = param1;
      }
      
      public function get teamId() : int
      {
         return team_id$field;
      }
      
      public function removeJob() : void
      {
         hasField$0 &= 4294967287;
         job$field = new int();
      }
      
      public function get hasJob() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set job(param1:int) : void
      {
         hasField$0 |= 8;
         job$field = param1;
      }
      
      public function get job() : int
      {
         return job$field;
      }
      
      public function removeWound() : void
      {
         wound$field = null;
      }
      
      public function get hasWound() : Boolean
      {
         return wound$field != null;
      }
      
      public function set wound(param1:Int64) : void
      {
         wound$field = param1;
      }
      
      public function get wound() : Int64
      {
         return wound$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,nickName$field);
         }
         if(hasOrder)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,order$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasTeamId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,team_id$field);
         }
         if(hasJob)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,job$field);
         }
         if(hasWound)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT64(param1,wound$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ScoreInfoMsg.nickName cannot be set twice.");
                  }
                  _loc3_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ScoreInfoMsg.order cannot be set twice.");
                  }
                  _loc4_++;
                  order = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ScoreInfoMsg.score cannot be set twice.");
                  }
                  _loc8_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ScoreInfoMsg.teamId cannot be set twice.");
                  }
                  _loc9_++;
                  teamId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ScoreInfoMsg.job cannot be set twice.");
                  }
                  _loc5_++;
                  job = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ScoreInfoMsg.wound cannot be set twice.");
                  }
                  _loc6_++;
                  wound = ReadUtils.read$TYPE_INT64(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

