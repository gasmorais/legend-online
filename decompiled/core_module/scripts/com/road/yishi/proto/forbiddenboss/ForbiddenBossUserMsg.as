package com.road.yishi.proto.forbiddenboss
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ForbiddenBossUserMsg extends Message implements IExternalizable
   {
      
      private var belongReward$field:String;
      
      private var joinReward$field:String;
      
      private var firstReward$field:String;
      
      private var needVerify$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var consortiaName$field:String;
      
      public function ForbiddenBossUserMsg()
      {
         super();
      }
      
      public function removeBelongReward() : void
      {
         belongReward$field = null;
      }
      
      public function get hasBelongReward() : Boolean
      {
         return belongReward$field != null;
      }
      
      public function set belongReward(param1:String) : void
      {
         belongReward$field = param1;
      }
      
      public function get belongReward() : String
      {
         return belongReward$field;
      }
      
      public function removeJoinReward() : void
      {
         joinReward$field = null;
      }
      
      public function get hasJoinReward() : Boolean
      {
         return joinReward$field != null;
      }
      
      public function set joinReward(param1:String) : void
      {
         joinReward$field = param1;
      }
      
      public function get joinReward() : String
      {
         return joinReward$field;
      }
      
      public function removeFirstReward() : void
      {
         firstReward$field = null;
      }
      
      public function get hasFirstReward() : Boolean
      {
         return firstReward$field != null;
      }
      
      public function set firstReward(param1:String) : void
      {
         firstReward$field = param1;
      }
      
      public function get firstReward() : String
      {
         return firstReward$field;
      }
      
      public function removeNeedVerify() : void
      {
         hasField$0 &= 4294967294;
         needVerify$field = new Boolean();
      }
      
      public function get hasNeedVerify() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set needVerify(param1:Boolean) : void
      {
         hasField$0 |= 1;
         needVerify$field = param1;
      }
      
      public function get needVerify() : Boolean
      {
         return needVerify$field;
      }
      
      public function removeConsortiaName() : void
      {
         consortiaName$field = null;
      }
      
      public function get hasConsortiaName() : Boolean
      {
         return consortiaName$field != null;
      }
      
      public function set consortiaName(param1:String) : void
      {
         consortiaName$field = param1;
      }
      
      public function get consortiaName() : String
      {
         return consortiaName$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasBelongReward)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,belongReward$field);
         }
         if(hasJoinReward)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,joinReward$field);
         }
         if(hasFirstReward)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,firstReward$field);
         }
         if(hasNeedVerify)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,needVerify$field);
         }
         if(hasConsortiaName)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,consortiaName$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ForbiddenBossUserMsg.belongReward cannot be set twice.");
                  }
                  _loc5_++;
                  belongReward = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ForbiddenBossUserMsg.joinReward cannot be set twice.");
                  }
                  _loc8_++;
                  joinReward = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ForbiddenBossUserMsg.firstReward cannot be set twice.");
                  }
                  _loc7_++;
                  firstReward = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ForbiddenBossUserMsg.needVerify cannot be set twice.");
                  }
                  _loc3_++;
                  needVerify = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ForbiddenBossUserMsg.consortiaName cannot be set twice.");
                  }
                  _loc4_++;
                  consortiaName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

