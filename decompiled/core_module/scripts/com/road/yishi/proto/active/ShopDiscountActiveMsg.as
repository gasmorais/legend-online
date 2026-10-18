package com.road.yishi.proto.active
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ShopDiscountActiveMsg extends Message implements IExternalizable
   {
      
      private var id$field:String;
      
      private var begin$field:String;
      
      private var end$field:String;
      
      private var isopen$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.active.ShopItemInfoMsg")]
      public var allItems:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.active.UserBuyInfoMsg")]
      public var buyInfos:Array = [];
      
      public function ShopDiscountActiveMsg()
      {
         super();
      }
      
      public function removeId() : void
      {
         id$field = null;
      }
      
      public function get hasId() : Boolean
      {
         return id$field != null;
      }
      
      public function set id(param1:String) : void
      {
         id$field = param1;
      }
      
      public function get id() : String
      {
         return id$field;
      }
      
      public function removeBegin() : void
      {
         begin$field = null;
      }
      
      public function get hasBegin() : Boolean
      {
         return begin$field != null;
      }
      
      public function set begin(param1:String) : void
      {
         begin$field = param1;
      }
      
      public function get begin() : String
      {
         return begin$field;
      }
      
      public function removeEnd() : void
      {
         end$field = null;
      }
      
      public function get hasEnd() : Boolean
      {
         return end$field != null;
      }
      
      public function set end(param1:String) : void
      {
         end$field = param1;
      }
      
      public function get end() : String
      {
         return end$field;
      }
      
      public function removeIsopen() : void
      {
         hasField$0 &= 4294967294;
         isopen$field = new Boolean();
      }
      
      public function get hasIsopen() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set isopen(param1:Boolean) : void
      {
         hasField$0 |= 1;
         isopen$field = param1;
      }
      
      public function get isopen() : Boolean
      {
         return isopen$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(hasId)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,id$field);
         }
         if(hasBegin)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,begin$field);
         }
         if(hasEnd)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,end$field);
         }
         if(hasIsopen)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,isopen$field);
         }
         _loc3_ = 0;
         while(_loc3_ < allItems.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,allItems[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < buyInfos.length)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_MESSAGE(param1,buyInfos[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc8_:ShopItemInfoMsg = null;
         var _loc4_:UserBuyInfoMsg = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ShopDiscountActiveMsg.id cannot be set twice.");
                  }
                  _loc6_++;
                  id = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ShopDiscountActiveMsg.begin cannot be set twice.");
                  }
                  _loc7_++;
                  begin = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ShopDiscountActiveMsg.end cannot be set twice.");
                  }
                  _loc3_++;
                  end = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ShopDiscountActiveMsg.isopen cannot be set twice.");
                  }
                  _loc5_++;
                  isopen = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 4:
                  _loc8_ = new ShopItemInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc8_);
                  allItems.push(_loc8_);
                  break;
               case 5:
                  _loc4_ = new UserBuyInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  buyInfos.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

