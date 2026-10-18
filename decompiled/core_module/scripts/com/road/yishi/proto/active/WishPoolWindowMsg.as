package com.road.yishi.proto.active
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class WishPoolWindowMsg extends Message implements IExternalizable
   {
      
      private var type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var refreshPrice$field:int;
      
      private var wishOnePrice$field:int;
      
      private var sysCountDown$field:int;
      
      [ArrayElementType("int")]
      public var keys:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.active.WishPoolItemInfo")]
      public var allWishes:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.active.WishPoolShopGoodInfo")]
      public var goods:Array = [];
      
      public function WishPoolWindowMsg()
      {
         super();
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967294;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 1;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeRefreshPrice() : void
      {
         hasField$0 &= 4294967293;
         refreshPrice$field = new int();
      }
      
      public function get hasRefreshPrice() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set refreshPrice(param1:int) : void
      {
         hasField$0 |= 2;
         refreshPrice$field = param1;
      }
      
      public function get refreshPrice() : int
      {
         return refreshPrice$field;
      }
      
      public function removeWishOnePrice() : void
      {
         hasField$0 &= 4294967291;
         wishOnePrice$field = new int();
      }
      
      public function get hasWishOnePrice() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set wishOnePrice(param1:int) : void
      {
         hasField$0 |= 4;
         wishOnePrice$field = param1;
      }
      
      public function get wishOnePrice() : int
      {
         return wishOnePrice$field;
      }
      
      public function removeSysCountDown() : void
      {
         hasField$0 &= 4294967287;
         sysCountDown$field = new int();
      }
      
      public function get hasSysCountDown() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set sysCountDown(param1:int) : void
      {
         hasField$0 |= 8;
         sysCountDown$field = param1;
      }
      
      public function get sysCountDown() : int
      {
         return sysCountDown$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc4_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasRefreshPrice)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,refreshPrice$field);
         }
         if(hasWishOnePrice)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,wishOnePrice$field);
         }
         if(hasSysCountDown)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,sysCountDown$field);
         }
         _loc4_ = 0;
         while(_loc4_ < keys.length)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,keys[_loc4_]);
            _loc4_++;
         }
         _loc2_ = 0;
         while(_loc2_ < allWishes.length)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_MESSAGE(param1,allWishes[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < goods.length)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_MESSAGE(param1,goods[_loc3_]);
            _loc3_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc3_:WishPoolItemInfo = null;
         var _loc9_:WishPoolShopGoodInfo = null;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: WishPoolWindowMsg.type cannot be set twice.");
                  }
                  _loc7_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: WishPoolWindowMsg.refreshPrice cannot be set twice.");
                  }
                  _loc5_++;
                  refreshPrice = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: WishPoolWindowMsg.wishOnePrice cannot be set twice.");
                  }
                  _loc4_++;
                  wishOnePrice = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: WishPoolWindowMsg.sysCountDown cannot be set twice.");
                  }
                  _loc6_++;
                  sysCountDown = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if((_loc8_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,keys);
                  }
                  else
                  {
                     keys.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 5:
                  _loc3_ = new WishPoolItemInfo();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  allWishes.push(_loc3_);
                  break;
               case 6:
                  _loc9_ = new WishPoolShopGoodInfo();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc9_);
                  goods.push(_loc9_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

