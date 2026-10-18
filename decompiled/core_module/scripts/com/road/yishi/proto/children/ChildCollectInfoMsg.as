package com.road.yishi.proto.children
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChildCollectInfoMsg extends Message implements IExternalizable
   {
      
      private var childType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var soulWakes$field:int;
      
      private var growth$field:int;
      
      public function ChildCollectInfoMsg()
      {
         super();
      }
      
      public function removeChildType() : void
      {
         hasField$0 &= 4294967294;
         childType$field = new int();
      }
      
      public function get hasChildType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set childType(param1:int) : void
      {
         hasField$0 |= 1;
         childType$field = param1;
      }
      
      public function get childType() : int
      {
         return childType$field;
      }
      
      public function removeSoulWakes() : void
      {
         hasField$0 &= 4294967293;
         soulWakes$field = new int();
      }
      
      public function get hasSoulWakes() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set soulWakes(param1:int) : void
      {
         hasField$0 |= 2;
         soulWakes$field = param1;
      }
      
      public function get soulWakes() : int
      {
         return soulWakes$field;
      }
      
      public function removeGrowth() : void
      {
         hasField$0 &= 4294967291;
         growth$field = new int();
      }
      
      public function get hasGrowth() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set growth(param1:int) : void
      {
         hasField$0 |= 4;
         growth$field = param1;
      }
      
      public function get growth() : int
      {
         return growth$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasChildType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,childType$field);
         }
         if(hasSoulWakes)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,soulWakes$field);
         }
         if(hasGrowth)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,growth$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChildCollectInfoMsg.childType cannot be set twice.");
                  }
                  _loc3_++;
                  childType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChildCollectInfoMsg.soulWakes cannot be set twice.");
                  }
                  _loc4_++;
                  soulWakes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ChildCollectInfoMsg.growth cannot be set twice.");
                  }
                  _loc6_++;
                  growth = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

