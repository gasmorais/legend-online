package com.road.yishi.proto.team
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class JoinTeamUserMsg extends Message implements IExternalizable
   {
      
      private var apply_userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var apply_nickName$field:String;
      
      private var apply_sex$field:int;
      
      private var trans_grade$field:int;
      
      private var apply_grade$field:int;
      
      private var apply_job$field:int;
      
      public function JoinTeamUserMsg()
      {
         super();
      }
      
      public function removeApplyUserId() : void
      {
         hasField$0 &= 4294967294;
         apply_userId$field = new int();
      }
      
      public function get hasApplyUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set applyUserId(param1:int) : void
      {
         hasField$0 |= 1;
         apply_userId$field = param1;
      }
      
      public function get applyUserId() : int
      {
         return apply_userId$field;
      }
      
      public function removeApplyNickName() : void
      {
         apply_nickName$field = null;
      }
      
      public function get hasApplyNickName() : Boolean
      {
         return apply_nickName$field != null;
      }
      
      public function set applyNickName(param1:String) : void
      {
         apply_nickName$field = param1;
      }
      
      public function get applyNickName() : String
      {
         return apply_nickName$field;
      }
      
      public function removeApplySex() : void
      {
         hasField$0 &= 4294967293;
         apply_sex$field = new int();
      }
      
      public function get hasApplySex() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set applySex(param1:int) : void
      {
         hasField$0 |= 2;
         apply_sex$field = param1;
      }
      
      public function get applySex() : int
      {
         return apply_sex$field;
      }
      
      public function removeTransGrade() : void
      {
         hasField$0 &= 4294967291;
         trans_grade$field = new int();
      }
      
      public function get hasTransGrade() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set transGrade(param1:int) : void
      {
         hasField$0 |= 4;
         trans_grade$field = param1;
      }
      
      public function get transGrade() : int
      {
         return trans_grade$field;
      }
      
      public function removeApplyGrade() : void
      {
         hasField$0 &= 4294967287;
         apply_grade$field = new int();
      }
      
      public function get hasApplyGrade() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set applyGrade(param1:int) : void
      {
         hasField$0 |= 8;
         apply_grade$field = param1;
      }
      
      public function get applyGrade() : int
      {
         return apply_grade$field;
      }
      
      public function removeApplyJob() : void
      {
         hasField$0 &= 4294967279;
         apply_job$field = new int();
      }
      
      public function get hasApplyJob() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set applyJob(param1:int) : void
      {
         hasField$0 |= 16;
         apply_job$field = param1;
      }
      
      public function get applyJob() : int
      {
         return apply_job$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasApplyUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,apply_userId$field);
         }
         if(hasApplyNickName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,apply_nickName$field);
         }
         if(hasApplySex)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,apply_sex$field);
         }
         if(hasTransGrade)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,trans_grade$field);
         }
         if(hasApplyGrade)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,apply_grade$field);
         }
         if(hasApplyJob)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,apply_job$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: JoinTeamUserMsg.applyUserId cannot be set twice.");
                  }
                  _loc4_++;
                  applyUserId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: JoinTeamUserMsg.applyNickName cannot be set twice.");
                  }
                  _loc8_++;
                  applyNickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: JoinTeamUserMsg.applySex cannot be set twice.");
                  }
                  _loc9_++;
                  applySex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: JoinTeamUserMsg.transGrade cannot be set twice.");
                  }
                  _loc3_++;
                  transGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: JoinTeamUserMsg.applyGrade cannot be set twice.");
                  }
                  _loc7_++;
                  applyGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: JoinTeamUserMsg.applyJob cannot be set twice.");
                  }
                  _loc6_++;
                  applyJob = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

