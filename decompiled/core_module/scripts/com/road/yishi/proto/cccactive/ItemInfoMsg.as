package com.road.yishi.proto.cccactive
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ItemInfoMsg extends Message implements IExternalizable
   {
      
      private var label$field:int;
      
      private var hasField$0:uint = 0;
      
      private var index$field:int;
      
      private var maxNum$field:int;
      
      private var currentNum$field:int;
      
      private var tempId$field:int;
      
      private var gainNum$field:int;
      
      public function ItemInfoMsg()
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
      
      public function removeMaxNum() : void
      {
         hasField$0 &= 4294967291;
         maxNum$field = new int();
      }
      
      public function get hasMaxNum() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set maxNum(param1:int) : void
      {
         hasField$0 |= 4;
         maxNum$field = param1;
      }
      
      public function get maxNum() : int
      {
         return maxNum$field;
      }
      
      public function removeCurrentNum() : void
      {
         hasField$0 &= 4294967287;
         currentNum$field = new int();
      }
      
      public function get hasCurrentNum() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set currentNum(param1:int) : void
      {
         hasField$0 |= 8;
         currentNum$field = param1;
      }
      
      public function get currentNum() : int
      {
         return currentNum$field;
      }
      
      public function removeTempId() : void
      {
         hasField$0 &= 4294967279;
         tempId$field = new int();
      }
      
      public function get hasTempId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set tempId(param1:int) : void
      {
         hasField$0 |= 16;
         tempId$field = param1;
      }
      
      public function get tempId() : int
      {
         return tempId$field;
      }
      
      public function removeGainNum() : void
      {
         hasField$0 &= 4294967263;
         gainNum$field = new int();
      }
      
      public function get hasGainNum() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set gainNum(param1:int) : void
      {
         hasField$0 |= 32;
         gainNum$field = param1;
      }
      
      public function get gainNum() : int
      {
         return gainNum$field;
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
         if(hasMaxNum)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,maxNum$field);
         }
         if(hasCurrentNum)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,currentNum$field);
         }
         if(hasTempId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,tempId$field);
         }
         if(hasGainNum)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,gainNum$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ItemInfoMsg.label cannot be set twice.");
                  }
                  _loc3_++;
                  label = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ItemInfoMsg.index cannot be set twice.");
                  }
                  _loc5_++;
                  index = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ItemInfoMsg.maxNum cannot be set twice.");
                  }
                  _loc7_++;
                  maxNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ItemInfoMsg.currentNum cannot be set twice.");
                  }
                  _loc8_++;
                  currentNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ItemInfoMsg.tempId cannot be set twice.");
                  }
                  _loc6_++;
                  tempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ItemInfoMsg.gainNum cannot be set twice.");
                  }
                  _loc4_++;
                  gainNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

