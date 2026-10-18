package com.road.yishi.proto.battle
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class UpdateBattleIdMsg extends Message implements IExternalizable
   {
      
      private var battleId$field:String;
      
      private var proxyId$field:String;
      
      public function UpdateBattleIdMsg()
      {
         super();
      }
      
      public function removeBattleId() : void
      {
         battleId$field = null;
      }
      
      public function get hasBattleId() : Boolean
      {
         return battleId$field != null;
      }
      
      public function set battleId(param1:String) : void
      {
         battleId$field = param1;
      }
      
      public function get battleId() : String
      {
         return battleId$field;
      }
      
      public function removeProxyId() : void
      {
         proxyId$field = null;
      }
      
      public function get hasProxyId() : Boolean
      {
         return proxyId$field != null;
      }
      
      public function set proxyId(param1:String) : void
      {
         proxyId$field = param1;
      }
      
      public function get proxyId() : String
      {
         return proxyId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasBattleId)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,battleId$field);
         }
         if(hasProxyId)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,proxyId$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc3_:* = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc3_ = ReadUtils.read$TYPE_UINT32(param1);
            switch((_loc3_ >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: UpdateBattleIdMsg.battleId cannot be set twice.");
                  }
                  _loc4_++;
                  battleId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: UpdateBattleIdMsg.proxyId cannot be set twice.");
                  }
                  _loc5_++;
                  proxyId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc3_ & 7);
            }
         }
      }
   }
}

