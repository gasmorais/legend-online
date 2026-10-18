package com.road.yishi.proto.secretwar
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SecretWarCreateMsg extends Message implements IExternalizable
   {
      
      private var info$field:SecretWarInfoMsg;
      
      private var self$field:SecretWarSelfMsg;
      
      [ArrayElementType("com.road.yishi.proto.secretwar.SecretWarNodeMsg")]
      public var nodes:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.secretwar.SecretWarPlayerMsg")]
      public var players:Array = [];
      
      public function SecretWarCreateMsg()
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
      
      public function removeSelf() : void
      {
         self$field = null;
      }
      
      public function get hasSelf() : Boolean
      {
         return self$field != null;
      }
      
      public function set self(param1:SecretWarSelfMsg) : void
      {
         self$field = param1;
      }
      
      public function get self() : SecretWarSelfMsg
      {
         return self$field;
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
         if(hasSelf)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,self$field);
         }
         _loc3_ = 0;
         while(_loc3_ < nodes.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,nodes[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < players.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,players[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:SecretWarNodeMsg = null;
         var _loc7_:SecretWarPlayerMsg = null;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarCreateMsg.info cannot be set twice.");
                  }
                  _loc3_++;
                  info = new SecretWarInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,info);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarCreateMsg.self cannot be set twice.");
                  }
                  _loc5_++;
                  self = new SecretWarSelfMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,self);
                  break;
               case 2:
                  _loc4_ = new SecretWarNodeMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  nodes.push(_loc4_);
                  break;
               case 3:
                  _loc7_ = new SecretWarPlayerMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  players.push(_loc7_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

