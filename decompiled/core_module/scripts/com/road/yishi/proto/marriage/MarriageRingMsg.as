package com.road.yishi.proto.marriage
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MarriageRingMsg extends Message implements IExternalizable
   {
      
      private var ring_gp$field:int;
      
      private var hasField$0:uint = 0;
      
      private var ring_grade$field:int;
      
      private var ring_skill$field:String;
      
      public function MarriageRingMsg()
      {
         super();
      }
      
      public function removeRingGp() : void
      {
         hasField$0 &= 4294967294;
         ring_gp$field = new int();
      }
      
      public function get hasRingGp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set ringGp(param1:int) : void
      {
         hasField$0 |= 1;
         ring_gp$field = param1;
      }
      
      public function get ringGp() : int
      {
         return ring_gp$field;
      }
      
      public function removeRingGrade() : void
      {
         hasField$0 &= 4294967293;
         ring_grade$field = new int();
      }
      
      public function get hasRingGrade() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set ringGrade(param1:int) : void
      {
         hasField$0 |= 2;
         ring_grade$field = param1;
      }
      
      public function get ringGrade() : int
      {
         return ring_grade$field;
      }
      
      public function removeRingSkill() : void
      {
         ring_skill$field = null;
      }
      
      public function get hasRingSkill() : Boolean
      {
         return ring_skill$field != null;
      }
      
      public function set ringSkill(param1:String) : void
      {
         ring_skill$field = param1;
      }
      
      public function get ringSkill() : String
      {
         return ring_skill$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRingGp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,ring_gp$field);
         }
         if(hasRingGrade)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,ring_grade$field);
         }
         if(hasRingSkill)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,ring_skill$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageRingMsg.ringGp cannot be set twice.");
                  }
                  _loc4_++;
                  ringGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageRingMsg.ringGrade cannot be set twice.");
                  }
                  _loc5_++;
                  ringGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageRingMsg.ringSkill cannot be set twice.");
                  }
                  _loc3_++;
                  ringSkill = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

