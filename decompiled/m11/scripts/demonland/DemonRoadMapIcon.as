package demonland
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.manager.DemonLandManager;
   import yishi.utils.NumberViewUtils;
   import yishi.view.tips.MessageTipManager;
   
   public class DemonRoadMapIcon extends Component
   {
      
      public static const STATE_LOCK:int = 1;
      
      public static const STATE_PASS:int = 2;
      
      public static const STATE_CURRENT:int = 3;
      
      private var _txtLevel:FilterFrameText;
      
      private var _star2:ScaleFrameImage;
      
      private var _icon:ScaleFrameImage;
      
      private var _lightFilterStr:String = "core.DefaultFilter,core.LightFilter,core.DefaultFilter,core.GrayFilter";
      
      private var _lightFilter:Array;
      
      private var numBitmap:BitmapData;
      
      private var sp_num:Sprite;
      
      private var idx:int;
      
      private var myState:int;
      
      public function DemonRoadMapIcon(param1:int)
      {
         super();
         idx = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _txtLevel = ComponentFactory.Instance.creatComponentByStylename("DemonLand.DemonRoadMapIcon.txtLevel");
         addChild(_txtLevel);
         _star2 = ComponentFactory.Instance.creatComponentByStylename("DemonLand.DemonRoadMapIcon.star2");
         addChild(_star2);
         _icon = ComponentFactory.Instance.creatComponentByStylename("DemonLand.DemonRoadMapIcon.icon");
         addChild(_icon);
         _lightFilter = ComponentFactory.Instance.creatFrameFilters(_lightFilterStr);
         _icon.buttonMode = true;
         _txtLevel.mouseEnabled = false;
         numBitmap = ComponentFactory.Instance.creatBitmapData("asset.DemonLand.resource.main.num1");
         sp_num = new Sprite();
         addChild(sp_num);
         if(idx < 10)
         {
            sp_num.x = 29;
         }
         else
         {
            sp_num.x = 24;
         }
         sp_num.y = 27;
         NumberViewUtils.refreshValue(idx,sp_num,numBitmap,13,15,9,13,"0123456789");
         sp_num.mouseChildren = sp_num.mouseEnabled = false;
         _star2.setFrame(1);
      }
      
      public function setState(param1:int) : void
      {
         _icon.setFrame(param1);
         myState = param1;
         if(DemonLandManager.instance.model.maxChapterId > idx)
         {
            _star2.setFrame(2);
         }
      }
      
      private function addEvent() : void
      {
         _icon.addEventListener("click",onClickIcon);
         _icon.addEventListener("rollOver",onOverIcon);
         _icon.addEventListener("rollOut",onOutIcon);
      }
      
      private function removeEvent() : void
      {
         _icon.removeEventListener("click",onClickIcon);
         _icon.removeEventListener("rollOver",onOverIcon);
         _icon.removeEventListener("rollOut",onOutIcon);
      }
      
      protected function onClickIcon(param1:MouseEvent) : void
      {
         if(myState == 1)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("demonland.main.text3"));
            return;
         }
         DemonLandManager.instance.model.selectedChapter = idx;
         DemonLandManager.instance.sendEnterDemonLandChapter(idx);
      }
      
      protected function onOutIcon(param1:MouseEvent) : void
      {
         filters = _lightFilter[0];
      }
      
      protected function onOverIcon(param1:MouseEvent) : void
      {
         filters = _lightFilter[1];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_txtLevel);
         _txtLevel = null;
         ObjectUtils.disposeObject(_star2);
         _star2 = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(sp_num);
         sp_num = null;
         ObjectUtils.disposeObject(numBitmap);
         numBitmap = null;
         _lightFilter = null;
         super.dispose();
      }
   }
}

