package com.road.yishi.proto.army
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class HeroRuneOpMsg extends Message implements IExternalizable
   {
      
      private var user_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var runeId$field:int;
      
      private var runeKey$field:String;
      
      private var learn_runePos$field:int;
      
      private var learn_runeCount$field:int;
      
      private var opType$field:int;
      
      private var opResult$field:Boolean;
      
      private var runeInfo$field:HeroRuneMsg;
      
      private var count$field:int;
      
      private var runeType$field:int;
      
      public function HeroRuneOpMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
      }
      
      public function removeRuneId() : void
      {
         hasField$0 &= 4294967293;
         runeId$field = new int();
      }
      
      public function get hasRuneId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set runeId(param1:int) : void
      {
         hasField$0 |= 2;
         runeId$field = param1;
      }
      
      public function get runeId() : int
      {
         return runeId$field;
      }
      
      public function removeRuneKey() : void
      {
         runeKey$field = null;
      }
      
      public function get hasRuneKey() : Boolean
      {
         return runeKey$field != null;
      }
      
      public function set runeKey(param1:String) : void
      {
         runeKey$field = param1;
      }
      
      public function get runeKey() : String
      {
         return runeKey$field;
      }
      
      public function removeLearnRunePos() : void
      {
         hasField$0 &= 4294967291;
         learn_runePos$field = new int();
      }
      
      public function get hasLearnRunePos() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set learnRunePos(param1:int) : void
      {
         hasField$0 |= 4;
         learn_runePos$field = param1;
      }
      
      public function get learnRunePos() : int
      {
         return learn_runePos$field;
      }
      
      public function removeLearnRuneCount() : void
      {
         hasField$0 &= 4294967287;
         learn_runeCount$field = new int();
      }
      
      public function get hasLearnRuneCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set learnRuneCount(param1:int) : void
      {
         hasField$0 |= 8;
         learn_runeCount$field = param1;
      }
      
      public function get learnRuneCount() : int
      {
         return learn_runeCount$field;
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294967279;
         opType$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 16;
         opType$field = param1;
      }
      
      public function get opType() : int
      {
         return opType$field;
      }
      
      public function removeOpResult() : void
      {
         hasField$0 &= 4294967263;
         opResult$field = new Boolean();
      }
      
      public function get hasOpResult() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set opResult(param1:Boolean) : void
      {
         hasField$0 |= 32;
         opResult$field = param1;
      }
      
      public function get opResult() : Boolean
      {
         return opResult$field;
      }
      
      public function removeRuneInfo() : void
      {
         runeInfo$field = null;
      }
      
      public function get hasRuneInfo() : Boolean
      {
         return runeInfo$field != null;
      }
      
      public function set runeInfo(param1:HeroRuneMsg) : void
      {
         runeInfo$field = param1;
      }
      
      public function get runeInfo() : HeroRuneMsg
      {
         return runeInfo$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967231;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 64;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removeRuneType() : void
      {
         hasField$0 &= 4294967167;
         runeType$field = new int();
      }
      
      public function get hasRuneType() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set runeType(param1:int) : void
      {
         hasField$0 |= 128;
         runeType$field = param1;
      }
      
      public function get runeType() : int
      {
         return runeType$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasRuneId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,runeId$field);
         }
         if(hasRuneKey)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,runeKey$field);
         }
         if(hasLearnRunePos)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,learn_runePos$field);
         }
         if(hasLearnRuneCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,learn_runeCount$field);
         }
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,opType$field);
         }
         if(hasOpResult)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_BOOL(param1,opResult$field);
         }
         if(hasRuneInfo)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_MESSAGE(param1,runeInfo$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasRuneType)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,runeType$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc10_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc11_:uint = 0;
         var _loc9_:uint = 0;
         var _loc4_:uint = 0;
         var _loc13_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: HeroRuneOpMsg.userId cannot be set twice.");
                  }
                  _loc10_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: HeroRuneOpMsg.runeId cannot be set twice.");
                  }
                  _loc6_++;
                  runeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: HeroRuneOpMsg.runeKey cannot be set twice.");
                  }
                  _loc3_++;
                  runeKey = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: HeroRuneOpMsg.learnRunePos cannot be set twice.");
                  }
                  _loc8_++;
                  learnRunePos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: HeroRuneOpMsg.learnRuneCount cannot be set twice.");
                  }
                  _loc11_++;
                  learnRuneCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: HeroRuneOpMsg.opType cannot be set twice.");
                  }
                  _loc9_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: HeroRuneOpMsg.opResult cannot be set twice.");
                  }
                  _loc4_++;
                  opResult = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 7:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: HeroRuneOpMsg.runeInfo cannot be set twice.");
                  }
                  _loc13_++;
                  runeInfo = new HeroRuneMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,runeInfo);
                  break;
               case 8:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: HeroRuneOpMsg.count cannot be set twice.");
                  }
                  _loc5_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: HeroRuneOpMsg.runeType cannot be set twice.");
                  }
                  _loc7_++;
                  runeType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

