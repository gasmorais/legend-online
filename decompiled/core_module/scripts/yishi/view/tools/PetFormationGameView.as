package yishi.view.tools
{
   import battle.data.GameLoadNeedData;
   import battle.utils.Helpers;
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import manager.LanguageMgr;
   import managers.PetChallengeManager;
   import mvc.module.petchallenge.PetChallengeModel;
   
   public class PetFormationGameView extends Sprite implements Disposeable
   {
      
      public var extendData:*;
      
      public var onComplete:Function;
      
      public var onError:Function;
      
      private var _loader:Loader;
      
      private var _content:DisplayObject;
      
      private var _contentLoaderInfo:flash.display.LoaderInfo;
      
      private var _data:Object;
      
      private var _delayCompleteNextFrame:Boolean;
      
      private var _petChallengeModel:PetChallengeModel = PetChallengeManager.instance.model;
      
      public function PetFormationGameView(param1:Boolean = true)
      {
         super();
         _delayCompleteNextFrame = param1;
         _loader = new Loader();
         _loader.contentLoaderInfo.addEventListener("complete",__byteLoadComplete);
         _loader.contentLoaderInfo.addEventListener("ioError",onLoadByteIoError);
      }
      
      private function onLoadByteIoError(param1:IOErrorEvent) : void
      {
         __byteLoadComplete(null);
      }
      
      private function __byteLoadComplete(param1:Event) : void
      {
         if(!_data || !_loader)
         {
            return;
         }
         if(_data is GameLoadNeedData)
         {
            doGameLoadData();
         }
         else
         {
            if(_loader.content is MovieClip)
            {
               (_loader.content as MovieClip)["biaoji"] = _data.urlPath;
            }
            if(content && content.parent)
            {
               content.parent.removeChild(content);
            }
            if(content)
            {
               ObjectUtils.disposeObject(content);
               content = null;
            }
            content = _loader.content;
            _contentLoaderInfo = _loader.contentLoaderInfo;
            if(content && content.stage == null)
            {
               addChild(content);
            }
            dispatchComplete();
         }
         if(param1)
         {
            _loader.unloadAndStop(false);
         }
      }
      
      public function set data(param1:Object) : void
      {
         _data = param1;
         doData(_data);
      }
      
      private function doData(param1:Object) : void
      {
         var _loc4_:GameLoadNeedData = null;
         var _loc3_:Object = null;
         var _loc2_:String = null;
         _data = param1;
         if(content && content.parent)
         {
            content.parent.removeChild(content);
         }
         if(content)
         {
            ObjectUtils.disposeObject(content);
            content = null;
         }
         if(param1 is String)
         {
            LoaderManagerII.instance.load(String(param1),1,8,__onComplete);
         }
         else if(param1 is ByteArray)
         {
            __onComplete(null,param1);
         }
         else if(param1 is GameLoadNeedData)
         {
            _loc4_ = GameLoadNeedData(param1);
            if(_petChallengeModel.isLoaded(_loc4_.urlPath))
            {
               doGameLoadData();
               return;
            }
            if(_loc4_.defineClass == null)
            {
               _petChallengeModel.addSingleClassResourcePath(_loc4_.urlPath);
            }
            else
            {
               _petChallengeModel.addMultiClassResourcePath(_loc4_.urlPath);
            }
            LoaderManagerII.instance.load(_loc4_.urlPath,1,8,__onComplete);
         }
         else
         {
            if(param1 is DisplayObject)
            {
               content = param1 as DisplayObject;
            }
            else if(param1 is BitmapData)
            {
               content = new Bitmap(BitmapData(param1));
            }
            else
            {
               if(!(param1 is Class))
               {
                  _loc2_ = LanguageMgr.GetTranslation("battle.view.GameView.str");
                  throw new Error(_loc2_);
               }
               _loc3_ = new param1();
               doData(_loc3_);
            }
            dispatchComplete();
         }
         if(content && content.stage == null)
         {
            addChild(content);
         }
      }
      
      private function doGameLoadData() : void
      {
         var _loc1_:GameLoadNeedData = GameLoadNeedData(_data);
         try
         {
            if(_loc1_.defineClass == null)
            {
               content = DisplayObject(_petChallengeModel.getInstanceByPath(_loc1_.urlPath.toLowerCase(),_loc1_.type));
            }
            else
            {
               content = DisplayObject(_petChallengeModel.getInstanceByDefinition(_loc1_.defineClass));
            }
            if(content && content.stage == null)
            {
               addChild(content);
            }
         }
         catch(e:Error)
         {
            callBackFunction(onError);
            onError = null;
         }
         dispatchComplete();
      }
      
      private function __onComplete(param1:com.pickgliss.loader.data.LoaderInfo, param2:Object) : void
      {
         if(!param2 || !_loader)
         {
            dispatchComplete();
            return;
         }
         var _loc3_:ApplicationDomain = _petChallengeModel.getDomainByPaty(param1.url);
         var _loc4_:LoaderContext = new LoaderContext(false,_loc3_);
         if(DisplayLoader.isDebug)
         {
            _loc4_.allowCodeImport = true;
         }
         _loader.loadBytes(param2 as ByteArray,_loc4_);
      }
      
      private function dispatchComplete() : void
      {
         if(_delayCompleteNextFrame)
         {
            Helpers.delayCall(function():void
            {
               callBackFunction(onComplete);
               onComplete = null;
            });
         }
         else
         {
            callBackFunction(onComplete);
            onComplete = null;
         }
      }
      
      final public function callBackFunction(param1:Function) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.length > 0)
         {
            param1(this);
         }
         else
         {
            param1();
         }
      }
      
      public function dispose() : void
      {
         if(_loader && _loader.contentLoaderInfo)
         {
            _loader.contentLoaderInfo.removeEventListener("complete",__byteLoadComplete);
            _loader.contentLoaderInfo.removeEventListener("ioError",onLoadByteIoError);
            _loader.unloadAndStop(false);
         }
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__onComplete);
         _loader = null;
         ObjectUtils.cleanFrameScript(content as MovieClip);
         if(content is DisplayObjectContainer)
         {
            ObjectUtils.disposeViolentMc(content as DisplayObjectContainer);
         }
         else
         {
            ObjectUtils.disposeObject(content);
         }
         _content = null;
         if(_contentLoaderInfo && _contentLoaderInfo.loader)
         {
            _contentLoaderInfo.loader.unload();
            _contentLoaderInfo.loader.unloadAndStop(false);
         }
         _data = null;
         extendData = null;
         onComplete = null;
         onError = null;
         _contentLoaderInfo = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get content() : DisplayObject
      {
         return _content;
      }
      
      public function set content(param1:DisplayObject) : void
      {
         if(_content is MovieClip)
         {
            ObjectUtils.cleanFrameScript(_content as MovieClip);
         }
         ObjectUtils.disposeObject(_content);
         _content = param1;
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function get contentLoaderInfo() : flash.display.LoaderInfo
      {
         return _contentLoaderInfo;
      }
   }
}

