package com.road.yishi.proto.battle
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TitanInfoMsg extends Message implements IExternalizable
   {
      
      private var titanId$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.battle.SkillStateMsg")]
      public var titanSkill:Array = [];
      
      public function TitanInfoMsg()
      {
         super();
      }
      
      public function removeTitanId() : void
      {
         hasField$0 &= 4294967294;
         titanId$field = new int();
      }
      
      public function get hasTitanId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set titanId(param1:int) : void
      {
         hasField$0 |= 1;
         titanId$field = param1;
      }
      
      public function get titanId() : int
      {
         return titanId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasTitanId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,titanId$field);
         }
         _loc2_ = 0;
         while(_loc2_ < titanSkill.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,titanSkill[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:SkillStateMsg = null;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TitanInfoMsg.titanId cannot be set twice.");
                  }
                  _loc3_++;
                  titanId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc4_ = new SkillStateMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  titanSkill.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

