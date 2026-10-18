package com.road.yishi.proto.fish
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class Result extends Message implements IExternalizable
   {
      
      private var fishId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var state$field:int;
      
      private var tool$field:int;
      
      public function Result()
      {
         super();
      }
      
      public function removeFishId() : void
      {
         hasField$0 &= 4294967294;
         fishId$field = new int();
      }
      
      public function get hasFishId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set fishId(param1:int) : void
      {
         hasField$0 |= 1;
         fishId$field = param1;
      }
      
      public function get fishId() : int
      {
         return fishId$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967293;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 2;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeTool() : void
      {
         hasField$0 &= 4294967291;
         tool$field = new int();
      }
      
      public function get hasTool() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set tool(param1:int) : void
      {
         hasField$0 |= 4;
         tool$field = param1;
      }
      
      public function get tool() : int
      {
         return tool$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasFishId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,fishId$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasTool)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,tool$field);
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
                     throw new IOError("Bad data format: Result.fishId cannot be set twice.");
                  }
                  _loc3_++;
                  fishId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Result.state cannot be set twice.");
                  }
                  _loc4_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: Result.tool cannot be set twice.");
                  }
                  _loc6_++;
                  tool = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

