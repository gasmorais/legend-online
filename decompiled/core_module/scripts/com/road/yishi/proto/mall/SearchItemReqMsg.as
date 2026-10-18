package com.road.yishi.proto.mall
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SearchItemReqMsg extends Message implements IExternalizable
   {
      
      private var item_name$field:String;
      
      private var min_level$field:int;
      
      private var hasField$0:uint = 0;
      
      private var max_level$field:int;
      
      private var quality$field:int;
      
      private var job$field:int;
      
      private var type$field:int;
      
      private var son_type$field:int;
      
      private var usable$field:Boolean;
      
      private var page$field:int;
      
      private var order_by$field:int;
      
      private var order_type$field:int;
      
      public function SearchItemReqMsg()
      {
         super();
      }
      
      public function removeItemName() : void
      {
         item_name$field = null;
      }
      
      public function get hasItemName() : Boolean
      {
         return item_name$field != null;
      }
      
      public function set itemName(param1:String) : void
      {
         item_name$field = param1;
      }
      
      public function get itemName() : String
      {
         return item_name$field;
      }
      
      public function removeMinLevel() : void
      {
         hasField$0 &= 4294967294;
         min_level$field = new int();
      }
      
      public function get hasMinLevel() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set minLevel(param1:int) : void
      {
         hasField$0 |= 1;
         min_level$field = param1;
      }
      
      public function get minLevel() : int
      {
         return min_level$field;
      }
      
      public function removeMaxLevel() : void
      {
         hasField$0 &= 4294967293;
         max_level$field = new int();
      }
      
      public function get hasMaxLevel() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set maxLevel(param1:int) : void
      {
         hasField$0 |= 2;
         max_level$field = param1;
      }
      
      public function get maxLevel() : int
      {
         return max_level$field;
      }
      
      public function removeQuality() : void
      {
         hasField$0 &= 4294967291;
         quality$field = new int();
      }
      
      public function get hasQuality() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set quality(param1:int) : void
      {
         hasField$0 |= 4;
         quality$field = param1;
      }
      
      public function get quality() : int
      {
         return quality$field;
      }
      
      public function removeJob() : void
      {
         hasField$0 &= 4294967287;
         job$field = new int();
      }
      
      public function get hasJob() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set job(param1:int) : void
      {
         hasField$0 |= 8;
         job$field = param1;
      }
      
      public function get job() : int
      {
         return job$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967279;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 16;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeSonType() : void
      {
         hasField$0 &= 4294967263;
         son_type$field = new int();
      }
      
      public function get hasSonType() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set sonType(param1:int) : void
      {
         hasField$0 |= 32;
         son_type$field = param1;
      }
      
      public function get sonType() : int
      {
         return son_type$field;
      }
      
      public function removeUsable() : void
      {
         hasField$0 &= 4294967231;
         usable$field = new Boolean();
      }
      
      public function get hasUsable() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set usable(param1:Boolean) : void
      {
         hasField$0 |= 64;
         usable$field = param1;
      }
      
      public function get usable() : Boolean
      {
         return usable$field;
      }
      
      public function removePage() : void
      {
         hasField$0 &= 4294967167;
         page$field = new int();
      }
      
      public function get hasPage() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set page(param1:int) : void
      {
         hasField$0 |= 128;
         page$field = param1;
      }
      
      public function get page() : int
      {
         return page$field;
      }
      
      public function removeOrderBy() : void
      {
         hasField$0 &= 4294967039;
         order_by$field = new int();
      }
      
      public function get hasOrderBy() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set orderBy(param1:int) : void
      {
         hasField$0 |= 256;
         order_by$field = param1;
      }
      
      public function get orderBy() : int
      {
         return order_by$field;
      }
      
      public function removeOrderType() : void
      {
         hasField$0 &= 4294966783;
         order_type$field = new int();
      }
      
      public function get hasOrderType() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set orderType(param1:int) : void
      {
         hasField$0 |= 512;
         order_type$field = param1;
      }
      
      public function get orderType() : int
      {
         return order_type$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasItemName)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,item_name$field);
         }
         if(hasMinLevel)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,min_level$field);
         }
         if(hasMaxLevel)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,max_level$field);
         }
         if(hasQuality)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,quality$field);
         }
         if(hasJob)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,job$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasSonType)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,son_type$field);
         }
         if(hasUsable)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_BOOL(param1,usable$field);
         }
         if(hasPage)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,page$field);
         }
         if(hasOrderBy)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,order_by$field);
         }
         if(hasOrderType)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,order_type$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:* = 0;
         var _loc12_:uint = 0;
         var _loc7_:uint = 0;
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         var _loc11_:uint = 0;
         var _loc9_:uint = 0;
         var _loc4_:uint = 0;
         var _loc14_:uint = 0;
         var _loc8_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc13_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: SearchItemReqMsg.itemName cannot be set twice.");
                  }
                  _loc12_++;
                  itemName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SearchItemReqMsg.minLevel cannot be set twice.");
                  }
                  _loc7_++;
                  minLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: SearchItemReqMsg.maxLevel cannot be set twice.");
                  }
                  _loc10_++;
                  maxLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SearchItemReqMsg.quality cannot be set twice.");
                  }
                  _loc3_++;
                  quality = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: SearchItemReqMsg.job cannot be set twice.");
                  }
                  _loc11_++;
                  job = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: SearchItemReqMsg.type cannot be set twice.");
                  }
                  _loc9_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SearchItemReqMsg.sonType cannot be set twice.");
                  }
                  _loc4_++;
                  sonType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: SearchItemReqMsg.usable cannot be set twice.");
                  }
                  _loc14_++;
                  usable = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 8:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SearchItemReqMsg.page cannot be set twice.");
                  }
                  _loc8_++;
                  page = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SearchItemReqMsg.orderBy cannot be set twice.");
                  }
                  _loc5_++;
                  orderBy = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SearchItemReqMsg.orderType cannot be set twice.");
                  }
                  _loc6_++;
                  orderType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

