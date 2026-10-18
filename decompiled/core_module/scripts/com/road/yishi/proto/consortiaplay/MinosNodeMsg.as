package com.road.yishi.proto.consortiaplay
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MinosNodeMsg extends Message implements IExternalizable
   {
      
      private var x$field:int;
      
      private var hasField$0:uint = 0;
      
      private var y$field:int;
      
      private var id$field:int;
      
      private var isOpen$field:Boolean;
      
      private var progress$field:int;
      
      public function MinosNodeMsg()
      {
         super();
      }
      
      public function removeX() : void
      {
         hasField$0 &= 4294967294;
         x$field = new int();
      }
      
      public function get hasX() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set x(param1:int) : void
      {
         hasField$0 |= 1;
         x$field = param1;
      }
      
      public function get x() : int
      {
         return x$field;
      }
      
      public function removeY() : void
      {
         hasField$0 &= 4294967293;
         y$field = new int();
      }
      
      public function get hasY() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set y(param1:int) : void
      {
         hasField$0 |= 2;
         y$field = param1;
      }
      
      public function get y() : int
      {
         return y$field;
      }
      
      public function removeId() : void
      {
         hasField$0 &= 4294967291;
         id$field = new int();
      }
      
      public function get hasId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set id(param1:int) : void
      {
         hasField$0 |= 4;
         id$field = param1;
      }
      
      public function get id() : int
      {
         return id$field;
      }
      
      public function removeIsOpen() : void
      {
         hasField$0 &= 4294967287;
         isOpen$field = new Boolean();
      }
      
      public function get hasIsOpen() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set isOpen(param1:Boolean) : void
      {
         hasField$0 |= 8;
         isOpen$field = param1;
      }
      
      public function get isOpen() : Boolean
      {
         return isOpen$field;
      }
      
      public function removeProgress() : void
      {
         hasField$0 &= 4294967279;
         progress$field = new int();
      }
      
      public function get hasProgress() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set progress(param1:int) : void
      {
         hasField$0 |= 16;
         progress$field = param1;
      }
      
      public function get progress() : int
      {
         return progress$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasX)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,x$field);
         }
         if(hasY)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,y$field);
         }
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         if(hasIsOpen)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,isOpen$field);
         }
         if(hasProgress)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,progress$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MinosNodeMsg.x cannot be set twice.");
                  }
                  _loc4_++;
                  x = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MinosNodeMsg.y cannot be set twice.");
                  }
                  _loc6_++;
                  y = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: MinosNodeMsg.id cannot be set twice.");
                  }
                  _loc7_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MinosNodeMsg.isOpen cannot be set twice.");
                  }
                  _loc5_++;
                  isOpen = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MinosNodeMsg.progress cannot be set twice.");
                  }
                  _loc3_++;
                  progress = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

