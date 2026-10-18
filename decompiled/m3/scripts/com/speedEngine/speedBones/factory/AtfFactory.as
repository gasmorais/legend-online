package com.speedEngine.speedBones.factory
{
   import com.speedEngine.speedBones.manager.RenderManager;
   import com.speedEngine.speedBones.model.SkeletonData;
   import com.speedEngine.speedBones.utils.CompressFormat;
   import com.speedEngine.speedBones.utils.FileHead;
   import com.speedEngine.speedBones.utils.VersionUtils;
   import flash.events.Event;
   import flash.utils.ByteArray;
   
   public class AtfFactory extends BaseFactory
   {
      
      protected var _helpFileBytes:ByteArray = new ByteArray();
      
      protected var _helpTmpBytes:ByteArray = new ByteArray();
      
      public function AtfFactory()
      {
         super();
      }
      
      override public function parseData(param1:ByteArray, param2:String) : SkeletonData
      {
         var _loc3_:uint = 0;
         param1.position = 0;
         var _loc5_:FileHead = VersionUtils.getReadHead(param1);
         if(_loc5_)
         {
            _loc3_ = 8;
            param1.position = 8;
            CompressFormat.setUnCompressFormat(_loc5_.compressType);
         }
         else
         {
            _loc3_ = 0;
            param1.position = 0;
            CompressFormat.setUnCompressFormat();
         }
         _helpFileBytes.length = 0;
         _helpTmpBytes.length = 0;
         param1.position = param1.length - 4;
         var _loc4_:uint = param1.readUnsignedInt();
         param1.position = param1.length - 4 - _loc4_;
         param1.readBytes(_helpTmpBytes,0,_loc4_);
         _helpTmpBytes.uncompress(CompressFormat.unCompressFormat);
         _helpFileBytes.writeBytes(_helpTmpBytes);
         _helpTmpBytes.length = 0;
         param1.position = _loc3_;
         _loc4_ = param1.length - (4 + _loc4_ + _loc3_);
         param1.readBytes(_helpTmpBytes,0,_loc4_);
         _helpTmpBytes.uncompress(CompressFormat.unCompressFormat);
         _helpFileBytes.writeBytes(_helpTmpBytes);
         _helpTmpBytes.length = 0;
         _helpFileBytes.position = 0;
         return parseSkeletonData(_helpFileBytes,param2);
      }
      
      override protected function parseTextureAtls(param1:ByteArray, param2:String = null) : void
      {
         currentSkeletonData.textureIndex = RenderManager.instance.createTexture(param1,param2);
         RenderManager.instance.stage.addEventListener("enterFrame",onNextFrame);
      }
      
      protected function onNextFrame(param1:Event) : void
      {
         RenderManager.instance.stage.removeEventListener("enterFrame",onNextFrame);
         this.dispatchEvent(new Event("complete"));
      }
      
      override public function dispose(param1:Boolean = true) : void
      {
         _helpFileBytes.clear();
         _helpFileBytes = null;
         _helpTmpBytes.clear();
         _helpTmpBytes = null;
         super.dispose(param1);
      }
   }
}

