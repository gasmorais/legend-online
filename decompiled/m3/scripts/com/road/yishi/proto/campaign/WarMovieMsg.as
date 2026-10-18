package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class WarMovieMsg extends Message implements IExternalizable
   {
      
      private var score$field:int;
      
      private var hasField$0:uint = 0;
      
      private var geste$field:int;
      
      private var is_add$field:Boolean;
      
      private var user_id$field:int;
      
      private var type$field:int;
      
      private var server_name$field:String;
      
      public function WarMovieMsg()
      {
         super();
      }
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967294;
         score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 1;
         score$field = param1;
      }
      
      public function get score() : int
      {
         return score$field;
      }
      
      public function removeGeste() : void
      {
         hasField$0 &= 4294967293;
         geste$field = new int();
      }
      
      public function get hasGeste() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set geste(param1:int) : void
      {
         hasField$0 |= 2;
         geste$field = param1;
      }
      
      public function get geste() : int
      {
         return geste$field;
      }
      
      public function removeIsAdd() : void
      {
         hasField$0 &= 4294967291;
         is_add$field = new Boolean();
      }
      
      public function get hasIsAdd() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set isAdd(param1:Boolean) : void
      {
         hasField$0 |= 4;
         is_add$field = param1;
      }
      
      public function get isAdd() : Boolean
      {
         return is_add$field;
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967287;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 8;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967279;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 16;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
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
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasGeste)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,geste$field);
         }
         if(hasIsAdd)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,is_add$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = uint(ReadUtils.read$TYPE_UINT32(param1))) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: WarMovieMsg.score cannot be set twice.");
                  }
                  _loc8_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: WarMovieMsg.geste cannot be set twice.");
                  }
                  _loc9_++;
                  geste = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: WarMovieMsg.isAdd cannot be set twice.");
                  }
                  _loc3_++;
                  isAdd = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: WarMovieMsg.userId cannot be set twice.");
                  }
                  _loc4_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: WarMovieMsg.type cannot be set twice.");
                  }
                  _loc5_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: WarMovieMsg.serverName cannot be set twice.");
                  }
                  _loc7_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

