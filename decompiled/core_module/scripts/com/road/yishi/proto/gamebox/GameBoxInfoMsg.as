package com.road.yishi.proto.gamebox
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GameBoxInfoMsg extends Message implements IExternalizable
   {
      
      private var tempId1$field:int;
      
      private var hasField$0:uint = 0;
      
      private var tempId2$field:int;
      
      private var tempId3$field:int;
      
      private var tempId4$field:int;
      
      private var starGameId$field:int;
      
      private var GameBoxMedal$field:int;
      
      private var op$field:int;
      
      private var ExchangeIndex$field:int;
      
      private var ExchangeCount$field:int;
      
      public function GameBoxInfoMsg()
      {
         super();
      }
      
      public function removeTempId1() : void
      {
         hasField$0 &= 4294967294;
         tempId1$field = new int();
      }
      
      public function get hasTempId1() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set tempId1(param1:int) : void
      {
         hasField$0 |= 1;
         tempId1$field = param1;
      }
      
      public function get tempId1() : int
      {
         return tempId1$field;
      }
      
      public function removeTempId2() : void
      {
         hasField$0 &= 4294967293;
         tempId2$field = new int();
      }
      
      public function get hasTempId2() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set tempId2(param1:int) : void
      {
         hasField$0 |= 2;
         tempId2$field = param1;
      }
      
      public function get tempId2() : int
      {
         return tempId2$field;
      }
      
      public function removeTempId3() : void
      {
         hasField$0 &= 4294967291;
         tempId3$field = new int();
      }
      
      public function get hasTempId3() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set tempId3(param1:int) : void
      {
         hasField$0 |= 4;
         tempId3$field = param1;
      }
      
      public function get tempId3() : int
      {
         return tempId3$field;
      }
      
      public function removeTempId4() : void
      {
         hasField$0 &= 4294967287;
         tempId4$field = new int();
      }
      
      public function get hasTempId4() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set tempId4(param1:int) : void
      {
         hasField$0 |= 8;
         tempId4$field = param1;
      }
      
      public function get tempId4() : int
      {
         return tempId4$field;
      }
      
      public function removeStarGameId() : void
      {
         hasField$0 &= 4294967279;
         starGameId$field = new int();
      }
      
      public function get hasStarGameId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set starGameId(param1:int) : void
      {
         hasField$0 |= 16;
         starGameId$field = param1;
      }
      
      public function get starGameId() : int
      {
         return starGameId$field;
      }
      
      public function removeGameBoxMedal() : void
      {
         hasField$0 &= 4294967263;
         GameBoxMedal$field = new int();
      }
      
      public function get hasGameBoxMedal() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set gameBoxMedal(param1:int) : void
      {
         hasField$0 |= 32;
         GameBoxMedal$field = param1;
      }
      
      public function get gameBoxMedal() : int
      {
         return GameBoxMedal$field;
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967231;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 64;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      public function removeExchangeIndex() : void
      {
         hasField$0 &= 4294967167;
         ExchangeIndex$field = new int();
      }
      
      public function get hasExchangeIndex() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set exchangeIndex(param1:int) : void
      {
         hasField$0 |= 128;
         ExchangeIndex$field = param1;
      }
      
      public function get exchangeIndex() : int
      {
         return ExchangeIndex$field;
      }
      
      public function removeExchangeCount() : void
      {
         hasField$0 &= 4294967039;
         ExchangeCount$field = new int();
      }
      
      public function get hasExchangeCount() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set exchangeCount(param1:int) : void
      {
         hasField$0 |= 256;
         ExchangeCount$field = param1;
      }
      
      public function get exchangeCount() : int
      {
         return ExchangeCount$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTempId1)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,tempId1$field);
         }
         if(hasTempId2)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,tempId2$field);
         }
         if(hasTempId3)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,tempId3$field);
         }
         if(hasTempId4)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,tempId4$field);
         }
         if(hasStarGameId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,starGameId$field);
         }
         if(hasGameBoxMedal)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,GameBoxMedal$field);
         }
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasExchangeIndex)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,ExchangeIndex$field);
         }
         if(hasExchangeCount)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,ExchangeCount$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc11_:uint = 0;
         var _loc7_:uint = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc12_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: GameBoxInfoMsg.tempId1 cannot be set twice.");
                  }
                  _loc8_++;
                  tempId1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GameBoxInfoMsg.tempId2 cannot be set twice.");
                  }
                  _loc4_++;
                  tempId2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: GameBoxInfoMsg.tempId3 cannot be set twice.");
                  }
                  _loc11_++;
                  tempId3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: GameBoxInfoMsg.tempId4 cannot be set twice.");
                  }
                  _loc7_++;
                  tempId4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: GameBoxInfoMsg.starGameId cannot be set twice.");
                  }
                  _loc9_++;
                  starGameId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: GameBoxInfoMsg.gameBoxMedal cannot be set twice.");
                  }
                  _loc5_++;
                  gameBoxMedal = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: GameBoxInfoMsg.op cannot be set twice.");
                  }
                  _loc12_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GameBoxInfoMsg.exchangeIndex cannot be set twice.");
                  }
                  _loc3_++;
                  exchangeIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: GameBoxInfoMsg.exchangeCount cannot be set twice.");
                  }
                  _loc6_++;
                  exchangeCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

