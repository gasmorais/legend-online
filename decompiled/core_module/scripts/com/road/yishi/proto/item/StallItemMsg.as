package com.road.yishi.proto.item
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class StallItemMsg extends Message implements IExternalizable
   {
      
      private var point$field:int;
      
      private var hasField$0:uint = 0;
      
      private var money$field:int;
      
      private var item_info$field:ItemInfoMsg;
      
      public function StallItemMsg()
      {
         super();
      }
      
      public function removePoint() : void
      {
         hasField$0 &= 4294967294;
         point$field = new int();
      }
      
      public function get hasPoint() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set point(param1:int) : void
      {
         hasField$0 |= 1;
         point$field = param1;
      }
      
      public function get point() : int
      {
         return point$field;
      }
      
      public function removeMoney() : void
      {
         hasField$0 &= 4294967293;
         money$field = new int();
      }
      
      public function get hasMoney() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set money(param1:int) : void
      {
         hasField$0 |= 2;
         money$field = param1;
      }
      
      public function get money() : int
      {
         return money$field;
      }
      
      public function removeItemInfo() : void
      {
         item_info$field = null;
      }
      
      public function get hasItemInfo() : Boolean
      {
         return item_info$field != null;
      }
      
      public function set itemInfo(param1:ItemInfoMsg) : void
      {
         item_info$field = param1;
      }
      
      public function get itemInfo() : ItemInfoMsg
      {
         return item_info$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasPoint)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,point$field);
         }
         if(hasMoney)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,money$field);
         }
         if(hasItemInfo)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,item_info$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: StallItemMsg.point cannot be set twice.");
                  }
                  _loc4_++;
                  point = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: StallItemMsg.money cannot be set twice.");
                  }
                  _loc3_++;
                  money = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: StallItemMsg.itemInfo cannot be set twice.");
                  }
                  _loc6_++;
                  itemInfo = new ItemInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,itemInfo);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

