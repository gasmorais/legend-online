package revenge.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   
   public class RevengeRoadView extends Sprite
   {
      
      public var _mapLock2:Image;
      
      public var _mapLock3:Image;
      
      public var _mapLock4:Image;
      
      public var _mapLock5:Image;
      
      public var _needTxt:FilterFrameText;
      
      public var _7bg:Bitmap;
      
      public var _desTxt:FilterFrameText;
      
      public var _map:MovieClip;
      
      public var _logo:Bitmap;
      
      public var _mainBack:MutipleImage;
      
      public var _bigBg:Bitmap;
      
      public var _fIcon:Image;
      
      public var _renewTip:Component;
      
      public function RevengeRoadView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _mapLock2 = ComponentFactory.Instance.creatComponentByStylename("ui.revengeroad.mapLock2");
         _mapLock3 = ComponentFactory.Instance.creatComponentByStylename("ui.revengeroad.mapLock3");
         _mapLock4 = ComponentFactory.Instance.creatComponentByStylename("ui.revengeroad.mapLock4");
         _mapLock5 = ComponentFactory.Instance.creatComponentByStylename("ui.revengeroad.mapLock5");
         _needTxt = ComponentFactory.Instance.creatComponentByStylename("ui.revengeroad.needTxt");
         _7bg = ComponentFactory.Instance.creatBitmap("asset.revengeroad.7bg");
         _desTxt = ComponentFactory.Instance.creatComponentByStylename("ui.revengeroad.desTxt");
         _map = ComponentFactory.Instance.creatCustomObject("asset.revengeroad.MapAreaContainer");
         _logo = ComponentFactory.Instance.creatBitmap("asset.revengeroad.logo");
         _mainBack = ComponentFactory.Instance.creatComponentByStylename("ui.revengeroad.mainBack");
         _bigBg = ComponentFactory.Instance.creatBitmap("asset.revengeroad.bigBg");
         _fIcon = ComponentFactory.Instance.creatComponentByStylename("ui.revengeroad.fIcon");
         _renewTip = ComponentFactory.Instance.creatCustomObject("revenge.renewTip");
         addChild(_bigBg);
         addChild(_mainBack);
         addChild(_logo);
         addChild(_map);
         addChild(_mapLock2);
         addChild(_mapLock3);
         addChild(_mapLock4);
         addChild(_mapLock5);
         addChild(_renewTip);
         addChild(_7bg);
         addChild(_desTxt);
         _renewTip.addChild(_fIcon);
         _renewTip.addChild(_needTxt);
         _needTxt.text = LanguageMgr.GetTranslation("revengeroad.main.text1");
         _desTxt.text = LanguageMgr.GetTranslation("revengeroad.main.text2");
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_mapLock2);
         _mapLock2 = null;
         ObjectUtils.disposeObject(_mapLock3);
         _mapLock3 = null;
         ObjectUtils.disposeObject(_mapLock4);
         _mapLock4 = null;
         ObjectUtils.disposeObject(_mapLock5);
         _mapLock5 = null;
         ObjectUtils.disposeObject(_needTxt);
         _needTxt = null;
         ObjectUtils.disposeObject(_7bg);
         _7bg = null;
         ObjectUtils.disposeObject(_desTxt);
         _desTxt = null;
         ObjectUtils.disposeViolentMc(_map);
         _map = null;
         ObjectUtils.disposeObject(_logo);
         _logo = null;
         ObjectUtils.disposeObject(_mainBack);
         _mainBack = null;
         ObjectUtils.disposeObject(_bigBg);
         _bigBg = null;
         ObjectUtils.disposeObject(_fIcon);
         _fIcon = null;
         ObjectUtils.disposeObject(_renewTip);
         _renewTip = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

