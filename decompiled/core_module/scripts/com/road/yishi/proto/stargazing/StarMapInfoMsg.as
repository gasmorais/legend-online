package com.road.yishi.proto.stargazing
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class StarMapInfoMsg extends Message implements IExternalizable
   {
      
      private var mapIndex$field:int;
      
      private var hasField$0:uint = 0;
      
      private var repeatTimes$field:int;
      
      private var fragmentBitMap$field:String;
      
      private var mapProerty$field:PropertyMsg;
      
      public function StarMapInfoMsg()
      {
         super();
      }
      
      public function removeMapIndex() : void
      {
         hasField$0 &= 4294967294;
         mapIndex$field = new int();
      }
      
      public function get hasMapIndex() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set mapIndex(param1:int) : void
      {
         hasField$0 |= 1;
         mapIndex$field = param1;
      }
      
      public function get mapIndex() : int
      {
         return mapIndex$field;
      }
      
      public function removeRepeatTimes() : void
      {
         hasField$0 &= 4294967293;
         repeatTimes$field = new int();
      }
      
      public function get hasRepeatTimes() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set repeatTimes(param1:int) : void
      {
         hasField$0 |= 2;
         repeatTimes$field = param1;
      }
      
      public function get repeatTimes() : int
      {
         return repeatTimes$field;
      }
      
      public function removeFragmentBitMap() : void
      {
         fragmentBitMap$field = null;
      }
      
      public function get hasFragmentBitMap() : Boolean
      {
         return fragmentBitMap$field != null;
      }
      
      public function set fragmentBitMap(param1:String) : void
      {
         fragmentBitMap$field = param1;
      }
      
      public function get fragmentBitMap() : String
      {
         return fragmentBitMap$field;
      }
      
      public function removeMapProerty() : void
      {
         mapProerty$field = null;
      }
      
      public function get hasMapProerty() : Boolean
      {
         return mapProerty$field != null;
      }
      
      public function set mapProerty(param1:PropertyMsg) : void
      {
         mapProerty$field = param1;
      }
      
      public function get mapProerty() : PropertyMsg
      {
         return mapProerty$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasMapIndex)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,mapIndex$field);
         }
         if(hasRepeatTimes)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,repeatTimes$field);
         }
         if(hasFragmentBitMap)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,fragmentBitMap$field);
         }
         if(hasMapProerty)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,mapProerty$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: StarMapInfoMsg.mapIndex cannot be set twice.");
                  }
                  _loc4_++;
                  mapIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: StarMapInfoMsg.repeatTimes cannot be set twice.");
                  }
                  _loc6_++;
                  repeatTimes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: StarMapInfoMsg.fragmentBitMap cannot be set twice.");
                  }
                  _loc3_++;
                  fragmentBitMap = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: StarMapInfoMsg.mapProerty cannot be set twice.");
                  }
                  _loc7_++;
                  mapProerty = new PropertyMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,mapProerty);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

