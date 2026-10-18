package com.road.yishi.proto.cccactive
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RecordMsg extends Message implements IExternalizable
   {
      
      private var label$field:int;
      
      private var hasField$0:uint = 0;
      
      private var index$field:int;
      
      private var curNum$field:int;
      
      public function RecordMsg()
      {
         super();
      }
      
      public function removeLabel() : void
      {
         hasField$0 &= 4294967294;
         label$field = new int();
      }
      
      public function get hasLabel() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set label(param1:int) : void
      {
         hasField$0 |= 1;
         label$field = param1;
      }
      
      public function get label() : int
      {
         return label$field;
      }
      
      public function removeIndex() : void
      {
         hasField$0 &= 4294967293;
         index$field = new int();
      }
      
      public function get hasIndex() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set index(param1:int) : void
      {
         hasField$0 |= 2;
         index$field = param1;
      }
      
      public function get index() : int
      {
         return index$field;
      }
      
      public function removeCurNum() : void
      {
         hasField$0 &= 4294967291;
         curNum$field = new int();
      }
      
      public function get hasCurNum() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set curNum(param1:int) : void
      {
         hasField$0 |= 4;
         curNum$field = param1;
      }
      
      public function get curNum() : int
      {
         return curNum$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasLabel)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,label$field);
         }
         if(hasIndex)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,index$field);
         }
         if(hasCurNum)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,curNum$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RecordMsg.label cannot be set twice.");
                  }
                  _loc3_++;
                  label = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: RecordMsg.index cannot be set twice.");
                  }
                  _loc4_++;
                  index = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: RecordMsg.curNum cannot be set twice.");
                  }
                  _loc6_++;
                  curNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

