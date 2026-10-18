package com.road.yishi.proto.player
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlayerAASRspMsg extends Message implements IExternalizable
   {
      
      private var result$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var age$field:int;
      
      private var card_id$field:String;
      
      public function PlayerAASRspMsg()
      {
         super();
      }
      
      public function removeResult() : void
      {
         hasField$0 &= 4294967294;
         result$field = new Boolean();
      }
      
      public function get hasResult() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set result(param1:Boolean) : void
      {
         hasField$0 |= 1;
         result$field = param1;
      }
      
      public function get result() : Boolean
      {
         return result$field;
      }
      
      public function removeAge() : void
      {
         hasField$0 &= 4294967293;
         age$field = new int();
      }
      
      public function get hasAge() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set age(param1:int) : void
      {
         hasField$0 |= 2;
         age$field = param1;
      }
      
      public function get age() : int
      {
         return age$field;
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
         if(hasResult)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_BOOL(param1,result$field);
         }
         if(hasAge)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,age$field);
         }
         if(hasCardId)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,card_id$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerAASRspMsg.result cannot be set twice.");
                  }
                  _loc4_++;
                  result = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerAASRspMsg.age cannot be set twice.");
                  }
                  _loc3_++;
                  age = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerAASRspMsg.cardId cannot be set twice.");
                  }
                  _loc6_++;
                  cardId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

