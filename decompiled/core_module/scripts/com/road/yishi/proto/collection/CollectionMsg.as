package com.road.yishi.proto.collection
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CollectionMsg extends Message implements IExternalizable
   {
      
      private var opType$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.collection.CollectionDataMsg")]
      public var datas:Array = [];
      
      private var boxProcess$field:int;
      
      private var dropId$field:int;
      
      public function CollectionMsg()
      {
         super();
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294967294;
         opType$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 1;
         opType$field = param1;
      }
      
      public function get opType() : int
      {
         return opType$field;
      }
      
      public function removeBoxProcess() : void
      {
         hasField$0 &= 4294967293;
         boxProcess$field = new int();
      }
      
      public function get hasBoxProcess() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set boxProcess(param1:int) : void
      {
         hasField$0 |= 2;
         boxProcess$field = param1;
      }
      
      public function get boxProcess() : int
      {
         return boxProcess$field;
      }
      
      public function removeDropId() : void
      {
         hasField$0 &= 4294967291;
         dropId$field = new int();
      }
      
      public function get hasDropId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set dropId(param1:int) : void
      {
         hasField$0 |= 4;
         dropId$field = param1;
      }
      
      public function get dropId() : int
      {
         return dropId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,opType$field);
         }
         _loc2_ = 0;
         while(_loc2_ < datas.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,datas[_loc2_]);
            _loc2_++;
         }
         if(hasBoxProcess)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,boxProcess$field);
         }
         if(hasDropId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,dropId$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc7_:CollectionDataMsg = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CollectionMsg.opType cannot be set twice.");
                  }
                  _loc3_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc7_ = new CollectionDataMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  datas.push(_loc7_);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CollectionMsg.boxProcess cannot be set twice.");
                  }
                  _loc4_++;
                  boxProcess = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CollectionMsg.dropId cannot be set twice.");
                  }
                  _loc5_++;
                  dropId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

