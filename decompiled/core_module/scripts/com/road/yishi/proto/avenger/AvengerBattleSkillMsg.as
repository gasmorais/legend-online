package com.road.yishi.proto.avenger
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class AvengerBattleSkillMsg extends Message implements IExternalizable
   {
      
      private var avengerLeftCd$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("int")]
      public var avengerSkills:Array = [];
      
      [ArrayElementType("int")]
      public var avengerAllSkills:Array = [];
      
      public function AvengerBattleSkillMsg()
      {
         super();
      }
      
      public function removeAvengerLeftCd() : void
      {
         hasField$0 &= 4294967294;
         avengerLeftCd$field = new int();
      }
      
      public function get hasAvengerLeftCd() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set avengerLeftCd(param1:int) : void
      {
         hasField$0 |= 1;
         avengerLeftCd$field = param1;
      }
      
      public function get avengerLeftCd() : int
      {
         return avengerLeftCd$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(hasAvengerLeftCd)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,avengerLeftCd$field);
         }
         _loc3_ = 0;
         while(_loc3_ < avengerSkills.length)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,avengerSkills[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < avengerAllSkills.length)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,avengerAllSkills[_loc2_]);
            _loc2_++;
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
                     throw new IOError("Bad data format: AvengerBattleSkillMsg.avengerLeftCd cannot be set twice.");
                  }
                  _loc3_++;
                  avengerLeftCd = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if((_loc4_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,avengerSkills);
                  }
                  else
                  {
                     avengerSkills.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 2:
                  if((_loc4_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,avengerAllSkills);
                  }
                  else
                  {
                     avengerAllSkills.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

