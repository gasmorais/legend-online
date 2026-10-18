package com.road.yishi.proto.dragontalker
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class DragonFashionMsg extends Message implements IExternalizable
   {
      
      private var dragonWingAvata$field:int;
      
      private var hasField$0:uint = 0;
      
      private var dragonHatAvata$field:int;
      
      private var dragonArmAvata$field:int;
      
      private var dragonClothAvata$field:int;
      
      public function DragonFashionMsg()
      {
         super();
      }
      
      public function removeDragonWingAvata() : void
      {
         hasField$0 &= 4294967294;
         dragonWingAvata$field = new int();
      }
      
      public function get hasDragonWingAvata() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set dragonWingAvata(param1:int) : void
      {
         hasField$0 |= 1;
         dragonWingAvata$field = param1;
      }
      
      public function get dragonWingAvata() : int
      {
         return dragonWingAvata$field;
      }
      
      public function removeDragonHatAvata() : void
      {
         hasField$0 &= 4294967293;
         dragonHatAvata$field = new int();
      }
      
      public function get hasDragonHatAvata() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set dragonHatAvata(param1:int) : void
      {
         hasField$0 |= 2;
         dragonHatAvata$field = param1;
      }
      
      public function get dragonHatAvata() : int
      {
         return dragonHatAvata$field;
      }
      
      public function removeDragonArmAvata() : void
      {
         hasField$0 &= 4294967291;
         dragonArmAvata$field = new int();
      }
      
      public function get hasDragonArmAvata() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set dragonArmAvata(param1:int) : void
      {
         hasField$0 |= 4;
         dragonArmAvata$field = param1;
      }
      
      public function get dragonArmAvata() : int
      {
         return dragonArmAvata$field;
      }
      
      public function removeDragonClothAvata() : void
      {
         hasField$0 &= 4294967287;
         dragonClothAvata$field = new int();
      }
      
      public function get hasDragonClothAvata() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set dragonClothAvata(param1:int) : void
      {
         hasField$0 |= 8;
         dragonClothAvata$field = param1;
      }
      
      public function get dragonClothAvata() : int
      {
         return dragonClothAvata$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasDragonWingAvata)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,dragonWingAvata$field);
         }
         if(hasDragonHatAvata)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,dragonHatAvata$field);
         }
         if(hasDragonArmAvata)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,dragonArmAvata$field);
         }
         if(hasDragonClothAvata)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,dragonClothAvata$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: DragonFashionMsg.dragonWingAvata cannot be set twice.");
                  }
                  _loc7_++;
                  dragonWingAvata = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: DragonFashionMsg.dragonHatAvata cannot be set twice.");
                  }
                  _loc5_++;
                  dragonHatAvata = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: DragonFashionMsg.dragonArmAvata cannot be set twice.");
                  }
                  _loc4_++;
                  dragonArmAvata = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: DragonFashionMsg.dragonClothAvata cannot be set twice.");
                  }
                  _loc3_++;
                  dragonClothAvata = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

