package com.road.yishi.proto.privilege
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PrivilegeMsg extends Message implements IExternalizable
   {
      
      private var is_privilege$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("int")]
      public var list:Array = [];
      
      private var user_name$field:String;
      
      private var index$field:int;
      
      private var param1$field:String;
      
      private var param2$field:String;
      
      public function PrivilegeMsg()
      {
         super();
      }
      
      public function removeIsPrivilege() : void
      {
         hasField$0 &= 4294967294;
         is_privilege$field = new Boolean();
      }
      
      public function get hasIsPrivilege() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set isPrivilege(param1:Boolean) : void
      {
         hasField$0 |= 1;
         is_privilege$field = param1;
      }
      
      public function get isPrivilege() : Boolean
      {
         return is_privilege$field;
      }
      
      public function removeUserName() : void
      {
         user_name$field = null;
      }
      
      public function get hasUserName() : Boolean
      {
         return user_name$field != null;
      }
      
      public function set userName(param1:String) : void
      {
         user_name$field = param1;
      }
      
      public function get userName() : String
      {
         return user_name$field;
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
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasIsPrivilege)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_BOOL(param1,is_privilege$field);
         }
         _loc2_ = 0;
         while(_loc2_ < list.length)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,list[_loc2_]);
            _loc2_++;
         }
         if(hasUserName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,user_name$field);
         }
         if(hasIndex)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,index$field);
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
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PrivilegeMsg.isPrivilege cannot be set twice.");
                  }
                  _loc3_++;
                  isPrivilege = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 1:
                  if((_loc7_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,list);
                  }
                  else
                  {
                     list.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PrivilegeMsg.userName cannot be set twice.");
                  }
                  _loc5_++;
                  userName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PrivilegeMsg.index cannot be set twice.");
                  }
                  _loc4_++;
                  index = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PrivilegeMsg.param1 cannot be set twice.");
                  }
                  _loc6_++;
                  param1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PrivilegeMsg.param2 cannot be set twice.");
                  }
                  _loc8_++;
                  param2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

