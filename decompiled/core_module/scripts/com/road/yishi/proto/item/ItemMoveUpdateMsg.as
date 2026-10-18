package com.road.yishi.proto.item
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ItemMoveUpdateMsg extends Message implements IExternalizable
   {
      
      private var change_type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var change_obj_id$field:int;
      
      private var change_pos$field:int;
      
      private var item$field:ItemInfoMsg;
      
      public function ItemMoveUpdateMsg()
      {
         super();
      }
      
      public function removeChangeType() : void
      {
         hasField$0 &= 4294967294;
         change_type$field = new int();
      }
      
      public function get hasChangeType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set changeType(param1:int) : void
      {
         hasField$0 |= 1;
         change_type$field = param1;
      }
      
      public function get changeType() : int
      {
         return change_type$field;
      }
      
      public function removeChangeObjId() : void
      {
         hasField$0 &= 4294967293;
         change_obj_id$field = new int();
      }
      
      public function get hasChangeObjId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set changeObjId(param1:int) : void
      {
         hasField$0 |= 2;
         change_obj_id$field = param1;
      }
      
      public function get changeObjId() : int
      {
         return change_obj_id$field;
      }
      
      public function removeChangePos() : void
      {
         hasField$0 &= 4294967291;
         change_pos$field = new int();
      }
      
      public function get hasChangePos() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set changePos(param1:int) : void
      {
         hasField$0 |= 4;
         change_pos$field = param1;
      }
      
      public function get changePos() : int
      {
         return change_pos$field;
      }
      
      public function removeItem() : void
      {
         item$field = null;
      }
      
      public function get hasItem() : Boolean
      {
         return item$field != null;
      }
      
      public function set item(param1:ItemInfoMsg) : void
      {
         item$field = param1;
      }
      
      public function get item() : ItemInfoMsg
      {
         return item$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasChangeType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,change_type$field);
         }
         if(hasChangeObjId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,change_obj_id$field);
         }
         if(hasChangePos)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,change_pos$field);
         }
         if(hasItem)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,item$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ItemMoveUpdateMsg.changeType cannot be set twice.");
                  }
                  _loc4_++;
                  changeType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ItemMoveUpdateMsg.changeObjId cannot be set twice.");
                  }
                  _loc3_++;
                  changeObjId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ItemMoveUpdateMsg.changePos cannot be set twice.");
                  }
                  _loc7_++;
                  changePos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ItemMoveUpdateMsg.item cannot be set twice.");
                  }
                  _loc5_++;
                  item = new ItemInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,item);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

