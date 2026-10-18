package com.road.yishi.proto.active
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ActiveMsgLeaveInfo extends Message implements IExternalizable
   {
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var msg_str$field:String;
      
      private var op_date$field:String;
      
      private var nick_name$field:String;
      
      private var param1$field:String;
      
      private var param2$field:String;
      
      private var param3$field:int;
      
      public function ActiveMsgLeaveInfo()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         userId$field = param1;
      }
      
      public function get userId() : int
      {
         return userId$field;
      }
      
      public function removeMsgStr() : void
      {
         msg_str$field = null;
      }
      
      public function get hasMsgStr() : Boolean
      {
         return msg_str$field != null;
      }
      
      public function set msgStr(param1:String) : void
      {
         msg_str$field = param1;
      }
      
      public function get msgStr() : String
      {
         return msg_str$field;
      }
      
      public function removeOpDate() : void
      {
         op_date$field = null;
      }
      
      public function get hasOpDate() : Boolean
      {
         return op_date$field != null;
      }
      
      public function set opDate(param1:String) : void
      {
         op_date$field = param1;
      }
      
      public function get opDate() : String
      {
         return op_date$field;
      }
      
      public function removeNickName() : void
      {
         nick_name$field = null;
      }
      
      public function get hasNickName() : Boolean
      {
         return nick_name$field != null;
      }
      
      public function set nickName(param1:String) : void
      {
         nick_name$field = param1;
      }
      
      public function get nickName() : String
      {
         return nick_name$field;
      }
      
      public function removeParam1() : void
      {
         param1$field = null;
      }
      
      public function get hasParam1() : Boolean
      {
         return param1$field != null;
      }
      
      public function set param1(param1:String) : void
      {
         param1$field = param1;
      }
      
      public function get param1() : String
      {
         return param1$field;
      }
      
      public function removeParam2() : void
      {
         param2$field = null;
      }
      
      public function get hasParam2() : Boolean
      {
         return param2$field != null;
      }
      
      public function set param2(param1:String) : void
      {
         param2$field = param1;
      }
      
      public function get param2() : String
      {
         return param2$field;
      }
      
      public function removeParam3() : void
      {
         hasField$0 &= 4294967293;
         param3$field = new int();
      }
      
      public function get hasParam3() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set param3(param1:int) : void
      {
         hasField$0 |= 2;
         param3$field = param1;
      }
      
      public function get param3() : int
      {
         return param3$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasMsgStr)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,msg_str$field);
         }
         if(hasOpDate)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,op_date$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,nick_name$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,param1$field);
         }
         if(hasParam2)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,param2$field);
         }
         if(hasParam3)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,param3$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc10_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveMsgLeaveInfo.userId cannot be set twice.");
                  }
                  _loc7_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveMsgLeaveInfo.msgStr cannot be set twice.");
                  }
                  _loc3_++;
                  msgStr = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveMsgLeaveInfo.opDate cannot be set twice.");
                  }
                  _loc9_++;
                  opDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveMsgLeaveInfo.nickName cannot be set twice.");
                  }
                  _loc4_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveMsgLeaveInfo.param1 cannot be set twice.");
                  }
                  _loc5_++;
                  param1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveMsgLeaveInfo.param2 cannot be set twice.");
                  }
                  _loc10_++;
                  param2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveMsgLeaveInfo.param3 cannot be set twice.");
                  }
                  _loc6_++;
                  param3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

