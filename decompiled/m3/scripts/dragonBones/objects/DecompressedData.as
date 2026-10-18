package dragonBones.objects
{
   import flash.utils.ByteArray;
   
   public final class DecompressedData
   {
      
      public var skeletonXML:XML;
      
      public var textureAtlasXML:XML;
      
      public var textureBytes:ByteArray;
      
      public function DecompressedData(param1:XML, param2:XML, param3:ByteArray)
      {
         super();
         this.skeletonXML = param1;
         this.textureAtlasXML = param2;
         this.textureBytes = param3;
      }
      
      public function dispose() : void
      {
         this.skeletonXML = null;
         this.textureAtlasXML = null;
         this.textureBytes = null;
      }
   }
}

