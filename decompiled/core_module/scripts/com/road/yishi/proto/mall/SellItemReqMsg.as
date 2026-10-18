package com.road.yishi.proto.mall
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SellItemReqMsg extends Message implements IExternalizable
   {
      
      private var item_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var item_pos$field:int;
      
      private var count$field:int;
      
      private var point$field:int;
      
      private var fix_point$field:int;
      
      private var hour$field:int;
      
      private var sellType$field:int;
      
      private var fromBagType$field:int;
      
      public function SellItemReqMsg()
      {
         super();
      }
      
      public function removeItemId() : void
      {
         hasField$0 &= 4294967294;
         item_id$field = new int();
      }
      
      public function get hasItemId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set itemId(param1:int) : void
      {
         hasField$0 |= 1;
         item_id$field = param1;
      }
      
      public function get itemId() : int
      {
         return item_id$field;
      }
      
      public function removeItemPos() : void
      {
         hasField$0 &= 4294967293;
         item_pos$field = new int();
      }
      
      public function get hasItemPos() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set itemPos(param1:int) : void
      {
         hasField$0 |= 2;
         item_pos$field = param1;
      }
      
      public function get itemPos() : int
      {
         return item_pos$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967291;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 4;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removePoint() : void
      {
         hasField$0 &= 4294967287;
         point$field = new int();
      }
      
      public function get hasPoint() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set point(param1:int) : void
      {
         hasField$0 |= 8;
         point$field = param1;
      }
      
      public function get point() : int
      {
         return point$field;
      }
      
      public function removeFixPoint() : void
      {
         hasField$0 &= 4294967279;
         fix_point$field = new int();
      }
      
      public function get hasFixPoint() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set fixPoint(param1:int) : void
      {
         hasField$0 |= 16;
         fix_point$field = param1;
      }
      
      public function get fixPoint() : int
      {
         return fix_point$field;
      }
      
      public function removeHour() : void
      {
         hasField$0 &= 4294967263;
         hour$field = new int();
      }
      
      public function get hasHour() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set hour(param1:int) : void
      {
         hasField$0 |= 32;
         hour$field = param1;
      }
      
      public function get hour() : int
      {
         return hour$field;
      }
      
      public function removeSellType() : void
      {
         hasField$0 &= 4294967231;
         sellType$field = new int();
      }
      
      public function get hasSellType() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set sellType(param1:int) : void
      {
         hasField$0 |= 64;
         sellType$field = param1;
      }
      
      public function get sellType() : int
      {
         return sellType$field;
      }
      
      public function removeFromBagType() : void
      {
         hasField$0 &= 4294967167;
         fromBagType$field = new int();
      }
      
      public function get hasFromBagType() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set fromBagType(param1:int) : void
      {
         hasField$0 |= 128;
         fromBagType$field = param1;
      }
      
      public function get fromBagType() : int
      {
         return fromBagType$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasItemId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,item_id$field);
         }
         if(hasItemPos)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,item_pos$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasPoint)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,point$field);
         }
         if(hasFixPoint)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,fix_point$field);
         }
         if(hasHour)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,hour$field);
         }
         if(hasSellType)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,sellType$field);
         }
         if(hasFromBagType)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,fromBagType$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         var _loc11_:uint = 0;
         var _loc8_:uint = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SellItemReqMsg.itemId cannot be set twice.");
                  }
                  _loc4_++;
                  itemId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SellItemReqMsg.itemPos cannot be set twice.");
                  }
                  _loc3_++;
                  itemPos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SellItemReqMsg.count cannot be set twice.");
                  }
                  _loc5_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: SellItemReqMsg.point cannot be set twice.");
                  }
                  _loc9_++;
                  point = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: SellItemReqMsg.fixPoint cannot be set twice.");
                  }
                  _loc11_++;
                  fixPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SellItemReqMsg.hour cannot be set twice.");
                  }
                  _loc8_++;
                  hour = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SellItemReqMsg.sellType cannot be set twice.");
                  }
                  _loc7_++;
                  sellType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SellItemReqMsg.fromBagType cannot be set twice.");
                  }
                  _loc6_++;
                  fromBagType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

