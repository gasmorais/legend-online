package com.road.yishi.proto.consortia
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaDutyInfoMsg extends Message implements IExternalizable
   {
      
      private var levels$field:int;
      
      private var hasField$0:uint = 0;
      
      private var duty_name$field:String;
      
      private var rights$field:ByteArray;
      
      private var rightsStr$field:String;
      
      public function ConsortiaDutyInfoMsg()
      {
         super();
      }
      
      public function removeLevels() : void
      {
         hasField$0 &= 4294967294;
         levels$field = new int();
      }
      
      public function get hasLevels() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set levels(param1:int) : void
      {
         hasField$0 |= 1;
         levels$field = param1;
      }
      
      public function get levels() : int
      {
         return levels$field;
      }
      
      public function removeDutyName() : void
      {
         duty_name$field = null;
      }
      
      public function get hasDutyName() : Boolean
      {
         return duty_name$field != null;
      }
      
      public function set dutyName(param1:String) : void
      {
         duty_name$field = param1;
      }
      
      public function get dutyName() : String
      {
         return duty_name$field;
      }
      
      public function removeRights() : void
      {
         rights$field = null;
      }
      
      public function get hasRights() : Boolean
      {
         return rights$field != null;
      }
      
      public function set rights(param1:ByteArray) : void
      {
         rights$field = param1;
      }
      
      public function get rights() : ByteArray
      {
         return rights$field;
      }
      
      public function removeRightsStr() : void
      {
         rightsStr$field = null;
      }
      
      public function get hasRightsStr() : Boolean
      {
         return rightsStr$field != null;
      }
      
      public function set rightsStr(param1:String) : void
      {
         rightsStr$field = param1;
      }
      
      public function get rightsStr() : String
      {
         return rightsStr$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasLevels)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,levels$field);
         }
         if(hasDutyName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,duty_name$field);
         }
         if(hasRights)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_BYTES(param1,rights$field);
         }
         if(hasRightsStr)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,rightsStr$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaDutyInfoMsg.levels cannot be set twice.");
                  }
                  _loc6_++;
                  levels = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaDutyInfoMsg.dutyName cannot be set twice.");
                  }
                  _loc3_++;
                  dutyName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaDutyInfoMsg.rights cannot be set twice.");
                  }
                  _loc7_++;
                  rights = ReadUtils.read$TYPE_BYTES(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaDutyInfoMsg.rightsStr cannot be set twice.");
                  }
                  _loc4_++;
                  rightsStr = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

