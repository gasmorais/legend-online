package cathouse.courtyard
{
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import yishi.datas.templates.CatHouseTemplateInfo;
   import yishi.manager.PathManager;
   
   public class CatAvatar extends BaseCatLoadObject
   {
      
      public static const STAND_FRAME_LABEL:String = "Stand";
      
      public static const SIT_0_FRAME_LABEL:String = "Attack01";
      
      public static const SIT_1_FRAME_LABEL:String = "Attack02";
      
      public static const SIT_2_FRAME_LABEL:String = "Attack03";
      
      public static const SIT_3_FRAME_LABEL:String = "Attack04";
      
      public static const SIT_4_FRAME_LABEL:String = "Attack05";
      
      private static const IDLE_LABEL_LIST:Array = ["Stand","Attack01","Attack04"];
      
      private var _goldDropNum:uint;
      
      private var _catMC:MovieClip;
      
      private var _curAction:String = "Stand";
      
      private var _curScaleX:int = 1;
      
      private var _toyType:int = -1;
      
      private var _scaleThreshold:uint;
      
      public function CatAvatar(param1:uint)
      {
         super();
         _scaleThreshold = param1;
      }
      
      public function get goldDropNum() : uint
      {
         return _goldDropNum;
      }
      
      override public function set x(param1:Number) : void
      {
         super.x = param1;
         setScaleX(x > _scaleThreshold ? -1 : 1);
      }
      
      override public function set templateInfo(param1:CatHouseTemplateInfo) : void
      {
         if(_templateInfo != param1)
         {
            _templateInfo = param1;
            if(_templateInfo != null)
            {
               toLoadAvatar(PathManager.resourcePath + "images" + templateInfo.Avatar + ".swf");
            }
         }
      }
      
      public function setActionByType(param1:uint) : void
      {
         _toyType = param1;
         _curAction = "Stand";
         switch(int(param1) - 101)
         {
            case 0:
            case 1:
               _curAction = IDLE_LABEL_LIST[Math.floor(IDLE_LABEL_LIST.length * Math.random())];
               break;
            case 2:
               _curAction = "Attack05";
               break;
            case 3:
               _curAction = Math.random() < 0.5 ? "Attack03" : "Attack02";
               break;
            case 4:
               _curAction = "Stand";
               setScaleX(-1);
         }
      }
      
      private function setAction() : void
      {
         if(_catMC != null)
         {
            _catMC.gotoAndPlay(_curAction);
         }
      }
      
      private function setScaleX(param1:int) : void
      {
         if(_toyType == 105)
         {
            param1 = -1;
         }
         _curScaleX = param1;
         if(_catMC != null)
         {
            _catMC.scaleX = _curScaleX;
         }
      }
      
      override protected function onLoadCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         var _loc4_:Class = null;
         var _loc3_:Bitmap = null;
         super.onLoadCompleteHandler(param1,param2);
         if(_curLoadedDisplayObject != null)
         {
            if(_curLoadedDisplayObject.loaderInfo.applicationDomain.hasDefinition("slg.resource.movie.MovieAsset"))
            {
               clearAvatar();
               _loc4_ = _curLoadedDisplayObject.loaderInfo.applicationDomain.getDefinition("slg.resource.movie.MovieAsset") as Class;
               _catMC = new _loc4_();
               if(_curLoadedDisplayObject.parent != null)
               {
                  _curLoadedDisplayObject.parent.removeChild(_curLoadedDisplayObject);
               }
               addChild(_catMC);
               _loc3_ = ComponentFactory.Instance.creatBitmap("asset.core.StandShadowAsset");
               _loc3_.x = -_loc3_.width * 0.5;
               _loc3_.y = -_loc3_.height * 0.5;
               _catMC.addChildAt(_loc3_,0);
               setAction();
               setScaleX(_curScaleX);
            }
         }
      }
      
      override public function clearAvatar() : void
      {
         if(_catMC != null)
         {
            ObjectUtils.disposeViolentMc(_catMC);
         }
         _catMC = null;
      }
   }
}

