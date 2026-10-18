package com.road.yishi.proto.chat
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SelfChessPlayerMsg extends Message implements IExternalizable
   {
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var serverName$field:String;
      
      private var name$field:String;
      
      private var hp$field:int;
      
      private var gold$field:int;
      
      private var grade$field:int;
      
      private var exp$field:int;
      
      private var winCount$field:int;
      
      private var lock$field:int;
      
      [ArrayElementType("int")]
      public var battleAry:Array = [];
      
      [ArrayElementType("int")]
      public var alternateAry:Array = [];
      
      [ArrayElementType("int")]
      public var cardPool:Array = [];
      
      private var rank$field:int;
      
      public function SelfChessPlayerMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         userId$field = param1;
      }
      
      public function get userId() : int
      {
         return userId$field;
      }
      
      public function removeServerName() : void
      {
         serverName$field = null;
      }
      
      public function get hasServerName() : Boolean
      {
         return serverName$field != null;
      }
      
      public function set serverName(param1:String) : void
      {
         serverName$field = param1;
      }
      
      public function get serverName() : String
      {
         return serverName$field;
      }
      
      public function removeName() : void
      {
         name$field = null;
      }
      
      public function get hasName() : Boolean
      {
         return name$field != null;
      }
      
      public function set name(param1:String) : void
      {
         name$field = param1;
      }
      
      public function get name() : String
      {
         return name$field;
      }
      
      public function removeHp() : void
      {
         hasField$0 &= 4294967293;
         hp$field = new int();
      }
      
      public function get hasHp() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set hp(param1:int) : void
      {
         hasField$0 |= 2;
         hp$field = param1;
      }
      
      public function get hp() : int
      {
         return hp$field;
      }
      
      public function removeGold() : void
      {
         hasField$0 &= 4294967291;
         gold$field = new int();
      }
      
      public function get hasGold() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set gold(param1:int) : void
      {
         hasField$0 |= 4;
         gold$field = param1;
      }
      
      public function get gold() : int
      {
         return gold$field;
      }
      
      public function removeGrade() : void
      {
         hasField$0 &= 4294967287;
         grade$field = new int();
      }
      
      public function get hasGrade() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set grade(param1:int) : void
      {
         hasField$0 |= 8;
         grade$field = param1;
      }
      
      public function get grade() : int
      {
         return grade$field;
      }
      
      public function removeExp() : void
      {
         hasField$0 &= 4294967279;
         exp$field = new int();
      }
      
      public function get hasExp() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set exp(param1:int) : void
      {
         hasField$0 |= 16;
         exp$field = param1;
      }
      
      public function get exp() : int
      {
         return exp$field;
      }
      
      public function removeWinCount() : void
      {
         hasField$0 &= 4294967263;
         winCount$field = new int();
      }
      
      public function get hasWinCount() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set winCount(param1:int) : void
      {
         hasField$0 |= 32;
         winCount$field = param1;
      }
      
      public function get winCount() : int
      {
         return winCount$field;
      }
      
      public function removeLock() : void
      {
         hasField$0 &= 4294967231;
         lock$field = new int();
      }
      
      public function get hasLock() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set lock(param1:int) : void
      {
         hasField$0 |= 64;
         lock$field = param1;
      }
      
      public function get lock() : int
      {
         return lock$field;
      }
      
      public function removeRank() : void
      {
         hasField$0 &= 4294967167;
         rank$field = new int();
      }
      
      public function get hasRank() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set rank(param1:int) : void
      {
         hasField$0 |= 128;
         rank$field = param1;
      }
      
      public function get rank() : int
      {
         return rank$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc4_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,serverName$field);
         }
         if(hasName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,name$field);
         }
         if(hasHp)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,hp$field);
         }
         if(hasGold)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,gold$field);
         }
         if(hasGrade)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,grade$field);
         }
         if(hasExp)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,exp$field);
         }
         if(hasWinCount)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,winCount$field);
         }
         if(hasLock)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,lock$field);
         }
         _loc4_ = 0;
         while(_loc4_ < battleAry.length)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,battleAry[_loc4_]);
            _loc4_++;
         }
         _loc2_ = 0;
         while(_loc2_ < alternateAry.length)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,alternateAry[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < cardPool.length)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,cardPool[_loc3_]);
            _loc3_++;
         }
         if(hasRank)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,rank$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:* = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc11_:uint = 0;
         var _loc10_:uint = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc6_:uint = 0;
         var _loc12_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc13_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SelfChessPlayerMsg.userId cannot be set twice.");
                  }
                  _loc5_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SelfChessPlayerMsg.serverName cannot be set twice.");
                  }
                  _loc7_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SelfChessPlayerMsg.name cannot be set twice.");
                  }
                  _loc8_++;
                  name = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: SelfChessPlayerMsg.hp cannot be set twice.");
                  }
                  _loc11_++;
                  hp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: SelfChessPlayerMsg.gold cannot be set twice.");
                  }
                  _loc10_++;
                  gold = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SelfChessPlayerMsg.grade cannot be set twice.");
                  }
                  _loc4_++;
                  grade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: SelfChessPlayerMsg.exp cannot be set twice.");
                  }
                  _loc9_++;
                  exp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SelfChessPlayerMsg.winCount cannot be set twice.");
                  }
                  _loc6_++;
                  winCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: SelfChessPlayerMsg.lock cannot be set twice.");
                  }
                  _loc12_++;
                  lock = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if((_loc13_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,battleAry);
                  }
                  else
                  {
                     battleAry.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 10:
                  if((_loc13_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,alternateAry);
                  }
                  else
                  {
                     alternateAry.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 11:
                  if((_loc13_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,cardPool);
                  }
                  else
                  {
                     cardPool.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 12:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SelfChessPlayerMsg.rank cannot be set twice.");
                  }
                  _loc3_++;
                  rank = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

