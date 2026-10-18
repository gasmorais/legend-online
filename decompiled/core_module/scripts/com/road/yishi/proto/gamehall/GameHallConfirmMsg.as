package com.road.yishi.proto.gamehall
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GameHallConfirmMsg extends Message implements IExternalizable
   {
      
      private var gameId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var difficulty$field:int;
      
      private var sender$field:String;
      
      private var attachment$field:String;
      
      public function GameHallConfirmMsg()
      {
         super();
      }
      
      public function removeGameId() : void
      {
         hasField$0 &= 4294967294;
         gameId$field = new int();
      }
      
      public function get hasGameId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set gameId(param1:int) : void
      {
         hasField$0 |= 1;
         gameId$field = param1;
      }
      
      public function get gameId() : int
      {
         return gameId$field;
      }
      
      public function removeDifficulty() : void
      {
         hasField$0 &= 4294967293;
         difficulty$field = new int();
      }
      
      public function get hasDifficulty() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set difficulty(param1:int) : void
      {
         hasField$0 |= 2;
         difficulty$field = param1;
      }
      
      public function get difficulty() : int
      {
         return difficulty$field;
      }
      
      public function removeSender() : void
      {
         sender$field = null;
      }
      
      public function get hasSender() : Boolean
      {
         return sender$field != null;
      }
      
      public function set sender(param1:String) : void
      {
         sender$field = param1;
      }
      
      public function get sender() : String
      {
         return sender$field;
      }
      
      public function removeAttachment() : void
      {
         attachment$field = null;
      }
      
      public function get hasAttachment() : Boolean
      {
         return attachment$field != null;
      }
      
      public function set attachment(param1:String) : void
      {
         attachment$field = param1;
      }
      
      public function get attachment() : String
      {
         return attachment$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasGameId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,gameId$field);
         }
         if(hasDifficulty)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,difficulty$field);
         }
         if(hasSender)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,sender$field);
         }
         if(hasAttachment)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,attachment$field);
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
                     throw new IOError("Bad data format: GameHallConfirmMsg.gameId cannot be set twice.");
                  }
                  _loc4_++;
                  gameId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: GameHallConfirmMsg.difficulty cannot be set twice.");
                  }
                  _loc7_++;
                  difficulty = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GameHallConfirmMsg.sender cannot be set twice.");
                  }
                  _loc3_++;
                  sender = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: GameHallConfirmMsg.attachment cannot be set twice.");
                  }
                  _loc6_++;
                  attachment = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

