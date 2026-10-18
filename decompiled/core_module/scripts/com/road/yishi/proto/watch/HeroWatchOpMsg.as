package com.road.yishi.proto.watch
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class HeroWatchOpMsg extends Message implements IExternalizable
   {
      
      private var op_type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var grid_type$field:int;
      
      private var grid_pos$field:int;
      
      private var jion_pos$field:int;
      
      private var item_pos$field:int;
      
      private var bag_type$field:int;
      
      private var pay_type$field:int;
      
      public function HeroWatchOpMsg()
      {
         super();
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294967294;
         op_type$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 1;
         op_type$field = param1;
      }
      
      public function get opType() : int
      {
         return op_type$field;
      }
      
      public function removeGridType() : void
      {
         hasField$0 &= 4294967293;
         grid_type$field = new int();
      }
      
      public function get hasGridType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set gridType(param1:int) : void
      {
         hasField$0 |= 2;
         grid_type$field = param1;
      }
      
      public function get gridType() : int
      {
         return grid_type$field;
      }
      
      public function removeGridPos() : void
      {
         hasField$0 &= 4294967291;
         grid_pos$field = new int();
      }
      
      public function get hasGridPos() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set gridPos(param1:int) : void
      {
         hasField$0 |= 4;
         grid_pos$field = param1;
      }
      
      public function get gridPos() : int
      {
         return grid_pos$field;
      }
      
      public function removeJionPos() : void
      {
         hasField$0 &= 4294967287;
         jion_pos$field = new int();
      }
      
      public function get hasJionPos() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set jionPos(param1:int) : void
      {
         hasField$0 |= 8;
         jion_pos$field = param1;
      }
      
      public function get jionPos() : int
      {
         return jion_pos$field;
      }
      
      public function removeItemPos() : void
      {
         hasField$0 &= 4294967279;
         item_pos$field = new int();
      }
      
      public function get hasItemPos() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set itemPos(param1:int) : void
      {
         hasField$0 |= 16;
         item_pos$field = param1;
      }
      
      public function get itemPos() : int
      {
         return item_pos$field;
      }
      
      public function removeBagType() : void
      {
         hasField$0 &= 4294967263;
         bag_type$field = new int();
      }
      
      public function get hasBagType() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set bagType(param1:int) : void
      {
         hasField$0 |= 32;
         bag_type$field = param1;
      }
      
      public function get bagType() : int
      {
         return bag_type$field;
      }
      
      public function removePayType() : void
      {
         hasField$0 &= 4294967231;
         pay_type$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 64;
         pay_type$field = param1;
      }
      
      public function get payType() : int
      {
         return pay_type$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op_type$field);
         }
         if(hasGridType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,grid_type$field);
         }
         if(hasGridPos)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,grid_pos$field);
         }
         if(hasJionPos)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,jion_pos$field);
         }
         if(hasItemPos)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,item_pos$field);
         }
         if(hasBagType)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,bag_type$field);
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,pay_type$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc10_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: HeroWatchOpMsg.opType cannot be set twice.");
                  }
                  _loc5_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: HeroWatchOpMsg.gridType cannot be set twice.");
                  }
                  _loc4_++;
                  gridType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: HeroWatchOpMsg.gridPos cannot be set twice.");
                  }
                  _loc6_++;
                  gridPos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: HeroWatchOpMsg.jionPos cannot be set twice.");
                  }
                  _loc7_++;
                  jionPos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: HeroWatchOpMsg.itemPos cannot be set twice.");
                  }
                  _loc3_++;
                  itemPos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: HeroWatchOpMsg.bagType cannot be set twice.");
                  }
                  _loc10_++;
                  bagType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: HeroWatchOpMsg.payType cannot be set twice.");
                  }
                  _loc9_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

