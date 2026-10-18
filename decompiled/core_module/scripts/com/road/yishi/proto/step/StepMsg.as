package com.road.yishi.proto.step
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class StepMsg extends Message implements IExternalizable
   {
      
      private var Id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var Name$field:String;
      
      private var Type$field:int;
      
      private var Step$field:int;
      
      private var Value$field:int;
      
      public function StepMsg()
      {
         super();
      }
      
      public function removeId() : void
      {
         hasField$0 &= 4294967294;
         Id$field = new int();
      }
      
      public function get hasId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set id(param1:int) : void
      {
         hasField$0 |= 1;
         Id$field = param1;
      }
      
      public function get id() : int
      {
         return Id$field;
      }
      
      public function removeName() : void
      {
         Name$field = null;
      }
      
      public function get hasName() : Boolean
      {
         return Name$field != null;
      }
      
      public function set name(param1:String) : void
      {
         Name$field = param1;
      }
      
      public function get name() : String
      {
         return Name$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967293;
         Type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 2;
         Type$field = param1;
      }
      
      public function get type() : int
      {
         return Type$field;
      }
      
      public function removeStep() : void
      {
         hasField$0 &= 4294967291;
         Step$field = new int();
      }
      
      public function get hasStep() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set step(param1:int) : void
      {
         hasField$0 |= 4;
         Step$field = param1;
      }
      
      public function get step() : int
      {
         return Step$field;
      }
      
      public function removeValue() : void
      {
         hasField$0 &= 4294967287;
         Value$field = new int();
      }
      
      public function get hasValue() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set value(param1:int) : void
      {
         hasField$0 |= 8;
         Value$field = param1;
      }
      
      public function get value() : int
      {
         return Value$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,Id$field);
         }
         if(hasName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,Name$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,Type$field);
         }
         if(hasStep)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,Step$field);
         }
         if(hasValue)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,Value$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: StepMsg.id cannot be set twice.");
                  }
                  _loc6_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: StepMsg.name cannot be set twice.");
                  }
                  _loc7_++;
                  name = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: StepMsg.type cannot be set twice.");
                  }
                  _loc3_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: StepMsg.step cannot be set twice.");
                  }
                  _loc8_++;
                  step = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: StepMsg.value cannot be set twice.");
                  }
                  _loc4_++;
                  value = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

