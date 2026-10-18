package com.road.yishi.proto.apex
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ApexMainViewMsg extends Message implements IExternalizable
   {
      
      private var selfSignUp$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var curTeamMemNum$field:int;
      
      public function ApexMainViewMsg()
      {
         super();
      }
      
      public function removeSelfSignUp() : void
      {
         hasField$0 &= 4294967294;
         selfSignUp$field = new Boolean();
      }
      
      public function get hasSelfSignUp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set selfSignUp(param1:Boolean) : void
      {
         hasField$0 |= 1;
         selfSignUp$field = param1;
      }
      
      public function get selfSignUp() : Boolean
      {
         return selfSignUp$field;
      }
      
      public function removeCurTeamMemNum() : void
      {
         hasField$0 &= 4294967293;
         curTeamMemNum$field = new int();
      }
      
      public function get hasCurTeamMemNum() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set curTeamMemNum(param1:int) : void
      {
         hasField$0 |= 2;
         curTeamMemNum$field = param1;
      }
      
      public function get curTeamMemNum() : int
      {
         return curTeamMemNum$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasSelfSignUp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_BOOL(param1,selfSignUp$field);
         }
         if(hasCurTeamMemNum)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,curTeamMemNum$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ApexMainViewMsg.selfSignUp cannot be set twice.");
                  }
                  _loc3_++;
                  selfSignUp = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ApexMainViewMsg.curTeamMemNum cannot be set twice.");
                  }
                  _loc5_++;
                  curTeamMemNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

