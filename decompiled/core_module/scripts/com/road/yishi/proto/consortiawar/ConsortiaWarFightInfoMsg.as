package com.road.yishi.proto.consortiawar
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaWarFightInfoMsg extends Message implements IExternalizable
   {
      
      private var nickName$field:String;
      
      private var headId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var fightPower$field:int;
      
      private var count1$field:int;
      
      private var score1$field:int;
      
      private var count2$field:int;
      
      private var score2$field:int;
      
      private var count3$field:int;
      
      private var score3$field:int;
      
      private var totalSocre$field:int;
      
      public function ConsortiaWarFightInfoMsg()
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
      
      public function removeHeadId() : void
      {
         hasField$0 &= 4294967294;
         headId$field = new int();
      }
      
      public function get hasHeadId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set headId(param1:int) : void
      {
         hasField$0 |= 1;
         headId$field = param1;
      }
      
      public function get headId() : int
      {
         return headId$field;
      }
      
      public function removeFightPower() : void
      {
         hasField$0 &= 4294967293;
         fightPower$field = new int();
      }
      
      public function get hasFightPower() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set fightPower(param1:int) : void
      {
         hasField$0 |= 2;
         fightPower$field = param1;
      }
      
      public function get fightPower() : int
      {
         return fightPower$field;
      }
      
      public function removeCount1() : void
      {
         hasField$0 &= 4294967291;
         count1$field = new int();
      }
      
      public function get hasCount1() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set count1(param1:int) : void
      {
         hasField$0 |= 4;
         count1$field = param1;
      }
      
      public function get count1() : int
      {
         return count1$field;
      }
      
      public function removeScore1() : void
      {
         hasField$0 &= 4294967287;
         score1$field = new int();
      }
      
      public function get hasScore1() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set score1(param1:int) : void
      {
         hasField$0 |= 8;
         score1$field = param1;
      }
      
      public function get score1() : int
      {
         return score1$field;
      }
      
      public function removeCount2() : void
      {
         hasField$0 &= 4294967279;
         count2$field = new int();
      }
      
      public function get hasCount2() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set count2(param1:int) : void
      {
         hasField$0 |= 16;
         count2$field = param1;
      }
      
      public function get count2() : int
      {
         return count2$field;
      }
      
      public function removeScore2() : void
      {
         hasField$0 &= 4294967263;
         score2$field = new int();
      }
      
      public function get hasScore2() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set score2(param1:int) : void
      {
         hasField$0 |= 32;
         score2$field = param1;
      }
      
      public function get score2() : int
      {
         return score2$field;
      }
      
      public function removeCount3() : void
      {
         hasField$0 &= 4294967231;
         count3$field = new int();
      }
      
      public function get hasCount3() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set count3(param1:int) : void
      {
         hasField$0 |= 64;
         count3$field = param1;
      }
      
      public function get count3() : int
      {
         return count3$field;
      }
      
      public function removeScore3() : void
      {
         hasField$0 &= 4294967167;
         score3$field = new int();
      }
      
      public function get hasScore3() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set score3(param1:int) : void
      {
         hasField$0 |= 128;
         score3$field = param1;
      }
      
      public function get score3() : int
      {
         return score3$field;
      }
      
      public function removeTotalSocre() : void
      {
         hasField$0 &= 4294967039;
         totalSocre$field = new int();
      }
      
      public function get hasTotalSocre() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set totalSocre(param1:int) : void
      {
         hasField$0 |= 256;
         totalSocre$field = param1;
      }
      
      public function get totalSocre() : int
      {
         return totalSocre$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,nickName$field);
         }
         if(hasHeadId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,headId$field);
         }
         if(hasFightPower)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,fightPower$field);
         }
         if(hasCount1)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,count1$field);
         }
         if(hasScore1)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,score1$field);
         }
         if(hasCount2)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,count2$field);
         }
         if(hasScore2)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,score2$field);
         }
         if(hasCount3)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,count3$field);
         }
         if(hasScore3)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,score3$field);
         }
         if(hasTotalSocre)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,totalSocre$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc8_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc10_:uint = 0;
         var _loc13_:uint = 0;
         var _loc9_:uint = 0;
         var _loc11_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarFightInfoMsg.nickName cannot be set twice.");
                  }
                  _loc8_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarFightInfoMsg.headId cannot be set twice.");
                  }
                  _loc6_++;
                  headId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarFightInfoMsg.fightPower cannot be set twice.");
                  }
                  _loc4_++;
                  fightPower = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarFightInfoMsg.count1 cannot be set twice.");
                  }
                  _loc7_++;
                  count1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarFightInfoMsg.score1 cannot be set twice.");
                  }
                  _loc5_++;
                  score1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarFightInfoMsg.count2 cannot be set twice.");
                  }
                  _loc3_++;
                  count2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarFightInfoMsg.score2 cannot be set twice.");
                  }
                  _loc10_++;
                  score2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarFightInfoMsg.count3 cannot be set twice.");
                  }
                  _loc13_++;
                  count3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarFightInfoMsg.score3 cannot be set twice.");
                  }
                  _loc9_++;
                  score3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarFightInfoMsg.totalSocre cannot be set twice.");
                  }
                  _loc11_++;
                  totalSocre = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

