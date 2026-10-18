package com.road.yishi.proto.battle
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class AttackOrderMsg extends Message implements IExternalizable
   {
      
      private var battle_id$field:String;
      
      private var frame$field:int;
      
      private var hasField$0:uint = 0;
      
      private var order_id$field:int;
      
      private var is_passive$field:Boolean;
      
      private var living_id$field:int;
      
      private var sp$field:int;
      
      private var sp_added$field:int;
      
      [ArrayElementType("com.road.yishi.proto.battle.DamageMsg")]
      public var damages:Array = [];
      
      private var exec_frame$field:int;
      
      private var frame_num$field:int;
      
      private var attack_millis$field:String;
      
      [ArrayElementType("com.road.yishi.proto.battle.BufferMsg")]
      public var buffers:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.battle.SoldierMsg")]
      public var awakenSoldiers:Array = [];
      
      private var attackOrderSeq$field:int;
      
      private var cdTime$field:int;
      
      private var awake$field:int;
      
      private var awake_add$field:int;
      
      [ArrayElementType("com.road.yishi.proto.battle.WaitReviveMsg")]
      public var waitRevives:Array = [];
      
      private var hitPoint$field:int;
      
      private var curturn$field:int;
      
      private var coexist$field:int;
      
      public function AttackOrderMsg()
      {
         super();
      }
      
      public function removeBattleId() : void
      {
         battle_id$field = null;
      }
      
      public function get hasBattleId() : Boolean
      {
         return battle_id$field != null;
      }
      
      public function set battleId(param1:String) : void
      {
         battle_id$field = param1;
      }
      
      public function get battleId() : String
      {
         return battle_id$field;
      }
      
      public function removeFrame() : void
      {
         hasField$0 &= 4294967294;
         frame$field = new int();
      }
      
      public function get hasFrame() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set frame(param1:int) : void
      {
         hasField$0 |= 1;
         frame$field = param1;
      }
      
      public function get frame() : int
      {
         return frame$field;
      }
      
      public function removeOrderId() : void
      {
         hasField$0 &= 4294967293;
         order_id$field = new int();
      }
      
      public function get hasOrderId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set orderId(param1:int) : void
      {
         hasField$0 |= 2;
         order_id$field = param1;
      }
      
      public function get orderId() : int
      {
         return order_id$field;
      }
      
      public function removeIsPassive() : void
      {
         hasField$0 &= 4294967291;
         is_passive$field = new Boolean();
      }
      
      public function get hasIsPassive() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set isPassive(param1:Boolean) : void
      {
         hasField$0 |= 4;
         is_passive$field = param1;
      }
      
      public function get isPassive() : Boolean
      {
         return is_passive$field;
      }
      
      public function removeLivingId() : void
      {
         hasField$0 &= 4294967287;
         living_id$field = new int();
      }
      
      public function get hasLivingId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set livingId(param1:int) : void
      {
         hasField$0 |= 8;
         living_id$field = param1;
      }
      
      public function get livingId() : int
      {
         return living_id$field;
      }
      
      public function removeSp() : void
      {
         hasField$0 &= 4294967279;
         sp$field = new int();
      }
      
      public function get hasSp() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set sp(param1:int) : void
      {
         hasField$0 |= 16;
         sp$field = param1;
      }
      
      public function get sp() : int
      {
         return sp$field;
      }
      
      public function removeSpAdded() : void
      {
         hasField$0 &= 4294967263;
         sp_added$field = new int();
      }
      
      public function get hasSpAdded() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set spAdded(param1:int) : void
      {
         hasField$0 |= 32;
         sp_added$field = param1;
      }
      
      public function get spAdded() : int
      {
         return sp_added$field;
      }
      
      public function removeExecFrame() : void
      {
         hasField$0 &= 4294967231;
         exec_frame$field = new int();
      }
      
      public function get hasExecFrame() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set execFrame(param1:int) : void
      {
         hasField$0 |= 64;
         exec_frame$field = param1;
      }
      
      public function get execFrame() : int
      {
         return exec_frame$field;
      }
      
      public function removeFrameNum() : void
      {
         hasField$0 &= 4294967167;
         frame_num$field = new int();
      }
      
      public function get hasFrameNum() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set frameNum(param1:int) : void
      {
         hasField$0 |= 128;
         frame_num$field = param1;
      }
      
      public function get frameNum() : int
      {
         return frame_num$field;
      }
      
      public function removeAttackMillis() : void
      {
         attack_millis$field = null;
      }
      
      public function get hasAttackMillis() : Boolean
      {
         return attack_millis$field != null;
      }
      
      public function set attackMillis(param1:String) : void
      {
         attack_millis$field = param1;
      }
      
      public function get attackMillis() : String
      {
         return attack_millis$field;
      }
      
      public function removeAttackOrderSeq() : void
      {
         hasField$0 &= 4294967039;
         attackOrderSeq$field = new int();
      }
      
      public function get hasAttackOrderSeq() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set attackOrderSeq(param1:int) : void
      {
         hasField$0 |= 256;
         attackOrderSeq$field = param1;
      }
      
      public function get attackOrderSeq() : int
      {
         return attackOrderSeq$field;
      }
      
      public function removeCdTime() : void
      {
         hasField$0 &= 4294966783;
         cdTime$field = new int();
      }
      
      public function get hasCdTime() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set cdTime(param1:int) : void
      {
         hasField$0 |= 512;
         cdTime$field = param1;
      }
      
      public function get cdTime() : int
      {
         return cdTime$field;
      }
      
      public function removeAwake() : void
      {
         hasField$0 &= 4294966271;
         awake$field = new int();
      }
      
      public function get hasAwake() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set awake(param1:int) : void
      {
         hasField$0 |= 1024;
         awake$field = param1;
      }
      
      public function get awake() : int
      {
         return awake$field;
      }
      
      public function removeAwakeAdd() : void
      {
         hasField$0 &= 4294965247;
         awake_add$field = new int();
      }
      
      public function get hasAwakeAdd() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set awakeAdd(param1:int) : void
      {
         hasField$0 |= 2048;
         awake_add$field = param1;
      }
      
      public function get awakeAdd() : int
      {
         return awake_add$field;
      }
      
      public function removeHitPoint() : void
      {
         hasField$0 &= 4294963199;
         hitPoint$field = new int();
      }
      
      public function get hasHitPoint() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set hitPoint(param1:int) : void
      {
         hasField$0 |= 4096;
         hitPoint$field = param1;
      }
      
      public function get hitPoint() : int
      {
         return hitPoint$field;
      }
      
      public function removeCurturn() : void
      {
         hasField$0 &= 4294959103;
         curturn$field = new int();
      }
      
      public function get hasCurturn() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set curturn(param1:int) : void
      {
         hasField$0 |= 8192;
         curturn$field = param1;
      }
      
      public function get curturn() : int
      {
         return curturn$field;
      }
      
      public function removeCoexist() : void
      {
         hasField$0 &= 4294950911;
         coexist$field = new int();
      }
      
      public function get hasCoexist() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set coexist(param1:int) : void
      {
         hasField$0 |= 16384;
         coexist$field = param1;
      }
      
      public function get coexist() : int
      {
         return coexist$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(hasBattleId)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,battle_id$field);
         }
         if(hasFrame)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,frame$field);
         }
         if(hasOrderId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,order_id$field);
         }
         if(hasIsPassive)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,is_passive$field);
         }
         if(hasLivingId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,living_id$field);
         }
         if(hasSp)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,sp$field);
         }
         if(hasSpAdded)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,sp_added$field);
         }
         _loc4_ = 0;
         while(_loc4_ < damages.length)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_MESSAGE(param1,damages[_loc4_]);
            _loc4_++;
         }
         if(hasExecFrame)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,exec_frame$field);
         }
         if(hasFrameNum)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,frame_num$field);
         }
         if(hasAttackMillis)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_STRING(param1,attack_millis$field);
         }
         _loc5_ = 0;
         while(_loc5_ < buffers.length)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_MESSAGE(param1,buffers[_loc5_]);
            _loc5_++;
         }
         _loc3_ = 0;
         while(_loc3_ < awakenSoldiers.length)
         {
            WriteUtils.writeTag(param1,2,13);
            WriteUtils.write$TYPE_MESSAGE(param1,awakenSoldiers[_loc3_]);
            _loc3_++;
         }
         if(hasAttackOrderSeq)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,attackOrderSeq$field);
         }
         if(hasCdTime)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,cdTime$field);
         }
         if(hasAwake)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,awake$field);
         }
         if(hasAwakeAdd)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,awake_add$field);
         }
         _loc2_ = 0;
         while(_loc2_ < waitRevives.length)
         {
            WriteUtils.writeTag(param1,2,18);
            WriteUtils.write$TYPE_MESSAGE(param1,waitRevives[_loc2_]);
            _loc2_++;
         }
         if(hasHitPoint)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,hitPoint$field);
         }
         if(hasCurturn)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,curturn$field);
         }
         if(hasCoexist)
         {
            WriteUtils.writeTag(param1,0,21);
            WriteUtils.write$TYPE_INT32(param1,coexist$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc20_:* = 0;
         var _loc23_:DamageMsg = null;
         var _loc19_:BufferMsg = null;
         var _loc3_:SoldierMsg = null;
         var _loc11_:WaitReviveMsg = null;
         var _loc12_:uint = 0;
         var _loc16_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc21_:uint = 0;
         var _loc24_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc22_:uint = 0;
         var _loc17_:uint = 0;
         var _loc14_:uint = 0;
         var _loc7_:uint = 0;
         var _loc15_:uint = 0;
         var _loc18_:uint = 0;
         var _loc8_:uint = 0;
         var _loc5_:uint = 0;
         var _loc13_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc20_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: AttackOrderMsg.battleId cannot be set twice.");
                  }
                  _loc12_++;
                  battleId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: AttackOrderMsg.frame cannot be set twice.");
                  }
                  _loc16_++;
                  frame = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: AttackOrderMsg.orderId cannot be set twice.");
                  }
                  _loc9_++;
                  orderId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: AttackOrderMsg.isPassive cannot be set twice.");
                  }
                  _loc10_++;
                  isPassive = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 5:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: AttackOrderMsg.livingId cannot be set twice.");
                  }
                  _loc21_++;
                  livingId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: AttackOrderMsg.sp cannot be set twice.");
                  }
                  _loc24_++;
                  sp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: AttackOrderMsg.spAdded cannot be set twice.");
                  }
                  _loc6_++;
                  spAdded = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  _loc23_ = new DamageMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc23_);
                  damages.push(_loc23_);
                  break;
               case 9:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: AttackOrderMsg.execFrame cannot be set twice.");
                  }
                  _loc4_++;
                  execFrame = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: AttackOrderMsg.frameNum cannot be set twice.");
                  }
                  _loc22_++;
                  frameNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: AttackOrderMsg.attackMillis cannot be set twice.");
                  }
                  _loc17_++;
                  attackMillis = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 12:
                  _loc19_ = new BufferMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc19_);
                  buffers.push(_loc19_);
                  break;
               case 13:
                  _loc3_ = new SoldierMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  awakenSoldiers.push(_loc3_);
                  break;
               case 14:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: AttackOrderMsg.attackOrderSeq cannot be set twice.");
                  }
                  _loc14_++;
                  attackOrderSeq = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: AttackOrderMsg.cdTime cannot be set twice.");
                  }
                  _loc7_++;
                  cdTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: AttackOrderMsg.awake cannot be set twice.");
                  }
                  _loc15_++;
                  awake = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: AttackOrderMsg.awakeAdd cannot be set twice.");
                  }
                  _loc18_++;
                  awakeAdd = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 18:
                  _loc11_ = new WaitReviveMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc11_);
                  waitRevives.push(_loc11_);
                  break;
               case 19:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: AttackOrderMsg.hitPoint cannot be set twice.");
                  }
                  _loc8_++;
                  hitPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 20:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: AttackOrderMsg.curturn cannot be set twice.");
                  }
                  _loc5_++;
                  curturn = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 21:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: AttackOrderMsg.coexist cannot be set twice.");
                  }
                  _loc13_++;
                  coexist = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc20_ & 7);
            }
         }
      }
   }
}

