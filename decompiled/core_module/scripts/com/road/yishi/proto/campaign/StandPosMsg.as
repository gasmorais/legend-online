package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class StandPosMsg extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var pos_x$field:int;
      
      private var pos_y$field:int;
      
      private var server_name$field:String;
      
      public function StandPosMsg()
      {
         super();
      }
      
      public function removeId() : void
      {
         hasField$0 &= 4294967294;
         id$field = new int();
      }
      
      public function get hasId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set id(param1:int) : void
      {
         hasField$0 |= 1;
         id$field = param1;
      }
      
      public function get id() : int
      {
         return id$field;
      }
      
      public function removePosX() : void
      {
         hasField$0 &= 4294967293;
         pos_x$field = new int();
      }
      
      public function get hasPosX() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set posX(param1:int) : void
      {
         hasField$0 |= 2;
         pos_x$field = param1;
      }
      
      public function get posX() : int
      {
         return pos_x$field;
      }
      
      public function removePosY() : void
      {
         hasField$0 &= 4294967291;
         pos_y$field = new int();
      }
      
      public function get hasPosY() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set posY(param1:int) : void
      {
         hasField$0 |= 4;
         pos_y$field = param1;
      }
      
      public function get posY() : int
      {
         return pos_y$field;
      }
      
      public function removeServerName() : void
      {
         server_name$field = null;
      }
      
      public function get hasServerName() : Boolean
      {
         return server_name$field != null;
      }
      
      public function set serverName(param1:String) : void
      {
         server_name$field = param1;
      }
      
      public function get serverName() : String
      {
         return server_name$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         if(hasPosX)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,pos_x$field);
         }
         if(hasPosY)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,pos_y$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: StandPosMsg.id cannot be set twice.");
                  }
                  _loc4_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: StandPosMsg.posX cannot be set twice.");
                  }
                  _loc7_++;
                  posX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: StandPosMsg.posY cannot be set twice.");
                  }
                  _loc3_++;
                  posY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: StandPosMsg.serverName cannot be set twice.");
                  }
                  _loc6_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

