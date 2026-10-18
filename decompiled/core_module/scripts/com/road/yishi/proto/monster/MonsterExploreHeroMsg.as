package com.road.yishi.proto.monster
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MonsterExploreHeroMsg extends Message implements IExternalizable
   {
      
      private var index$field:int;
      
      private var hasField$0:uint = 0;
      
      private var templateId$field:int;
      
      private var name$field:String;
      
      private var isMonster$field:Boolean;
      
      private var curHp$field:int;
      
      private var maxHp$field:int;
      
      [ArrayElementType("int")]
      public var damages:Array = [];
      
      public function MonsterExploreHeroMsg()
      {
         super();
      }
      
      public function removeIndex() : void
      {
         hasField$0 &= 4294967294;
         index$field = new int();
      }
      
      public function get hasIndex() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set index(param1:int) : void
      {
         hasField$0 |= 1;
         index$field = param1;
      }
      
      public function get index() : int
      {
         return index$field;
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967293;
         templateId$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 2;
         templateId$field = param1;
      }
      
      public function get templateId() : int
      {
         return templateId$field;
      }
      
      public function removeName() : void
      {
         name$field = null;
      }
      
      public function get hasName() : Boolean
      {
         return name$field != null;
      }
      
      public function set name(param1:String) : void
      {
         name$field = param1;
      }
      
      public function get name() : String
      {
         return name$field;
      }
      
      public function removeIsMonster() : void
      {
         hasField$0 &= 4294967291;
         isMonster$field = new Boolean();
      }
      
      public function get hasIsMonster() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set isMonster(param1:Boolean) : void
      {
         hasField$0 |= 4;
         isMonster$field = param1;
      }
      
      public function get isMonster() : Boolean
      {
         return isMonster$field;
      }
      
      public function removeCurHp() : void
      {
         hasField$0 &= 4294967287;
         curHp$field = new int();
      }
      
      public function get hasCurHp() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set curHp(param1:int) : void
      {
         hasField$0 |= 8;
         curHp$field = param1;
      }
      
      public function get curHp() : int
      {
         return curHp$field;
      }
      
      public function removeMaxHp() : void
      {
         hasField$0 &= 4294967279;
         maxHp$field = new int();
      }
      
      public function get hasMaxHp() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set maxHp(param1:int) : void
      {
         hasField$0 |= 16;
         maxHp$field = param1;
      }
      
      public function get maxHp() : int
      {
         return maxHp$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasIndex)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,index$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
         if(hasName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,name$field);
         }
         if(hasIsMonster)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,isMonster$field);
         }
         if(hasCurHp)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,curHp$field);
         }
         if(hasMaxHp)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,maxHp$field);
         }
         _loc2_ = 0;
         while(_loc2_ < damages.length)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,damages[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterExploreHeroMsg.index cannot be set twice.");
                  }
                  _loc4_++;
                  index = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterExploreHeroMsg.templateId cannot be set twice.");
                  }
                  _loc5_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterExploreHeroMsg.name cannot be set twice.");
                  }
                  _loc3_++;
                  name = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterExploreHeroMsg.isMonster cannot be set twice.");
                  }
                  _loc8_++;
                  isMonster = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 4:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterExploreHeroMsg.curHp cannot be set twice.");
                  }
                  _loc9_++;
                  curHp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterExploreHeroMsg.maxHp cannot be set twice.");
                  }
                  _loc6_++;
                  maxHp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if((_loc7_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,damages);
                  }
                  else
                  {
                     damages.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

