package com.road.yishi.proto.pet
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PetBossScoreMsg extends Message implements IExternalizable
   {
      
      private var order$field:int;
      
      private var hasField$0:uint = 0;
      
      private var score$field:int;
      
      private var property1$field:int;
      
      private var property2$field:String;
      
      [ArrayElementType("com.road.yishi.proto.pet.ScoreInfoMsg")]
      public var infos:Array = [];
      
      private var remain_time$field:int;
      
      private var wound$field:Int64;
      
      public function PetBossScoreMsg()
      {
         super();
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
      
      public function removeProperty1() : void
      {
         hasField$0 &= 4294967291;
         property1$field = new int();
      }
      
      public function get hasProperty1() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set property1(param1:int) : void
      {
         hasField$0 |= 4;
         property1$field = param1;
      }
      
      public function get property1() : int
      {
         return property1$field;
      }
      
      public function removeProperty2() : void
      {
         property2$field = null;
      }
      
      public function get hasProperty2() : Boolean
      {
         return property2$field != null;
      }
      
      public function set property2(param1:String) : void
      {
         property2$field = param1;
      }
      
      public function get property2() : String
      {
         return property2$field;
      }
      
      public function removeRemainTime() : void
      {
         hasField$0 &= 4294967287;
         remain_time$field = new int();
      }
      
      public function get hasRemainTime() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set remainTime(param1:int) : void
      {
         hasField$0 |= 8;
         remain_time$field = param1;
      }
      
      public function get remainTime() : int
      {
         return remain_time$field;
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
         var _loc2_:* = 0;
         if(hasOrder)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,order$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasProperty1)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,property1$field);
         }
         if(hasProperty2)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,property2$field);
         }
         _loc2_ = 0;
         while(_loc2_ < infos.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,infos[_loc2_]);
            _loc2_++;
         }
         if(hasRemainTime)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,remain_time$field);
         }
         if(hasWound)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT64(param1,wound$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc6_:ScoreInfoMsg = null;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         var _loc4_:uint = 0;
         var _loc10_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PetBossScoreMsg.order cannot be set twice.");
                  }
                  _loc3_++;
                  order = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PetBossScoreMsg.score cannot be set twice.");
                  }
                  _loc9_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PetBossScoreMsg.property1 cannot be set twice.");
                  }
                  _loc4_++;
                  property1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PetBossScoreMsg.property2 cannot be set twice.");
                  }
                  _loc10_++;
                  property2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  _loc6_ = new ScoreInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  infos.push(_loc6_);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PetBossScoreMsg.remainTime cannot be set twice.");
                  }
                  _loc5_++;
                  remainTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PetBossScoreMsg.wound cannot be set twice.");
                  }
                  _loc7_++;
                  wound = ReadUtils.read$TYPE_INT64(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

