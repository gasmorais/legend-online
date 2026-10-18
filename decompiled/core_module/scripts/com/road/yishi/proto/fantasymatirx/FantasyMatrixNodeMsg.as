package com.road.yishi.proto.fantasymatirx
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class FantasyMatrixNodeMsg extends Message implements IExternalizable
   {
      
      private var pos_x$field:int;
      
      private var hasField$0:uint = 0;
      
      private var pos_y$field:int;
      
      private var pawn_level$field:int;
      
      private var pawn_temp_id$field:int;
      
      private var show_box$field:Boolean;
      
      private var show_skill$field:int;
      
      private var fighting$field:Boolean;
      
      private var state$field:int;
      
      private var pawn_sontype$field:int;
      
      public function FantasyMatrixNodeMsg()
      {
         super();
      }
      
      public function removePosX() : void
      {
         hasField$0 &= 4294967294;
         pos_x$field = new int();
      }
      
      public function get hasPosX() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set posX(param1:int) : void
      {
         hasField$0 |= 1;
         pos_x$field = param1;
      }
      
      public function get posX() : int
      {
         return pos_x$field;
      }
      
      public function removePosY() : void
      {
         hasField$0 &= 4294967293;
         pos_y$field = new int();
      }
      
      public function get hasPosY() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set posY(param1:int) : void
      {
         hasField$0 |= 2;
         pos_y$field = param1;
      }
      
      public function get posY() : int
      {
         return pos_y$field;
      }
      
      public function removePawnLevel() : void
      {
         hasField$0 &= 4294967291;
         pawn_level$field = new int();
      }
      
      public function get hasPawnLevel() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set pawnLevel(param1:int) : void
      {
         hasField$0 |= 4;
         pawn_level$field = param1;
      }
      
      public function get pawnLevel() : int
      {
         return pawn_level$field;
      }
      
      public function removePawnTempId() : void
      {
         hasField$0 &= 4294967287;
         pawn_temp_id$field = new int();
      }
      
      public function get hasPawnTempId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set pawnTempId(param1:int) : void
      {
         hasField$0 |= 8;
         pawn_temp_id$field = param1;
      }
      
      public function get pawnTempId() : int
      {
         return pawn_temp_id$field;
      }
      
      public function removeShowBox() : void
      {
         hasField$0 &= 4294967279;
         show_box$field = new Boolean();
      }
      
      public function get hasShowBox() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set showBox(param1:Boolean) : void
      {
         hasField$0 |= 16;
         show_box$field = param1;
      }
      
      public function get showBox() : Boolean
      {
         return show_box$field;
      }
      
      public function removeShowSkill() : void
      {
         hasField$0 &= 4294967263;
         show_skill$field = new int();
      }
      
      public function get hasShowSkill() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set showSkill(param1:int) : void
      {
         hasField$0 |= 32;
         show_skill$field = param1;
      }
      
      public function get showSkill() : int
      {
         return show_skill$field;
      }
      
      public function removeFighting() : void
      {
         hasField$0 &= 4294967231;
         fighting$field = new Boolean();
      }
      
      public function get hasFighting() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set fighting(param1:Boolean) : void
      {
         hasField$0 |= 64;
         fighting$field = param1;
      }
      
      public function get fighting() : Boolean
      {
         return fighting$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967167;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 128;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removePawnSontype() : void
      {
         hasField$0 &= 4294967039;
         pawn_sontype$field = new int();
      }
      
      public function get hasPawnSontype() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set pawnSontype(param1:int) : void
      {
         hasField$0 |= 256;
         pawn_sontype$field = param1;
      }
      
      public function get pawnSontype() : int
      {
         return pawn_sontype$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasPosX)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,pos_x$field);
         }
         if(hasPosY)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,pos_y$field);
         }
         if(hasPawnLevel)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,pawn_level$field);
         }
         if(hasPawnTempId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,pawn_temp_id$field);
         }
         if(hasShowBox)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_BOOL(param1,show_box$field);
         }
         if(hasShowSkill)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,show_skill$field);
         }
         if(hasFighting)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_BOOL(param1,fighting$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasPawnSontype)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,pawn_sontype$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc11_:uint = 0;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         var _loc6_:uint = 0;
         var _loc12_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: FantasyMatrixNodeMsg.posX cannot be set twice.");
                  }
                  _loc11_++;
                  posX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: FantasyMatrixNodeMsg.posY cannot be set twice.");
                  }
                  _loc3_++;
                  posY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: FantasyMatrixNodeMsg.pawnLevel cannot be set twice.");
                  }
                  _loc9_++;
                  pawnLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: FantasyMatrixNodeMsg.pawnTempId cannot be set twice.");
                  }
                  _loc6_++;
                  pawnTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: FantasyMatrixNodeMsg.showBox cannot be set twice.");
                  }
                  _loc12_++;
                  showBox = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: FantasyMatrixNodeMsg.showSkill cannot be set twice.");
                  }
                  _loc5_++;
                  showSkill = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FantasyMatrixNodeMsg.fighting cannot be set twice.");
                  }
                  _loc4_++;
                  fighting = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 7:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: FantasyMatrixNodeMsg.state cannot be set twice.");
                  }
                  _loc7_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: FantasyMatrixNodeMsg.pawnSontype cannot be set twice.");
                  }
                  _loc8_++;
                  pawnSontype = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

