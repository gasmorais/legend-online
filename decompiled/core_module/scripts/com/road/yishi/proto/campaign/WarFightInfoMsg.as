package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class WarFightInfoMsg extends Message implements IExternalizable
   {
      
      private var team_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var score$field:int;
      
      private var order$field:int;
      
      private var geste$field:int;
      
      private var hit_count$field:int;
      
      private var left_time$field:int;
      
      private var one_count$field:int;
      
      private var two_count$field:int;
      
      private var one_score$field:int;
      
      private var two_score$field:int;
      
      private var one_FlagCount$field:int;
      
      private var two_FlagCount$field:int;
      
      public function WarFightInfoMsg()
      {
         super();
      }
      
      public function removeTeamId() : void
      {
         hasField$0 &= 4294967294;
         team_id$field = new int();
      }
      
      public function get hasTeamId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set teamId(param1:int) : void
      {
         hasField$0 |= 1;
         team_id$field = param1;
      }
      
      public function get teamId() : int
      {
         return team_id$field;
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
      
      public function removeOrder() : void
      {
         hasField$0 &= 4294967291;
         order$field = new int();
      }
      
      public function get hasOrder() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set order(param1:int) : void
      {
         hasField$0 |= 4;
         order$field = param1;
      }
      
      public function get order() : int
      {
         return order$field;
      }
      
      public function removeGeste() : void
      {
         hasField$0 &= 4294967287;
         geste$field = new int();
      }
      
      public function get hasGeste() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set geste(param1:int) : void
      {
         hasField$0 |= 8;
         geste$field = param1;
      }
      
      public function get geste() : int
      {
         return geste$field;
      }
      
      public function removeHitCount() : void
      {
         hasField$0 &= 4294967279;
         hit_count$field = new int();
      }
      
      public function get hasHitCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set hitCount(param1:int) : void
      {
         hasField$0 |= 16;
         hit_count$field = param1;
      }
      
      public function get hitCount() : int
      {
         return hit_count$field;
      }
      
      public function removeLeftTime() : void
      {
         hasField$0 &= 4294967263;
         left_time$field = new int();
      }
      
      public function get hasLeftTime() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set leftTime(param1:int) : void
      {
         hasField$0 |= 32;
         left_time$field = param1;
      }
      
      public function get leftTime() : int
      {
         return left_time$field;
      }
      
      public function removeOneCount() : void
      {
         hasField$0 &= 4294967231;
         one_count$field = new int();
      }
      
      public function get hasOneCount() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set oneCount(param1:int) : void
      {
         hasField$0 |= 64;
         one_count$field = param1;
      }
      
      public function get oneCount() : int
      {
         return one_count$field;
      }
      
      public function removeTwoCount() : void
      {
         hasField$0 &= 4294967167;
         two_count$field = new int();
      }
      
      public function get hasTwoCount() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set twoCount(param1:int) : void
      {
         hasField$0 |= 128;
         two_count$field = param1;
      }
      
      public function get twoCount() : int
      {
         return two_count$field;
      }
      
      public function removeOneScore() : void
      {
         hasField$0 &= 4294967039;
         one_score$field = new int();
      }
      
      public function get hasOneScore() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set oneScore(param1:int) : void
      {
         hasField$0 |= 256;
         one_score$field = param1;
      }
      
      public function get oneScore() : int
      {
         return one_score$field;
      }
      
      public function removeTwoScore() : void
      {
         hasField$0 &= 4294966783;
         two_score$field = new int();
      }
      
      public function get hasTwoScore() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set twoScore(param1:int) : void
      {
         hasField$0 |= 512;
         two_score$field = param1;
      }
      
      public function get twoScore() : int
      {
         return two_score$field;
      }
      
      public function removeOne_FlagCount() : void
      {
         hasField$0 &= 4294966271;
         one_FlagCount$field = new int();
      }
      
      public function get hasOne_FlagCount() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set one_FlagCount(param1:int) : void
      {
         hasField$0 |= 1024;
         one_FlagCount$field = param1;
      }
      
      public function get one_FlagCount() : int
      {
         return one_FlagCount$field;
      }
      
      public function removeTwo_FlagCount() : void
      {
         hasField$0 &= 4294965247;
         two_FlagCount$field = new int();
      }
      
      public function get hasTwo_FlagCount() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set two_FlagCount(param1:int) : void
      {
         hasField$0 |= 2048;
         two_FlagCount$field = param1;
      }
      
      public function get two_FlagCount() : int
      {
         return two_FlagCount$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTeamId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,team_id$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasOrder)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,order$field);
         }
         if(hasGeste)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,geste$field);
         }
         if(hasHitCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,hit_count$field);
         }
         if(hasLeftTime)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,left_time$field);
         }
         if(hasOneCount)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,one_count$field);
         }
         if(hasTwoCount)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,two_count$field);
         }
         if(hasOneScore)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,one_score$field);
         }
         if(hasTwoScore)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,two_score$field);
         }
         if(hasOne_FlagCount)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,one_FlagCount$field);
         }
         if(hasTwo_FlagCount)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,two_FlagCount$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc11_:* = 0;
         var _loc7_:uint = 0;
         var _loc12_:uint = 0;
         var _loc9_:uint = 0;
         var _loc15_:uint = 0;
         var _loc8_:uint = 0;
         var _loc10_:uint = 0;
         var _loc4_:uint = 0;
         var _loc13_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc14_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc11_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: WarFightInfoMsg.teamId cannot be set twice.");
                  }
                  _loc7_++;
                  teamId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: WarFightInfoMsg.score cannot be set twice.");
                  }
                  _loc12_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: WarFightInfoMsg.order cannot be set twice.");
                  }
                  _loc9_++;
                  order = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: WarFightInfoMsg.geste cannot be set twice.");
                  }
                  _loc15_++;
                  geste = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: WarFightInfoMsg.hitCount cannot be set twice.");
                  }
                  _loc8_++;
                  hitCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: WarFightInfoMsg.leftTime cannot be set twice.");
                  }
                  _loc10_++;
                  leftTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: WarFightInfoMsg.oneCount cannot be set twice.");
                  }
                  _loc4_++;
                  oneCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: WarFightInfoMsg.twoCount cannot be set twice.");
                  }
                  _loc13_++;
                  twoCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: WarFightInfoMsg.oneScore cannot be set twice.");
                  }
                  _loc5_++;
                  oneScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: WarFightInfoMsg.twoScore cannot be set twice.");
                  }
                  _loc6_++;
                  twoScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: WarFightInfoMsg.one_FlagCount cannot be set twice.");
                  }
                  _loc14_++;
                  one_FlagCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: WarFightInfoMsg.two_FlagCount cannot be set twice.");
                  }
                  _loc3_++;
                  two_FlagCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc11_ & 7);
            }
         }
      }
   }
}

