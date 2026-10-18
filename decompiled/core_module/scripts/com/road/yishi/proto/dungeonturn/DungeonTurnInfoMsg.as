package com.road.yishi.proto.dungeonturn
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class DungeonTurnInfoMsg extends Message implements IExternalizable
   {
      
      private var blue$field:int;
      
      private var hasField$0:uint = 0;
      
      private var red$field:int;
      
      private var green$field:int;
      
      private var bossBox$field:int;
      
      private var normalBox$field:int;
      
      private var selectCount$field:int;
      
      private var curPos$field:int;
      
      [ArrayElementType("com.road.yishi.proto.dungeonturn.PlayerInfoMsg")]
      public var playerInfo:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.dungeonturn.PosStatusMsg")]
      public var posStatusMsg:Array = [];
      
      public function DungeonTurnInfoMsg()
      {
         super();
      }
      
      public function removeBlue() : void
      {
         hasField$0 &= 4294967294;
         blue$field = new int();
      }
      
      public function get hasBlue() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set blue(param1:int) : void
      {
         hasField$0 |= 1;
         blue$field = param1;
      }
      
      public function get blue() : int
      {
         return blue$field;
      }
      
      public function removeRed() : void
      {
         hasField$0 &= 4294967293;
         red$field = new int();
      }
      
      public function get hasRed() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set red(param1:int) : void
      {
         hasField$0 |= 2;
         red$field = param1;
      }
      
      public function get red() : int
      {
         return red$field;
      }
      
      public function removeGreen() : void
      {
         hasField$0 &= 4294967291;
         green$field = new int();
      }
      
      public function get hasGreen() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set green(param1:int) : void
      {
         hasField$0 |= 4;
         green$field = param1;
      }
      
      public function get green() : int
      {
         return green$field;
      }
      
      public function removeBossBox() : void
      {
         hasField$0 &= 4294967287;
         bossBox$field = new int();
      }
      
      public function get hasBossBox() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set bossBox(param1:int) : void
      {
         hasField$0 |= 8;
         bossBox$field = param1;
      }
      
      public function get bossBox() : int
      {
         return bossBox$field;
      }
      
      public function removeNormalBox() : void
      {
         hasField$0 &= 4294967279;
         normalBox$field = new int();
      }
      
      public function get hasNormalBox() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set normalBox(param1:int) : void
      {
         hasField$0 |= 16;
         normalBox$field = param1;
      }
      
      public function get normalBox() : int
      {
         return normalBox$field;
      }
      
      public function removeSelectCount() : void
      {
         hasField$0 &= 4294967263;
         selectCount$field = new int();
      }
      
      public function get hasSelectCount() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set selectCount(param1:int) : void
      {
         hasField$0 |= 32;
         selectCount$field = param1;
      }
      
      public function get selectCount() : int
      {
         return selectCount$field;
      }
      
      public function removeCurPos() : void
      {
         hasField$0 &= 4294967231;
         curPos$field = new int();
      }
      
      public function get hasCurPos() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set curPos(param1:int) : void
      {
         hasField$0 |= 64;
         curPos$field = param1;
      }
      
      public function get curPos() : int
      {
         return curPos$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(hasBlue)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,blue$field);
         }
         if(hasRed)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,red$field);
         }
         if(hasGreen)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,green$field);
         }
         if(hasBossBox)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,bossBox$field);
         }
         if(hasNormalBox)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,normalBox$field);
         }
         if(hasSelectCount)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,selectCount$field);
         }
         if(hasCurPos)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,curPos$field);
         }
         _loc3_ = 0;
         while(_loc3_ < playerInfo.length)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_MESSAGE(param1,playerInfo[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < posStatusMsg.length)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_MESSAGE(param1,posStatusMsg[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc12_:PlayerInfoMsg = null;
         var _loc3_:PosStatusMsg = null;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc11_:uint = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: DungeonTurnInfoMsg.blue cannot be set twice.");
                  }
                  _loc5_++;
                  blue = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: DungeonTurnInfoMsg.red cannot be set twice.");
                  }
                  _loc8_++;
                  red = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: DungeonTurnInfoMsg.green cannot be set twice.");
                  }
                  _loc11_++;
                  green = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: DungeonTurnInfoMsg.bossBox cannot be set twice.");
                  }
                  _loc7_++;
                  bossBox = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: DungeonTurnInfoMsg.normalBox cannot be set twice.");
                  }
                  _loc6_++;
                  normalBox = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: DungeonTurnInfoMsg.selectCount cannot be set twice.");
                  }
                  _loc4_++;
                  selectCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: DungeonTurnInfoMsg.curPos cannot be set twice.");
                  }
                  _loc9_++;
                  curPos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  _loc12_ = new PlayerInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc12_);
                  playerInfo.push(_loc12_);
                  break;
               case 8:
                  _loc3_ = new PosStatusMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  posStatusMsg.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

