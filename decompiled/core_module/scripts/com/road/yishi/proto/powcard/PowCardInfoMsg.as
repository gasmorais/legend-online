package com.road.yishi.proto.powcard
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PowCardInfoMsg extends Message implements IExternalizable
   {
      
      private var tempId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var grade$field:int;
      
      private var gp$field:int;
      
      private var buf$field:PowCardBufMsg;
      
      private var isActive$field:int;
      
      public function PowCardInfoMsg()
      {
         super();
      }
      
      public function removeTempId() : void
      {
         hasField$0 &= 4294967294;
         tempId$field = new int();
      }
      
      public function get hasTempId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set tempId(param1:int) : void
      {
         hasField$0 |= 1;
         tempId$field = param1;
      }
      
      public function get tempId() : int
      {
         return tempId$field;
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
      
      public function removeGp() : void
      {
         hasField$0 &= 4294967291;
         gp$field = new int();
      }
      
      public function get hasGp() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set gp(param1:int) : void
      {
         hasField$0 |= 4;
         gp$field = param1;
      }
      
      public function get gp() : int
      {
         return gp$field;
      }
      
      public function removeBuf() : void
      {
         buf$field = null;
      }
      
      public function get hasBuf() : Boolean
      {
         return buf$field != null;
      }
      
      public function set buf(param1:PowCardBufMsg) : void
      {
         buf$field = param1;
      }
      
      public function get buf() : PowCardBufMsg
      {
         return buf$field;
      }
      
      public function removeIsActive() : void
      {
         hasField$0 &= 4294967287;
         isActive$field = new int();
      }
      
      public function get hasIsActive() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set isActive(param1:int) : void
      {
         hasField$0 |= 8;
         isActive$field = param1;
      }
      
      public function get isActive() : int
      {
         return isActive$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTempId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,tempId$field);
         }
         if(hasGrade)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,grade$field);
         }
         if(hasGp)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,gp$field);
         }
         if(hasBuf)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,buf$field);
         }
         if(hasIsActive)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,isActive$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PowCardInfoMsg.tempId cannot be set twice.");
                  }
                  _loc3_++;
                  tempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PowCardInfoMsg.grade cannot be set twice.");
                  }
                  _loc5_++;
                  grade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PowCardInfoMsg.gp cannot be set twice.");
                  }
                  _loc8_++;
                  gp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PowCardInfoMsg.buf cannot be set twice.");
                  }
                  _loc4_++;
                  buf = new PowCardBufMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,buf);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PowCardInfoMsg.isActive cannot be set twice.");
                  }
                  _loc6_++;
                  isActive = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

