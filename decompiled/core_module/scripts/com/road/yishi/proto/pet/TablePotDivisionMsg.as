package com.road.yishi.proto.pet
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TablePotDivisionMsg extends Message implements IExternalizable
   {
      
      private var player$field:TablePlayerMsg;
      
      private var pot_share$field:int;
      
      private var hasField$0:uint = 0;
      
      public var handType:int;
      
      public var handValue:int;
      
      public var rankingArr:Array = [];
      
      private var commission$field:int;
      
      private var score$field:int;
      
      private var invalid_share$field:int;
      
      public function TablePotDivisionMsg()
      {
         super();
      }
      
      public function removePlayer() : void
      {
         player$field = null;
      }
      
      public function get hasPlayer() : Boolean
      {
         return player$field != null;
      }
      
      public function set player(param1:TablePlayerMsg) : void
      {
         player$field = param1;
      }
      
      public function get player() : TablePlayerMsg
      {
         return player$field;
      }
      
      public function removePotShare() : void
      {
         hasField$0 &= 4294967294;
         pot_share$field = new int();
      }
      
      public function get hasPotShare() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set potShare(param1:int) : void
      {
         hasField$0 |= 1;
         pot_share$field = param1;
      }
      
      public function get potShare() : int
      {
         return pot_share$field;
      }
      
      public function removeCommission() : void
      {
         hasField$0 &= 4294967293;
         commission$field = new int();
      }
      
      public function get hasCommission() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set commission(param1:int) : void
      {
         hasField$0 |= 2;
         commission$field = param1;
      }
      
      public function get commission() : int
      {
         return commission$field;
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
      
      public function removeInvalidShare() : void
      {
         hasField$0 &= 4294967287;
         invalid_share$field = new int();
      }
      
      public function get hasInvalidShare() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set invalidShare(param1:int) : void
      {
         hasField$0 |= 8;
         invalid_share$field = param1;
      }
      
      public function get invalidShare() : int
      {
         return invalid_share$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasPlayer)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,player$field);
         }
         if(hasPotShare)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,pot_share$field);
         }
         if(hasCommission)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,commission$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasInvalidShare)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,invalid_share$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: TablePotDivisionMsg.player cannot be set twice.");
                  }
                  _loc8_++;
                  player = new TablePlayerMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,player);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TablePotDivisionMsg.potShare cannot be set twice.");
                  }
                  _loc4_++;
                  potShare = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TablePotDivisionMsg.commission cannot be set twice.");
                  }
                  _loc3_++;
                  commission = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: TablePotDivisionMsg.score cannot be set twice.");
                  }
                  _loc7_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TablePotDivisionMsg.invalidShare cannot be set twice.");
                  }
                  _loc5_++;
                  invalidShare = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

