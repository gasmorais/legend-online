package com.road.yishi.proto.player
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlayerAASReqMsg extends Message implements IExternalizable
   {
      
      private var card_name$field:String;
      
      private var card_id$field:String;
      
      public function PlayerAASReqMsg()
      {
         super();
      }
      
      public function removeCardName() : void
      {
         card_name$field = null;
      }
      
      public function get hasCardName() : Boolean
      {
         return card_name$field != null;
      }
      
      public function set cardName(param1:String) : void
      {
         card_name$field = param1;
      }
      
      public function get cardName() : String
      {
         return card_name$field;
      }
      
      public function removeCardId() : void
      {
         card_id$field = null;
      }
      
      public function get hasCardId() : Boolean
      {
         return card_id$field != null;
      }
      
      public function set cardId(param1:String) : void
      {
         card_id$field = param1;
      }
      
      public function get cardId() : String
      {
         return card_id$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasCardName)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,card_name$field);
         }
         if(hasCardId)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,card_id$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerAASReqMsg.cardName cannot be set twice.");
                  }
                  _loc3_++;
                  cardName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerAASReqMsg.cardId cannot be set twice.");
                  }
                  _loc5_++;
                  cardId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

