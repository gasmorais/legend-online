package com.road.yishi.proto.tattoo
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TattooHoleMsg extends Message implements IExternalizable
   {
      
      private var hole$field:int;
      
      private var hasField$0:uint = 0;
      
      private var OldAddProperty$field:int;
      
      private var OldAddingValue$field:int;
      
      private var OldReduceProperty$field:int;
      
      private var OldReduceValue$field:int;
      
      private var NewAddProperty$field:int;
      
      private var NewAddingValue$field:int;
      
      private var NewReduceProperty$field:int;
      
      private var NewReduceValue$field:int;
      
      private var OldTattooType$field:int;
      
      private var NewTattooType$field:int;
      
      public function TattooHoleMsg()
      {
         super();
      }
      
      public function removeHole() : void
      {
         hasField$0 &= 4294967294;
         hole$field = new int();
      }
      
      public function get hasHole() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set hole(param1:int) : void
      {
         hasField$0 |= 1;
         hole$field = param1;
      }
      
      public function get hole() : int
      {
         return hole$field;
      }
      
      public function removeOldAddProperty() : void
      {
         hasField$0 &= 4294967293;
         OldAddProperty$field = new int();
      }
      
      public function get hasOldAddProperty() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set oldAddProperty(param1:int) : void
      {
         hasField$0 |= 2;
         OldAddProperty$field = param1;
      }
      
      public function get oldAddProperty() : int
      {
         return OldAddProperty$field;
      }
      
      public function removeOldAddingValue() : void
      {
         hasField$0 &= 4294967291;
         OldAddingValue$field = new int();
      }
      
      public function get hasOldAddingValue() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set oldAddingValue(param1:int) : void
      {
         hasField$0 |= 4;
         OldAddingValue$field = param1;
      }
      
      public function get oldAddingValue() : int
      {
         return OldAddingValue$field;
      }
      
      public function removeOldReduceProperty() : void
      {
         hasField$0 &= 4294967287;
         OldReduceProperty$field = new int();
      }
      
      public function get hasOldReduceProperty() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set oldReduceProperty(param1:int) : void
      {
         hasField$0 |= 8;
         OldReduceProperty$field = param1;
      }
      
      public function get oldReduceProperty() : int
      {
         return OldReduceProperty$field;
      }
      
      public function removeOldReduceValue() : void
      {
         hasField$0 &= 4294967279;
         OldReduceValue$field = new int();
      }
      
      public function get hasOldReduceValue() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set oldReduceValue(param1:int) : void
      {
         hasField$0 |= 16;
         OldReduceValue$field = param1;
      }
      
      public function get oldReduceValue() : int
      {
         return OldReduceValue$field;
      }
      
      public function removeNewAddProperty() : void
      {
         hasField$0 &= 4294967263;
         NewAddProperty$field = new int();
      }
      
      public function get hasNewAddProperty() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set newAddProperty(param1:int) : void
      {
         hasField$0 |= 32;
         NewAddProperty$field = param1;
      }
      
      public function get newAddProperty() : int
      {
         return NewAddProperty$field;
      }
      
      public function removeNewAddingValue() : void
      {
         hasField$0 &= 4294967231;
         NewAddingValue$field = new int();
      }
      
      public function get hasNewAddingValue() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set newAddingValue(param1:int) : void
      {
         hasField$0 |= 64;
         NewAddingValue$field = param1;
      }
      
      public function get newAddingValue() : int
      {
         return NewAddingValue$field;
      }
      
      public function removeNewReduceProperty() : void
      {
         hasField$0 &= 4294967167;
         NewReduceProperty$field = new int();
      }
      
      public function get hasNewReduceProperty() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set newReduceProperty(param1:int) : void
      {
         hasField$0 |= 128;
         NewReduceProperty$field = param1;
      }
      
      public function get newReduceProperty() : int
      {
         return NewReduceProperty$field;
      }
      
      public function removeNewReduceValue() : void
      {
         hasField$0 &= 4294967039;
         NewReduceValue$field = new int();
      }
      
      public function get hasNewReduceValue() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set newReduceValue(param1:int) : void
      {
         hasField$0 |= 256;
         NewReduceValue$field = param1;
      }
      
      public function get newReduceValue() : int
      {
         return NewReduceValue$field;
      }
      
      public function removeOldTattooType() : void
      {
         hasField$0 &= 4294966783;
         OldTattooType$field = new int();
      }
      
      public function get hasOldTattooType() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set oldTattooType(param1:int) : void
      {
         hasField$0 |= 512;
         OldTattooType$field = param1;
      }
      
      public function get oldTattooType() : int
      {
         return OldTattooType$field;
      }
      
      public function removeNewTattooType() : void
      {
         hasField$0 &= 4294966271;
         NewTattooType$field = new int();
      }
      
      public function get hasNewTattooType() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set newTattooType(param1:int) : void
      {
         hasField$0 |= 1024;
         NewTattooType$field = param1;
      }
      
      public function get newTattooType() : int
      {
         return NewTattooType$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasHole)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,hole$field);
         }
         if(hasOldAddProperty)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,OldAddProperty$field);
         }
         if(hasOldAddingValue)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,OldAddingValue$field);
         }
         if(hasOldReduceProperty)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,OldReduceProperty$field);
         }
         if(hasOldReduceValue)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,OldReduceValue$field);
         }
         if(hasNewAddProperty)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,NewAddProperty$field);
         }
         if(hasNewAddingValue)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,NewAddingValue$field);
         }
         if(hasNewReduceProperty)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,NewReduceProperty$field);
         }
         if(hasNewReduceValue)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,NewReduceValue$field);
         }
         if(hasOldTattooType)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,OldTattooType$field);
         }
         if(hasNewTattooType)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,NewTattooType$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc14_:* = 0;
         var _loc3_:uint = 0;
         var _loc12_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc13_:uint = 0;
         var _loc5_:uint = 0;
         var _loc11_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc10_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc14_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TattooHoleMsg.hole cannot be set twice.");
                  }
                  _loc3_++;
                  hole = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: TattooHoleMsg.oldAddProperty cannot be set twice.");
                  }
                  _loc12_++;
                  oldAddProperty = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: TattooHoleMsg.oldAddingValue cannot be set twice.");
                  }
                  _loc7_++;
                  oldAddingValue = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: TattooHoleMsg.oldReduceProperty cannot be set twice.");
                  }
                  _loc8_++;
                  oldReduceProperty = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: TattooHoleMsg.oldReduceValue cannot be set twice.");
                  }
                  _loc13_++;
                  oldReduceValue = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TattooHoleMsg.newAddProperty cannot be set twice.");
                  }
                  _loc5_++;
                  newAddProperty = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: TattooHoleMsg.newAddingValue cannot be set twice.");
                  }
                  _loc11_++;
                  newAddingValue = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TattooHoleMsg.newReduceProperty cannot be set twice.");
                  }
                  _loc4_++;
                  newReduceProperty = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: TattooHoleMsg.newReduceValue cannot be set twice.");
                  }
                  _loc6_++;
                  newReduceValue = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: TattooHoleMsg.oldTattooType cannot be set twice.");
                  }
                  _loc10_++;
                  oldTattooType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: TattooHoleMsg.newTattooType cannot be set twice.");
                  }
                  _loc9_++;
                  newTattooType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc14_ & 7);
            }
         }
      }
   }
}

