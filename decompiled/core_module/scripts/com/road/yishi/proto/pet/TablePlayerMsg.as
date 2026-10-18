package com.road.yishi.proto.pet
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TablePlayerMsg extends Message implements IExternalizable
   {
      
      private var user_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var user_name$field:String;
      
      private var server_name$field:String;
      
      private var cash$field:int;
      
      private var bet$field:int;
      
      private var action$field:int;
      
      private var has_card$field:Boolean;
      
      [ArrayElementType("com.road.yishi.proto.pet.CardMsg")]
      public var card:Array = [];
      
      private var hand_type$field:int;
      
      private var head_id$field:int;
      
      private var hand_value$field:int;
      
      [ArrayElementType("int")]
      public var ranking:Array = [];
      
      public function TablePlayerMsg()
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
      
      public function removeBet() : void
      {
         hasField$0 &= 4294967291;
         bet$field = new int();
      }
      
      public function get hasBet() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set bet(param1:int) : void
      {
         hasField$0 |= 4;
         bet$field = param1;
      }
      
      public function get bet() : int
      {
         return bet$field;
      }
      
      public function removeAction() : void
      {
         hasField$0 &= 4294967287;
         action$field = new int();
      }
      
      public function get hasAction() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set action(param1:int) : void
      {
         hasField$0 |= 8;
         action$field = param1;
      }
      
      public function get action() : int
      {
         return action$field;
      }
      
      public function removeHasCard() : void
      {
         hasField$0 &= 4294967279;
         has_card$field = new Boolean();
      }
      
      public function get hasHasCard() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set hasCard(param1:Boolean) : void
      {
         hasField$0 |= 16;
         has_card$field = param1;
      }
      
      public function get hasCard() : Boolean
      {
         return has_card$field;
      }
      
      public function removeHandType() : void
      {
         hasField$0 &= 4294967263;
         hand_type$field = new int();
      }
      
      public function get hasHandType() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set handType(param1:int) : void
      {
         hasField$0 |= 32;
         hand_type$field = param1;
      }
      
      public function get handType() : int
      {
         return hand_type$field;
      }
      
      public function removeHeadId() : void
      {
         hasField$0 &= 4294967231;
         head_id$field = new int();
      }
      
      public function get hasHeadId() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set headId(param1:int) : void
      {
         hasField$0 |= 64;
         head_id$field = param1;
      }
      
      public function get headId() : int
      {
         return head_id$field;
      }
      
      public function removeHandValue() : void
      {
         hasField$0 &= 4294967167;
         hand_value$field = new int();
      }
      
      public function get hasHandValue() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set handValue(param1:int) : void
      {
         hasField$0 |= 128;
         hand_value$field = param1;
      }
      
      public function get handValue() : int
      {
         return hand_value$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
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
         if(hasBet)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,bet$field);
         }
         if(hasAction)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_ENUM(param1,action$field);
         }
         if(hasHasCard)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_BOOL(param1,has_card$field);
         }
         _loc3_ = 0;
         while(_loc3_ < card.length)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_MESSAGE(param1,card[_loc3_]);
            _loc3_++;
         }
         if(hasHandType)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,hand_type$field);
         }
         if(hasHeadId)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,head_id$field);
         }
         if(hasHandValue)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,hand_value$field);
         }
         _loc2_ = 0;
         while(_loc2_ < ranking.length)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,ranking[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc11_:* = 0;
         var _loc14_:CardMsg = null;
         var _loc10_:uint = 0;
         var _loc9_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc12_:uint = 0;
         var _loc4_:uint = 0;
         var _loc13_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc11_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: TablePlayerMsg.userId cannot be set twice.");
                  }
                  _loc10_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: TablePlayerMsg.userName cannot be set twice.");
                  }
                  _loc9_++;
                  userName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: TablePlayerMsg.serverName cannot be set twice.");
                  }
                  _loc6_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TablePlayerMsg.cash cannot be set twice.");
                  }
                  _loc3_++;
                  cash = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: TablePlayerMsg.bet cannot be set twice.");
                  }
                  _loc7_++;
                  bet = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: TablePlayerMsg.action cannot be set twice.");
                  }
                  _loc12_++;
                  action = ReadUtils.read$TYPE_ENUM(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TablePlayerMsg.hasCard cannot be set twice.");
                  }
                  _loc4_++;
                  hasCard = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 7:
                  _loc14_ = new CardMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc14_);
                  card.push(_loc14_);
                  break;
               case 8:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: TablePlayerMsg.handType cannot be set twice.");
                  }
                  _loc13_++;
                  handType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TablePlayerMsg.headId cannot be set twice.");
                  }
                  _loc5_++;
                  headId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: TablePlayerMsg.handValue cannot be set twice.");
                  }
                  _loc8_++;
                  handValue = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if((_loc11_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,ranking);
                  }
                  else
                  {
                     ranking.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               default:
                  ReadUtils.skip(param1,_loc11_ & 7);
            }
         }
      }
   }
}

