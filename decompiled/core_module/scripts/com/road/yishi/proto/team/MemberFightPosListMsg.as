package com.road.yishi.proto.team
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MemberFightPosListMsg extends Message implements IExternalizable
   {
      
      private var is_get$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.team.MemberFightPos")]
      public var memberPos:Array = [];
      
      private var serverName$field:String;
      
      public function MemberFightPosListMsg()
      {
         super();
      }
      
      public function removeIsGet() : void
      {
         hasField$0 &= 4294967294;
         is_get$field = new Boolean();
      }
      
      public function get hasIsGet() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set isGet(param1:Boolean) : void
      {
         hasField$0 |= 1;
         is_get$field = param1;
      }
      
      public function get isGet() : Boolean
      {
         return is_get$field;
      }
      
      public function removeServerName() : void
      {
         serverName$field = null;
      }
      
      public function get hasServerName() : Boolean
      {
         return serverName$field != null;
      }
      
      public function set serverName(param1:String) : void
      {
         serverName$field = param1;
      }
      
      public function get serverName() : String
      {
         return serverName$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasIsGet)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_BOOL(param1,is_get$field);
         }
         _loc2_ = 0;
         while(_loc2_ < memberPos.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,memberPos[_loc2_]);
            _loc2_++;
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,serverName$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:MemberFightPos = null;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MemberFightPosListMsg.isGet cannot be set twice.");
                  }
                  _loc6_++;
                  isGet = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 1:
                  _loc4_ = new MemberFightPos();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  memberPos.push(_loc4_);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MemberFightPosListMsg.serverName cannot be set twice.");
                  }
                  _loc3_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

