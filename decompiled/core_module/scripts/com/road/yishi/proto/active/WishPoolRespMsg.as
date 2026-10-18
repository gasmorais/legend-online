package com.road.yishi.proto.active
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class WishPoolRespMsg extends Message implements IExternalizable
   {
      
      private var optype$field:int;
      
      private var hasField$0:uint = 0;
      
      private var countDown$field:int;
      
      private var wishResult$field:Boolean;
      
      [ArrayElementType("int")]
      public var keys:Array = [];
      
      private var wishRewardTip$field:String;
      
      private var leftScore$field:int;
      
      private var goodKey$field:int;
      
      private var curBuyCount$field:int;
      
      public function WishPoolRespMsg()
      {
         super();
      }
      
      public function removeOptype() : void
      {
         hasField$0 &= 4294967294;
         optype$field = new int();
      }
      
      public function get hasOptype() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set optype(param1:int) : void
      {
         hasField$0 |= 1;
         optype$field = param1;
      }
      
      public function get optype() : int
      {
         return optype$field;
      }
      
      public function removeCountDown() : void
      {
         hasField$0 &= 4294967293;
         countDown$field = new int();
      }
      
      public function get hasCountDown() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set countDown(param1:int) : void
      {
         hasField$0 |= 2;
         countDown$field = param1;
      }
      
      public function get countDown() : int
      {
         return countDown$field;
      }
      
      public function removeWishResult() : void
      {
         hasField$0 &= 4294967291;
         wishResult$field = new Boolean();
      }
      
      public function get hasWishResult() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set wishResult(param1:Boolean) : void
      {
         hasField$0 |= 4;
         wishResult$field = param1;
      }
      
      public function get wishResult() : Boolean
      {
         return wishResult$field;
      }
      
      public function removeWishRewardTip() : void
      {
         wishRewardTip$field = null;
      }
      
      public function get hasWishRewardTip() : Boolean
      {
         return wishRewardTip$field != null;
      }
      
      public function set wishRewardTip(param1:String) : void
      {
         wishRewardTip$field = param1;
      }
      
      public function get wishRewardTip() : String
      {
         return wishRewardTip$field;
      }
      
      public function removeLeftScore() : void
      {
         hasField$0 &= 4294967287;
         leftScore$field = new int();
      }
      
      public function get hasLeftScore() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set leftScore(param1:int) : void
      {
         hasField$0 |= 8;
         leftScore$field = param1;
      }
      
      public function get leftScore() : int
      {
         return leftScore$field;
      }
      
      public function removeGoodKey() : void
      {
         hasField$0 &= 4294967279;
         goodKey$field = new int();
      }
      
      public function get hasGoodKey() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set goodKey(param1:int) : void
      {
         hasField$0 |= 16;
         goodKey$field = param1;
      }
      
      public function get goodKey() : int
      {
         return goodKey$field;
      }
      
      public function removeCurBuyCount() : void
      {
         hasField$0 &= 4294967263;
         curBuyCount$field = new int();
      }
      
      public function get hasCurBuyCount() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set curBuyCount(param1:int) : void
      {
         hasField$0 |= 32;
         curBuyCount$field = param1;
      }
      
      public function get curBuyCount() : int
      {
         return curBuyCount$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOptype)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,optype$field);
         }
         if(hasCountDown)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,countDown$field);
         }
         if(hasWishResult)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,wishResult$field);
         }
         _loc2_ = 0;
         while(_loc2_ < keys.length)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,keys[_loc2_]);
            _loc2_++;
         }
         if(hasWishRewardTip)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,wishRewardTip$field);
         }
         if(hasLeftScore)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,leftScore$field);
         }
         if(hasGoodKey)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,goodKey$field);
         }
         if(hasCurBuyCount)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,curBuyCount$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: WishPoolRespMsg.optype cannot be set twice.");
                  }
                  _loc4_++;
                  optype = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: WishPoolRespMsg.countDown cannot be set twice.");
                  }
                  _loc5_++;
                  countDown = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: WishPoolRespMsg.wishResult cannot be set twice.");
                  }
                  _loc7_++;
                  wishResult = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 3:
                  if((_loc8_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,keys);
                  }
                  else
                  {
                     keys.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: WishPoolRespMsg.wishRewardTip cannot be set twice.");
                  }
                  _loc3_++;
                  wishRewardTip = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: WishPoolRespMsg.leftScore cannot be set twice.");
                  }
                  _loc6_++;
                  leftScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: WishPoolRespMsg.goodKey cannot be set twice.");
                  }
                  _loc9_++;
                  goodKey = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: WishPoolRespMsg.curBuyCount cannot be set twice.");
                  }
                  _loc10_++;
                  curBuyCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

