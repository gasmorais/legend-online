package com.road.yishi.proto.active
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ActiveData extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.active.PackageData")]
      public var packdata:Array = [];
      
      private var value$field:int;
      
      private var hasField$0:uint = 0;
      
      private var activeId$field:String;
      
      private var is_show$field:Boolean;
      
      private var type$field:int;
      
      private var activeCharge$field:int;
      
      [ArrayElementType("com.road.yishi.proto.active.ConsumeInfoMsg")]
      public var consumeMsg:Array = [];
      
      public function ActiveData()
      {
         super();
      }
      
      public function removeValue() : void
      {
         hasField$0 &= 4294967294;
         value$field = new int();
      }
      
      public function get hasValue() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set value(param1:int) : void
      {
         hasField$0 |= 1;
         value$field = param1;
      }
      
      public function get value() : int
      {
         return value$field;
      }
      
      public function removeActiveId() : void
      {
         activeId$field = null;
      }
      
      public function get hasActiveId() : Boolean
      {
         return activeId$field != null;
      }
      
      public function set activeId(param1:String) : void
      {
         activeId$field = param1;
      }
      
      public function get activeId() : String
      {
         return activeId$field;
      }
      
      public function removeIsShow() : void
      {
         hasField$0 &= 4294967293;
         is_show$field = new Boolean();
      }
      
      public function get hasIsShow() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set isShow(param1:Boolean) : void
      {
         hasField$0 |= 2;
         is_show$field = param1;
      }
      
      public function get isShow() : Boolean
      {
         return is_show$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967291;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 4;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeActiveCharge() : void
      {
         hasField$0 &= 4294967287;
         activeCharge$field = new int();
      }
      
      public function get hasActiveCharge() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set activeCharge(param1:int) : void
      {
         hasField$0 |= 8;
         activeCharge$field = param1;
      }
      
      public function get activeCharge() : int
      {
         return activeCharge$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         _loc3_ = 0;
         while(_loc3_ < packdata.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,packdata[_loc3_]);
            _loc3_++;
         }
         if(hasValue)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,value$field);
         }
         if(hasActiveId)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,activeId$field);
         }
         if(hasIsShow)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,is_show$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasActiveCharge)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,activeCharge$field);
         }
         _loc2_ = 0;
         while(_loc2_ < consumeMsg.length)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_MESSAGE(param1,consumeMsg[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc4_:PackageData = null;
         var _loc5_:ConsumeInfoMsg = null;
         var _loc10_:uint = 0;
         var _loc6_:uint = 0;
         var _loc9_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc4_ = new PackageData();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  packdata.push(_loc4_);
                  break;
               case 1:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveData.value cannot be set twice.");
                  }
                  _loc10_++;
                  value = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveData.activeId cannot be set twice.");
                  }
                  _loc6_++;
                  activeId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveData.isShow cannot be set twice.");
                  }
                  _loc9_++;
                  isShow = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveData.type cannot be set twice.");
                  }
                  _loc7_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveData.activeCharge cannot be set twice.");
                  }
                  _loc3_++;
                  activeCharge = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  _loc5_ = new ConsumeInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  consumeMsg.push(_loc5_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

