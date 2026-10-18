package com.road.yishi.proto.pet
{
   import com.netease.protobuf.Int64;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PokerPlayerMsg extends Message implements IExternalizable
   {
      
      private var user_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var user_name$field:String;
      
      private var server_name$field:String;
      
      private var cash$field:int;
      
      private var score$field:int;
      
      private var state$field:int;
      
      private var head_id$field:int;
      
      private var last_play_time$field:Int64;
      
      public function PokerPlayerMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
      }
      
      public function removeUserName() : void
      {
         user_name$field = null;
      }
      
      public function get hasUserName() : Boolean
      {
         return user_name$field != null;
      }
      
      public function set userName(param1:String) : void
      {
         user_name$field = param1;
      }
      
      public function get userName() : String
      {
         return user_name$field;
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
      
      public function removeCash() : void
      {
         hasField$0 &= 4294967293;
         cash$field = new int();
      }
      
      public function get hasCash() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set cash(param1:int) : void
      {
         hasField$0 |= 2;
         cash$field = param1;
      }
      
      public function get cash() : int
      {
         return cash$field;
      }
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967291;
         score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 4;
         score$field = param1;
      }
      
      public function get score() : int
      {
         return score$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967287;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 8;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeHeadId() : void
      {
         hasField$0 &= 4294967279;
         head_id$field = new int();
      }
      
      public function get hasHeadId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set headId(param1:int) : void
      {
         hasField$0 |= 16;
         head_id$field = param1;
      }
      
      public function get headId() : int
      {
         return head_id$field;
      }
      
      public function removeLastPlayTime() : void
      {
         last_play_time$field = null;
      }
      
      public function get hasLastPlayTime() : Boolean
      {
         return last_play_time$field != null;
      }
      
      public function set lastPlayTime(param1:Int64) : void
      {
         last_play_time$field = param1;
      }
      
      public function get lastPlayTime() : Int64
      {
         return last_play_time$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasUserName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,user_name$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
         if(hasCash)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,cash$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_ENUM(param1,state$field);
         }
         if(hasHeadId)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,head_id$field);
         }
         if(hasLastPlayTime)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT64(param1,last_play_time$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         var _loc4_:uint = 0;
         var _loc11_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PokerPlayerMsg.userId cannot be set twice.");
                  }
                  _loc5_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PokerPlayerMsg.userName cannot be set twice.");
                  }
                  _loc3_++;
                  userName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PokerPlayerMsg.serverName cannot be set twice.");
                  }
                  _loc9_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PokerPlayerMsg.cash cannot be set twice.");
                  }
                  _loc4_++;
                  cash = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: PokerPlayerMsg.score cannot be set twice.");
                  }
                  _loc11_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PokerPlayerMsg.state cannot be set twice.");
                  }
                  _loc6_++;
                  state = ReadUtils.read$TYPE_ENUM(param1);
                  break;
               case 8:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PokerPlayerMsg.headId cannot be set twice.");
                  }
                  _loc7_++;
                  headId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PokerPlayerMsg.lastPlayTime cannot be set twice.");
                  }
                  _loc10_++;
                  lastPlayTime = ReadUtils.read$TYPE_INT64(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

