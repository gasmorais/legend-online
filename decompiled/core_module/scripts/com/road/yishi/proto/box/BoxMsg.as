package com.road.yishi.proto.box
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BoxMsg extends Message implements IExternalizable
   {
      
      private var time$field:int;
      
      private var hasField$0:uint = 0;
      
      private var grade$field:int;
      
      private var operate$field:Boolean;
      
      private var timerun$field:int;
      
      public function BoxMsg()
      {
         super();
      }
      
      public function removeTime() : void
      {
         hasField$0 &= 4294967294;
         time$field = new int();
      }
      
      public function get hasTime() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set time(param1:int) : void
      {
         hasField$0 |= 1;
         time$field = param1;
      }
      
      public function get time() : int
      {
         return time$field;
      }
      
      public function removeGrade() : void
      {
         hasField$0 &= 4294967293;
         grade$field = new int();
      }
      
      public function get hasGrade() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set grade(param1:int) : void
      {
         hasField$0 |= 2;
         grade$field = param1;
      }
      
      public function get grade() : int
      {
         return grade$field;
      }
      
      public function removeOperate() : void
      {
         hasField$0 &= 4294967291;
         operate$field = new Boolean();
      }
      
      public function get hasOperate() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set operate(param1:Boolean) : void
      {
         hasField$0 |= 4;
         operate$field = param1;
      }
      
      public function get operate() : Boolean
      {
         return operate$field;
      }
      
      public function removeTimerun() : void
      {
         hasField$0 &= 4294967287;
         timerun$field = new int();
      }
      
      public function get hasTimerun() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set timerun(param1:int) : void
      {
         hasField$0 |= 8;
         timerun$field = param1;
      }
      
      public function get timerun() : int
      {
         return timerun$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTime)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,time$field);
         }
         if(hasGrade)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,grade$field);
         }
         if(hasOperate)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,operate$field);
         }
         if(hasTimerun)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,timerun$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: BoxMsg.time cannot be set twice.");
                  }
                  _loc7_++;
                  time = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: BoxMsg.grade cannot be set twice.");
                  }
                  _loc4_++;
                  grade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: BoxMsg.operate cannot be set twice.");
                  }
                  _loc5_++;
                  operate = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BoxMsg.timerun cannot be set twice.");
                  }
                  _loc3_++;
                  timerun = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

