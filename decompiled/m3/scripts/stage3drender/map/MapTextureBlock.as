package stage3drender.map
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.core.Disposeable;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.textures.Texture;
   
   public class MapTextureBlock implements Disposeable
   {
      
      public static var mDefaultTextureInstance:Texture = null;
      
      protected var intMapWidth:uint = 8960;
      
      protected var intMapHeight:uint = 6400;
      
      protected const intBlockWidth:uint = 512;
      
      protected const intBlockHeight:uint = 512;
      
      protected var intMaxBlockW:uint;
      
      protected var intMaxBlockH:uint;
      
      protected var mLocalX:int = -1;
      
      protected var mLocalY:int = -1;
      
      protected var mBlockContainer:Sprite = null;
      
      protected var mTextureBlock:Image = null;
      
      protected var mTextureInstance:Texture = null;
      
      protected var mBlockIndex:uint = 0;
      
      private var _index:int = 0;
      
      private var intMaxCacheCols:int;
      
      private var intMaxCacheRows:int;
      
      private var _blockToMapRect:Rectangle;
      
      private var _isDspose:Boolean = false;
      
      public function MapTextureBlock(param1:uint, param2:uint, param3:int, param4:int, param5:int)
      {
         super();
         intMaxCacheRows = param3;
         intMaxCacheCols = param4;
         _index = param5;
         intMapWidth = param1;
         intMapHeight = param2;
         intMaxBlockW = param1 / 512;
         intMaxBlockH = param2 / 512;
         if(!mDefaultTextureInstance)
         {
            mDefaultTextureInstance = Texture.empty(512,512);
         }
      }
      
      public function setBlockLocal(param1:int, param2:int, param3:Sprite, param4:Rectangle) : void
      {
         _blockToMapRect = param4;
         mBlockContainer = param3;
         mLocalX = param1;
         mLocalY = param2;
         refreshBlock();
      }
      
      protected function refreshBlock() : void
      {
         var _loc2_:String = null;
         mBlockIndex = mLocalY * intMaxBlockW + mLocalX;
         MapPiecesManager.instance.currentBlock.push(mBlockIndex);
         var _loc4_:int = mLocalX * 2;
         var _loc3_:int = mLocalY * 2;
         var _loc1_:String = mLocalX + "_" + mLocalY;
         if(MapPiecesManager.instance.mBlockTextureCache[mBlockIndex])
         {
            updateTexture();
         }
         else
         {
            _loc2_ = ComponentSetting.RESOURCE_PATH + "mapdataa/tile_" + _loc1_ + ".a";
            LoaderManagerII.instance.load(_loc2_,1,9,__completeHandler);
            if(!mTextureBlock)
            {
               mTextureBlock = new Image(mDefaultTextureInstance);
               mTextureBlock.touchable = false;
               mTextureBlock.pivotY = 0;
               mTextureBlock.pivotX = 0;
            }
            else
            {
               mTextureBlock.texture = mDefaultTextureInstance;
            }
            if(!mBlockContainer.contains(mTextureBlock))
            {
               mBlockContainer.addChild(mTextureBlock);
            }
            mTextureBlock.x = _blockToMapRect.x + _index % intMaxCacheCols * 512;
            mTextureBlock.y = _blockToMapRect.y + int(_index / intMaxCacheCols) * 512;
         }
      }
      
      private function __completeHandler(param1:LoaderInfo, param2:Object) : void
      {
         if(_isDspose || !Starling.current || !param2)
         {
            return;
         }
         updateTexture(param2);
      }
      
      protected function updateTexture(param1:Object = null) : void
      {
         if(!MapPiecesManager.instance.mBlockTextureCache[mBlockIndex])
         {
            param1.uncompress();
            mTextureInstance = Texture.fromAtfData(param1 as ByteArray);
            if(!mTextureBlock)
            {
               mTextureBlock = new Image(mTextureInstance);
               mTextureBlock.touchable = false;
               mTextureBlock.pivotY = 0;
               mTextureBlock.pivotX = 0;
            }
            else
            {
               mTextureBlock.texture = mTextureInstance;
            }
            if(!mBlockContainer.contains(mTextureBlock))
            {
               mBlockContainer.addChild(mTextureBlock);
            }
            mTextureBlock.x = _blockToMapRect.x + _index % intMaxCacheCols * 512;
            mTextureBlock.y = _blockToMapRect.y + int(_index / intMaxCacheCols) * 512;
            MapPiecesManager.instance.mBlockTextureCache[mBlockIndex] = mTextureInstance;
         }
         else
         {
            mTextureBlock.texture = MapPiecesManager.instance.mBlockTextureCache[mBlockIndex];
            mTextureBlock.x = _blockToMapRect.x + _index % intMaxCacheCols * 512;
            mTextureBlock.y = _blockToMapRect.y + int(_index / intMaxCacheCols) * 512;
         }
      }
      
      public function dispose() : void
      {
         _isDspose = true;
         for each(var _loc1_:Texture in MapPiecesManager.instance.mBlockTextureCache)
         {
            _loc1_.dispose();
         }
         if(mTextureBlock)
         {
            mTextureBlock.removeFromParent(true);
            mTextureBlock = null;
         }
         mTextureInstance = null;
         MapPiecesManager.instance.mBlockTextureCache = new Dictionary();
         _blockToMapRect = null;
         if(mDefaultTextureInstance)
         {
            mDefaultTextureInstance.dispose();
         }
         mDefaultTextureInstance = null;
      }
   }
}

