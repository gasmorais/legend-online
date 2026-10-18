package com.road.yishi.proto.skytrial
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SkyTrialLayerMsg extends Message implements IExternalizable
   {
      
      public var layerNum:int;
      
      [ArrayElementType("com.road.yishi.proto.skytrial.SkyTrialPortalMsg")]
      public var portalList:Array = [];
      
      public function SkyTrialLayerMsg()
      {
         super();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         WriteUtils.writeTag(param1,0,1);
         WriteUtils.write$TYPE_INT32(param1,layerNum);
         _loc2_ = 0;
         while(_loc2_ < portalList.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,portalList[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:SkyTrialPortalMsg = null;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialLayerMsg.layerNum cannot be set twice.");
                  }
                  _loc4_++;
                  layerNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc3_ = new SkyTrialPortalMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  portalList.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
         if(_loc4_ != 1)
         {
            throw new IOError("Bad data format: SkyTrialLayerMsg.layerNum must be set.");
         }
      }
   }
}

