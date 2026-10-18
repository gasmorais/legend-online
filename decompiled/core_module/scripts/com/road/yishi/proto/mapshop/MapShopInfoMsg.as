package com.road.yishi.proto.mapshop
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MapShopInfoMsg extends Message implements IExternalizable
   {
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var fresh_time$field:String;
      
      private var bless$field:int;
      
      private var fresh_count$field:int;
      
      [ArrayElementType("com.road.yishi.proto.mapshop.MapshopIteminfoMsg")]
      public var items:Array = [];
      
      private var score$field:int;
      
      public function MapShopInfoMsg()
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
      
      public function removeFreshTime() : void
      {
         fresh_time$field = null;
      }
      
      public function get hasFreshTime() : Boolean
      {
         return fresh_time$field != null;
      }
      
      public function set freshTime(param1:String) : void
      {
         fresh_time$field = param1;
      }
      
      public function get freshTime() : String
      {
         return fresh_time$field;
      }
      
      public function removeBless() : void
      {
         hasField$0 &= 4294967293;
         bless$field = new int();
      }
      
      public function get hasBless() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set bless(param1:int) : void
      {
         hasField$0 |= 2;
         bless$field = param1;
      }
      
      public function get bless() : int
      {
         return bless$field;
      }
      
      public function removeFreshCount() : void
      {
         hasField$0 &= 4294967291;
         fresh_count$field = new int();
      }
      
      public function get hasFreshCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set freshCount(param1:int) : void
      {
         hasField$0 |= 4;
         fresh_count$field = param1;
      }
      
      public function get freshCount() : int
      {
         return fresh_count$field;
      }
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967287;
         score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 8;
         score$field = param1;
      }
      
      public function get score() : int
      {
         return score$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasFreshTime)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,fresh_time$field);
         }
         if(hasBless)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,bless$field);
         }
         if(hasFreshCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,fresh_count$field);
         }
         _loc2_ = 0;
         while(_loc2_ < items.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,items[_loc2_]);
            _loc2_++;
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc9_:MapshopIteminfoMsg = null;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MapShopInfoMsg.userId cannot be set twice.");
                  }
                  _loc5_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MapShopInfoMsg.freshTime cannot be set twice.");
                  }
                  _loc3_++;
                  freshTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MapShopInfoMsg.bless cannot be set twice.");
                  }
                  _loc4_++;
                  bless = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: MapShopInfoMsg.freshCount cannot be set twice.");
                  }
                  _loc8_++;
                  freshCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  _loc9_ = new MapshopIteminfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc9_);
                  items.push(_loc9_);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: MapShopInfoMsg.score cannot be set twice.");
                  }
                  _loc7_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

