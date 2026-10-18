package com.road.yishi.proto.monster
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MonsterUserMsg extends Message implements IExternalizable
   {
      
      private var opType$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.monster.CallInfoMsg")]
      public var calls:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.monster.CookInfoMsg")]
      public var cooks:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.monster.ItemCountMsg")]
      public var items:Array = [];
      
      [ArrayElementType("int")]
      public var recipes:Array = [];
      
      [ArrayElementType("int")]
      public var exploreFights:Array = [];
      
      [ArrayElementType("int")]
      public var contracts:Array = [];
      
      public function MonsterUserMsg()
      {
         super();
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294967294;
         opType$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 1;
         opType$field = param1;
      }
      
      public function get opType() : int
      {
         return opType$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc5_:* = 0;
         var _loc4_:* = 0;
         var _loc6_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc7_:* = 0;
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,opType$field);
         }
         _loc5_ = 0;
         while(_loc5_ < calls.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,calls[_loc5_]);
            _loc5_++;
         }
         _loc4_ = 0;
         while(_loc4_ < cooks.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,cooks[_loc4_]);
            _loc4_++;
         }
         _loc6_ = 0;
         while(_loc6_ < items.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,items[_loc6_]);
            _loc6_++;
         }
         _loc2_ = 0;
         while(_loc2_ < recipes.length)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,recipes[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < exploreFights.length)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,exploreFights[_loc3_]);
            _loc3_++;
         }
         _loc7_ = 0;
         while(_loc7_ < contracts.length)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,contracts[_loc7_]);
            _loc7_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:CallInfoMsg = null;
         var _loc5_:CookInfoMsg = null;
         var _loc7_:ItemCountMsg = null;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterUserMsg.opType cannot be set twice.");
                  }
                  _loc4_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc3_ = new CallInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  calls.push(_loc3_);
                  break;
               case 2:
                  _loc5_ = new CookInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  cooks.push(_loc5_);
                  break;
               case 3:
                  _loc7_ = new ItemCountMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  items.push(_loc7_);
                  break;
               case 4:
                  if((_loc6_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,recipes);
                  }
                  else
                  {
                     recipes.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 5:
                  if((_loc6_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,exploreFights);
                  }
                  else
                  {
                     exploreFights.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 6:
                  if((_loc6_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,contracts);
                  }
                  else
                  {
                     contracts.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

