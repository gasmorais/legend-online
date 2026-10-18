package com.road.yishi.proto.battle
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PreLoadResMsg extends Message implements IExternalizable
   {
      
      private var army_id$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("int")]
      public var heroSkill:Array = [];
      
      [ArrayElementType("int")]
      public var soldierTempId:Array = [];
      
      [ArrayElementType("int")]
      public var soldierSkill:Array = [];
      
      public function PreLoadResMsg()
      {
         super();
      }
      
      public function removeArmyId() : void
      {
         hasField$0 &= 4294967294;
         army_id$field = new int();
      }
      
      public function get hasArmyId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set armyId(param1:int) : void
      {
         hasField$0 |= 1;
         army_id$field = param1;
      }
      
      public function get armyId() : int
      {
         return army_id$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         if(hasArmyId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,army_id$field);
         }
         _loc2_ = 0;
         while(_loc2_ < heroSkill.length)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,heroSkill[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < soldierTempId.length)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,soldierTempId[_loc3_]);
            _loc3_++;
         }
         _loc4_ = 0;
         while(_loc4_ < soldierSkill.length)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,soldierSkill[_loc4_]);
            _loc4_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PreLoadResMsg.armyId cannot be set twice.");
                  }
                  _loc3_++;
                  armyId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if((_loc4_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,heroSkill);
                  }
                  else
                  {
                     heroSkill.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 2:
                  if((_loc4_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,soldierTempId);
                  }
                  else
                  {
                     soldierTempId.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 3:
                  if((_loc4_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,soldierSkill);
                  }
                  else
                  {
                     soldierSkill.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

