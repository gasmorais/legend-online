package com.road.yishi.proto.regress
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RegressRecordMsg extends Message implements IExternalizable
   {
      
      private var takeTemplateId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var takeNum$field:int;
      
      private var isFinish$field:Boolean;
      
      private var isTakeReward$field:Boolean;
      
      public function RegressRecordMsg()
      {
         super();
      }
      
      public function removeTakeTemplateId() : void
      {
         hasField$0 &= 4294967294;
         takeTemplateId$field = new int();
      }
      
      public function get hasTakeTemplateId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set takeTemplateId(param1:int) : void
      {
         hasField$0 |= 1;
         takeTemplateId$field = param1;
      }
      
      public function get takeTemplateId() : int
      {
         return takeTemplateId$field;
      }
      
      public function removeTakeNum() : void
      {
         hasField$0 &= 4294967293;
         takeNum$field = new int();
      }
      
      public function get hasTakeNum() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set takeNum(param1:int) : void
      {
         hasField$0 |= 2;
         takeNum$field = param1;
      }
      
      public function get takeNum() : int
      {
         return takeNum$field;
      }
      
      public function removeIsFinish() : void
      {
         hasField$0 &= 4294967291;
         isFinish$field = new Boolean();
      }
      
      public function get hasIsFinish() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set isFinish(param1:Boolean) : void
      {
         hasField$0 |= 4;
         isFinish$field = param1;
      }
      
      public function get isFinish() : Boolean
      {
         return isFinish$field;
      }
      
      public function removeIsTakeReward() : void
      {
         hasField$0 &= 4294967287;
         isTakeReward$field = new Boolean();
      }
      
      public function get hasIsTakeReward() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set isTakeReward(param1:Boolean) : void
      {
         hasField$0 |= 8;
         isTakeReward$field = param1;
      }
      
      public function get isTakeReward() : Boolean
      {
         return isTakeReward$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTakeTemplateId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,takeTemplateId$field);
         }
         if(hasTakeNum)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,takeNum$field);
         }
         if(hasIsFinish)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,isFinish$field);
         }
         if(hasIsTakeReward)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,isTakeReward$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: RegressRecordMsg.takeTemplateId cannot be set twice.");
                  }
                  _loc5_++;
                  takeTemplateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: RegressRecordMsg.takeNum cannot be set twice.");
                  }
                  _loc4_++;
                  takeNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RegressRecordMsg.isFinish cannot be set twice.");
                  }
                  _loc3_++;
                  isFinish = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: RegressRecordMsg.isTakeReward cannot be set twice.");
                  }
                  _loc7_++;
                  isTakeReward = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

