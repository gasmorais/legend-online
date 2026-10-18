package com.road.yishi.proto.tattoo
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TattooEnhanceMsg extends Message implements IExternalizable
   {
      
      private var holdId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var level$field:int;
      
      private var property$field:int;
      
      private var enable$field:Boolean;
      
      public function TattooEnhanceMsg()
      {
         super();
      }
      
      public function removeHoldId() : void
      {
         hasField$0 &= 4294967294;
         holdId$field = new int();
      }
      
      public function get hasHoldId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set holdId(param1:int) : void
      {
         hasField$0 |= 1;
         holdId$field = param1;
      }
      
      public function get holdId() : int
      {
         return holdId$field;
      }
      
      public function removeLevel() : void
      {
         hasField$0 &= 4294967293;
         level$field = new int();
      }
      
      public function get hasLevel() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set level(param1:int) : void
      {
         hasField$0 |= 2;
         level$field = param1;
      }
      
      public function get level() : int
      {
         return level$field;
      }
      
      public function removeProperty() : void
      {
         hasField$0 &= 4294967291;
         property$field = new int();
      }
      
      public function get hasProperty() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set property(param1:int) : void
      {
         hasField$0 |= 4;
         property$field = param1;
      }
      
      public function get property() : int
      {
         return property$field;
      }
      
      public function removeEnable() : void
      {
         hasField$0 &= 4294967287;
         enable$field = new Boolean();
      }
      
      public function get hasEnable() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set enable(param1:Boolean) : void
      {
         hasField$0 |= 8;
         enable$field = param1;
      }
      
      public function get enable() : Boolean
      {
         return enable$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasHoldId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,holdId$field);
         }
         if(hasLevel)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,level$field);
         }
         if(hasProperty)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,property$field);
         }
         if(hasEnable)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,enable$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TattooEnhanceMsg.holdId cannot be set twice.");
                  }
                  _loc4_++;
                  holdId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TattooEnhanceMsg.level cannot be set twice.");
                  }
                  _loc3_++;
                  level = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: TattooEnhanceMsg.property cannot be set twice.");
                  }
                  _loc6_++;
                  property = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TattooEnhanceMsg.enable cannot be set twice.");
                  }
                  _loc5_++;
                  enable = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

