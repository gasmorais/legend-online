package com.road.yishi.proto.gameplot
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlotInfoMsg extends Message implements IExternalizable
   {
      
      private var index$field:int;
      
      private var hasField$0:uint = 0;
      
      private var direction$field:int;
      
      private var role_id$field:int;
      
      private var role_name$field:String;
      
      private var event$field:String;
      
      private var param$field:String;
      
      private var text$field:String;
      
      private var delayTime$field:int;
      
      public function PlotInfoMsg()
      {
         super();
      }
      
      public function removeIndex() : void
      {
         hasField$0 &= 4294967294;
         index$field = new int();
      }
      
      public function get hasIndex() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set index(param1:int) : void
      {
         hasField$0 |= 1;
         index$field = param1;
      }
      
      public function get index() : int
      {
         return index$field;
      }
      
      public function removeDirection() : void
      {
         hasField$0 &= 4294967293;
         direction$field = new int();
      }
      
      public function get hasDirection() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set direction(param1:int) : void
      {
         hasField$0 |= 2;
         direction$field = param1;
      }
      
      public function get direction() : int
      {
         return direction$field;
      }
      
      public function removeRoleId() : void
      {
         hasField$0 &= 4294967291;
         role_id$field = new int();
      }
      
      public function get hasRoleId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set roleId(param1:int) : void
      {
         hasField$0 |= 4;
         role_id$field = param1;
      }
      
      public function get roleId() : int
      {
         return role_id$field;
      }
      
      public function removeRoleName() : void
      {
         role_name$field = null;
      }
      
      public function get hasRoleName() : Boolean
      {
         return role_name$field != null;
      }
      
      public function set roleName(param1:String) : void
      {
         role_name$field = param1;
      }
      
      public function get roleName() : String
      {
         return role_name$field;
      }
      
      public function removeEvent() : void
      {
         event$field = null;
      }
      
      public function get hasEvent() : Boolean
      {
         return event$field != null;
      }
      
      public function set event(param1:String) : void
      {
         event$field = param1;
      }
      
      public function get event() : String
      {
         return event$field;
      }
      
      public function removeParam() : void
      {
         param$field = null;
      }
      
      public function get hasParam() : Boolean
      {
         return param$field != null;
      }
      
      public function set param(param1:String) : void
      {
         param$field = param1;
      }
      
      public function get param() : String
      {
         return param$field;
      }
      
      public function removeText() : void
      {
         text$field = null;
      }
      
      public function get hasText() : Boolean
      {
         return text$field != null;
      }
      
      public function set text(param1:String) : void
      {
         text$field = param1;
      }
      
      public function get text() : String
      {
         return text$field;
      }
      
      public function removeDelayTime() : void
      {
         hasField$0 &= 4294967287;
         delayTime$field = new int();
      }
      
      public function get hasDelayTime() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set delayTime(param1:int) : void
      {
         hasField$0 |= 8;
         delayTime$field = param1;
      }
      
      public function get delayTime() : int
      {
         return delayTime$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasIndex)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,index$field);
         }
         if(hasDirection)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,direction$field);
         }
         if(hasRoleId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,role_id$field);
         }
         if(hasRoleName)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,role_name$field);
         }
         if(hasEvent)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,event$field);
         }
         if(hasParam)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,param$field);
         }
         if(hasText)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,text$field);
         }
         if(hasDelayTime)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,delayTime$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc11_:uint = 0;
         var _loc9_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PlotInfoMsg.index cannot be set twice.");
                  }
                  _loc5_++;
                  index = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PlotInfoMsg.direction cannot be set twice.");
                  }
                  _loc3_++;
                  direction = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PlotInfoMsg.roleId cannot be set twice.");
                  }
                  _loc8_++;
                  roleId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: PlotInfoMsg.roleName cannot be set twice.");
                  }
                  _loc11_++;
                  roleName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PlotInfoMsg.event cannot be set twice.");
                  }
                  _loc9_++;
                  event = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PlotInfoMsg.param cannot be set twice.");
                  }
                  _loc6_++;
                  param = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PlotInfoMsg.text cannot be set twice.");
                  }
                  _loc7_++;
                  text = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PlotInfoMsg.delayTime cannot be set twice.");
                  }
                  _loc4_++;
                  delayTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

