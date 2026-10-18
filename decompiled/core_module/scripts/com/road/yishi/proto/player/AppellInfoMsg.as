package com.road.yishi.proto.player
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class AppellInfoMsg extends Message implements IExternalizable
   {
      
      private var appellId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var isGet$field:Boolean;
      
      private var value$field:String;
      
      private var validDate$field:String;
      
      public function AppellInfoMsg()
      {
         super();
      }
      
      public function removeAppellId() : void
      {
         hasField$0 &= 4294967294;
         appellId$field = new int();
      }
      
      public function get hasAppellId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set appellId(param1:int) : void
      {
         hasField$0 |= 1;
         appellId$field = param1;
      }
      
      public function get appellId() : int
      {
         return appellId$field;
      }
      
      public function removeIsGet() : void
      {
         hasField$0 &= 4294967293;
         isGet$field = new Boolean();
      }
      
      public function get hasIsGet() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set isGet(param1:Boolean) : void
      {
         hasField$0 |= 2;
         isGet$field = param1;
      }
      
      public function get isGet() : Boolean
      {
         return isGet$field;
      }
      
      public function removeValue() : void
      {
         value$field = null;
      }
      
      public function get hasValue() : Boolean
      {
         return value$field != null;
      }
      
      public function set value(param1:String) : void
      {
         value$field = param1;
      }
      
      public function get value() : String
      {
         return value$field;
      }
      
      public function removeValidDate() : void
      {
         validDate$field = null;
      }
      
      public function get hasValidDate() : Boolean
      {
         return validDate$field != null;
      }
      
      public function set validDate(param1:String) : void
      {
         validDate$field = param1;
      }
      
      public function get validDate() : String
      {
         return validDate$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasAppellId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,appellId$field);
         }
         if(hasIsGet)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_BOOL(param1,isGet$field);
         }
         if(hasValue)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,value$field);
         }
         if(hasValidDate)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,validDate$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: AppellInfoMsg.appellId cannot be set twice.");
                  }
                  _loc7_++;
                  appellId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: AppellInfoMsg.isGet cannot be set twice.");
                  }
                  _loc3_++;
                  isGet = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: AppellInfoMsg.value cannot be set twice.");
                  }
                  _loc6_++;
                  value = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: AppellInfoMsg.validDate cannot be set twice.");
                  }
                  _loc5_++;
                  validDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

