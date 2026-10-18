package com.road.yishi.proto.battle
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BufferMsg extends Message implements IExternalizable
   {
      
      private var buffer_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var template_id$field:int;
      
      private var source_id$field:int;
      
      private var target_id$field:int;
      
      private var cur_turn$field:int;
      
      private var exec_frame$field:int;
      
      private var see_type$field:int;
      
      private var exe_way$field:int;
      
      private var pressed_num$field:int;
      
      [ArrayElementType("com.road.yishi.proto.battle.DamageMsg")]
      public var damage:Array = [];
      
      private var max_turn$field:int;
      
      [ArrayElementType("int")]
      public var unSkillIds:Array = [];
      
      private var isPermanent$field:Boolean;
      
      private var cur_round$field:int;
      
      private var max_round$field:int;
      
      private var target_skill_id$field:int;
      
      public function BufferMsg()
      {
         super();
      }
      
      public function removeBufferId() : void
      {
         hasField$0 &= 4294967294;
         buffer_id$field = new int();
      }
      
      public function get hasBufferId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set bufferId(param1:int) : void
      {
         hasField$0 |= 1;
         buffer_id$field = param1;
      }
      
      public function get bufferId() : int
      {
         return buffer_id$field;
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967293;
         template_id$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 2;
         template_id$field = param1;
      }
      
      public function get templateId() : int
      {
         return template_id$field;
      }
      
      public function removeSourceId() : void
      {
         hasField$0 &= 4294967291;
         source_id$field = new int();
      }
      
      public function get hasSourceId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set sourceId(param1:int) : void
      {
         hasField$0 |= 4;
         source_id$field = param1;
      }
      
      public function get sourceId() : int
      {
         return source_id$field;
      }
      
      public function removeTargetId() : void
      {
         hasField$0 &= 4294967287;
         target_id$field = new int();
      }
      
      public function get hasTargetId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set targetId(param1:int) : void
      {
         hasField$0 |= 8;
         target_id$field = param1;
      }
      
      public function get targetId() : int
      {
         return target_id$field;
      }
      
      public function removeCurTurn() : void
      {
         hasField$0 &= 4294967279;
         cur_turn$field = new int();
      }
      
      public function get hasCurTurn() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set curTurn(param1:int) : void
      {
         hasField$0 |= 16;
         cur_turn$field = param1;
      }
      
      public function get curTurn() : int
      {
         return cur_turn$field;
      }
      
      public function removeExecFrame() : void
      {
         hasField$0 &= 4294967263;
         exec_frame$field = new int();
      }
      
      public function get hasExecFrame() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set execFrame(param1:int) : void
      {
         hasField$0 |= 32;
         exec_frame$field = param1;
      }
      
      public function get execFrame() : int
      {
         return exec_frame$field;
      }
      
      public function removeSeeType() : void
      {
         hasField$0 &= 4294967231;
         see_type$field = new int();
      }
      
      public function get hasSeeType() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set seeType(param1:int) : void
      {
         hasField$0 |= 64;
         see_type$field = param1;
      }
      
      public function get seeType() : int
      {
         return see_type$field;
      }
      
      public function removeExeWay() : void
      {
         hasField$0 &= 4294967167;
         exe_way$field = new int();
      }
      
      public function get hasExeWay() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set exeWay(param1:int) : void
      {
         hasField$0 |= 128;
         exe_way$field = param1;
      }
      
      public function get exeWay() : int
      {
         return exe_way$field;
      }
      
      public function removePressedNum() : void
      {
         hasField$0 &= 4294967039;
         pressed_num$field = new int();
      }
      
      public function get hasPressedNum() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set pressedNum(param1:int) : void
      {
         hasField$0 |= 256;
         pressed_num$field = param1;
      }
      
      public function get pressedNum() : int
      {
         return pressed_num$field;
      }
      
      public function removeMaxTurn() : void
      {
         hasField$0 &= 4294966783;
         max_turn$field = new int();
      }
      
      public function get hasMaxTurn() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set maxTurn(param1:int) : void
      {
         hasField$0 |= 512;
         max_turn$field = param1;
      }
      
      public function get maxTurn() : int
      {
         return max_turn$field;
      }
      
      public function removeIsPermanent() : void
      {
         hasField$0 &= 4294966271;
         isPermanent$field = new Boolean();
      }
      
      public function get hasIsPermanent() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set isPermanent(param1:Boolean) : void
      {
         hasField$0 |= 1024;
         isPermanent$field = param1;
      }
      
      public function get isPermanent() : Boolean
      {
         return isPermanent$field;
      }
      
      public function removeCurRound() : void
      {
         hasField$0 &= 4294965247;
         cur_round$field = new int();
      }
      
      public function get hasCurRound() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set curRound(param1:int) : void
      {
         hasField$0 |= 2048;
         cur_round$field = param1;
      }
      
      public function get curRound() : int
      {
         return cur_round$field;
      }
      
      public function removeMaxRound() : void
      {
         hasField$0 &= 4294963199;
         max_round$field = new int();
      }
      
      public function get hasMaxRound() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set maxRound(param1:int) : void
      {
         hasField$0 |= 4096;
         max_round$field = param1;
      }
      
      public function get maxRound() : int
      {
         return max_round$field;
      }
      
      public function removeTargetSkillId() : void
      {
         hasField$0 &= 4294959103;
         target_skill_id$field = new int();
      }
      
      public function get hasTargetSkillId() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set targetSkillId(param1:int) : void
      {
         hasField$0 |= 8192;
         target_skill_id$field = param1;
      }
      
      public function get targetSkillId() : int
      {
         return target_skill_id$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(hasBufferId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,buffer_id$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,template_id$field);
         }
         if(hasSourceId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,source_id$field);
         }
         if(hasTargetId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,target_id$field);
         }
         if(hasCurTurn)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,cur_turn$field);
         }
         if(hasExecFrame)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,exec_frame$field);
         }
         if(hasSeeType)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,see_type$field);
         }
         if(hasExeWay)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,exe_way$field);
         }
         if(hasPressedNum)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,pressed_num$field);
         }
         _loc2_ = 0;
         while(_loc2_ < damage.length)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_MESSAGE(param1,damage[_loc2_]);
            _loc2_++;
         }
         if(hasMaxTurn)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,max_turn$field);
         }
         _loc3_ = 0;
         while(_loc3_ < unSkillIds.length)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,unSkillIds[_loc3_]);
            _loc3_++;
         }
         if(hasIsPermanent)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_BOOL(param1,isPermanent$field);
         }
         if(hasCurRound)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,cur_round$field);
         }
         if(hasMaxRound)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,max_round$field);
         }
         if(hasTargetSkillId)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,target_skill_id$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc17_:* = 0;
         var _loc8_:DamageMsg = null;
         var _loc7_:uint = 0;
         var _loc14_:uint = 0;
         var _loc4_:uint = 0;
         var _loc15_:uint = 0;
         var _loc18_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc11_:uint = 0;
         var _loc16_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc5_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc17_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: BufferMsg.bufferId cannot be set twice.");
                  }
                  _loc7_++;
                  bufferId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: BufferMsg.templateId cannot be set twice.");
                  }
                  _loc14_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: BufferMsg.sourceId cannot be set twice.");
                  }
                  _loc4_++;
                  sourceId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: BufferMsg.targetId cannot be set twice.");
                  }
                  _loc15_++;
                  targetId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: BufferMsg.curTurn cannot be set twice.");
                  }
                  _loc18_++;
                  curTurn = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BufferMsg.execFrame cannot be set twice.");
                  }
                  _loc3_++;
                  execFrame = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: BufferMsg.seeType cannot be set twice.");
                  }
                  _loc6_++;
                  seeType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: BufferMsg.exeWay cannot be set twice.");
                  }
                  _loc11_++;
                  exeWay = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: BufferMsg.pressedNum cannot be set twice.");
                  }
                  _loc16_++;
                  pressedNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  _loc8_ = new DamageMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc8_);
                  damage.push(_loc8_);
                  break;
               case 11:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: BufferMsg.maxTurn cannot be set twice.");
                  }
                  _loc9_++;
                  maxTurn = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if((_loc17_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,unSkillIds);
                  }
                  else
                  {
                     unSkillIds.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 13:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: BufferMsg.isPermanent cannot be set twice.");
                  }
                  _loc10_++;
                  isPermanent = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 14:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: BufferMsg.curRound cannot be set twice.");
                  }
                  _loc5_++;
                  curRound = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: BufferMsg.maxRound cannot be set twice.");
                  }
                  _loc12_++;
                  maxRound = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: BufferMsg.targetSkillId cannot be set twice.");
                  }
                  _loc13_++;
                  targetSkillId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc17_ & 7);
            }
         }
      }
   }
}

