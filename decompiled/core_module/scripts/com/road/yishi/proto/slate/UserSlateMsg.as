package com.road.yishi.proto.slate
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class UserSlateMsg extends Message implements IExternalizable
   {
      
      private var opType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var posMark$field:int;
      
      [ArrayElementType("com.road.yishi.proto.slate.SlateTaskMsg")]
      public var tasks:Array = [];
      
      private var property$field:SlatePropertyMsg;
      
      [ArrayElementType("com.road.yishi.proto.slate.SlateMsg")]
      public var slates:Array = [];
      
      public function UserSlateMsg()
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
      
      public function removePosMark() : void
      {
         hasField$0 &= 4294967293;
         posMark$field = new int();
      }
      
      public function get hasPosMark() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set posMark(param1:int) : void
      {
         hasField$0 |= 2;
         posMark$field = param1;
      }
      
      public function get posMark() : int
      {
         return posMark$field;
      }
      
      public function removeProperty() : void
      {
         property$field = null;
      }
      
      public function get hasProperty() : Boolean
      {
         return property$field != null;
      }
      
      public function set property(param1:SlatePropertyMsg) : void
      {
         property$field = param1;
      }
      
      public function get property() : SlatePropertyMsg
      {
         return property$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,opType$field);
         }
         if(hasPosMark)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,posMark$field);
         }
         _loc3_ = 0;
         while(_loc3_ < tasks.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,tasks[_loc3_]);
            _loc3_++;
         }
         if(hasProperty)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,property$field);
         }
         _loc2_ = 0;
         while(_loc2_ < slates.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,slates[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc7_:SlateTaskMsg = null;
         var _loc8_:SlateMsg = null;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: UserSlateMsg.opType cannot be set twice.");
                  }
                  _loc3_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: UserSlateMsg.posMark cannot be set twice.");
                  }
                  _loc6_++;
                  posMark = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  _loc7_ = new SlateTaskMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  tasks.push(_loc7_);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: UserSlateMsg.property cannot be set twice.");
                  }
                  _loc4_++;
                  property = new SlatePropertyMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,property);
                  break;
               case 4:
                  _loc8_ = new SlateMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc8_);
                  slates.push(_loc8_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

