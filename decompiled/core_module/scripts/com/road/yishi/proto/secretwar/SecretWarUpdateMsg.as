package com.road.yishi.proto.secretwar
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SecretWarUpdateMsg extends Message implements IExternalizable
   {
      
      private var info$field:SecretWarInfoMsg;
      
      [ArrayElementType("com.road.yishi.proto.secretwar.SecretWarNodeMsg")]
      public var nodes:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.secretwar.SecretWarPlayerMsg")]
      public var players:Array = [];
      
      public function SecretWarUpdateMsg()
      {
         super();
      }
      
      public function removeInfo() : void
      {
         info$field = null;
      }
      
      public function get hasInfo() : Boolean
      {
         return info$field != null;
      }
      
      public function set info(param1:SecretWarInfoMsg) : void
      {
         info$field = param1;
      }
      
      public function get info() : SecretWarInfoMsg
      {
         return info$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(hasInfo)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,info$field);
         }
         _loc3_ = 0;
         while(_loc3_ < nodes.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,nodes[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < players.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,players[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:SecretWarNodeMsg = null;
         var _loc6_:SecretWarPlayerMsg = null;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarUpdateMsg.info cannot be set twice.");
                  }
                  _loc3_++;
                  info = new SecretWarInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,info);
                  break;
               case 1:
                  _loc4_ = new SecretWarNodeMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  nodes.push(_loc4_);
                  break;
               case 2:
                  _loc6_ = new SecretWarPlayerMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  players.push(_loc6_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

