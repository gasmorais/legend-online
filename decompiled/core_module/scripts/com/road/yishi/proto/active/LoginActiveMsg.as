package com.road.yishi.proto.active
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class LoginActiveMsg extends Message implements IExternalizable
   {
      
      private var login_count$field:int;
      
      private var hasField$0:uint = 0;
      
      private var begin_tm$field:String;
      
      private var end_tm$field:String;
      
      [ArrayElementType("com.road.yishi.proto.active.LoginRewardInfoMsg")]
      public var rewardInfos:Array = [];
      
      public function LoginActiveMsg()
      {
         super();
      }
      
      public function removeLoginCount() : void
      {
         hasField$0 &= 4294967294;
         login_count$field = new int();
      }
      
      public function get hasLoginCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set loginCount(param1:int) : void
      {
         hasField$0 |= 1;
         login_count$field = param1;
      }
      
      public function get loginCount() : int
      {
         return login_count$field;
      }
      
      public function removeBeginTm() : void
      {
         begin_tm$field = null;
      }
      
      public function get hasBeginTm() : Boolean
      {
         return begin_tm$field != null;
      }
      
      public function set beginTm(param1:String) : void
      {
         begin_tm$field = param1;
      }
      
      public function get beginTm() : String
      {
         return begin_tm$field;
      }
      
      public function removeEndTm() : void
      {
         end_tm$field = null;
      }
      
      public function get hasEndTm() : Boolean
      {
         return end_tm$field != null;
      }
      
      public function set endTm(param1:String) : void
      {
         end_tm$field = param1;
      }
      
      public function get endTm() : String
      {
         return end_tm$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasLoginCount)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,login_count$field);
         }
         if(hasBeginTm)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,begin_tm$field);
         }
         if(hasEndTm)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,end_tm$field);
         }
         _loc2_ = 0;
         while(_loc2_ < rewardInfos.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,rewardInfos[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:LoginRewardInfoMsg = null;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: LoginActiveMsg.loginCount cannot be set twice.");
                  }
                  _loc7_++;
                  loginCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: LoginActiveMsg.beginTm cannot be set twice.");
                  }
                  _loc3_++;
                  beginTm = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: LoginActiveMsg.endTm cannot be set twice.");
                  }
                  _loc6_++;
                  endTm = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  _loc4_ = new LoginRewardInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  rewardInfos.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

