package outyard.shuttle
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PetHallowsManager;
   
   public class OutyardLevelItem extends Component
   {
      
      private var _container:Component;
      
      private var _brightBmp:Bitmap;
      
      private var _levelBg:ScaleFrameImage;
      
      private var _chainBmp:Bitmap;
      
      private var _levelTxt:ScaleFrameImage;
      
      private var _index:int;
      
      private var _selected:Boolean;
      
      private var _enable:Boolean;
      
      public function OutyardLevelItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _container = ComponentFactory.Instance.creatCustomObject("outyard.shuttle.titleItemContain");
         _brightBmp = ComponentFactory.Instance.creatBitmap("asset.outyard.title.brightBmp");
         _levelBg = ComponentFactory.Instance.creatComponentByStylename("outyard.level.levelBg");
         _chainBmp = ComponentFactory.Instance.creatBitmap("asset.outyard.level.chainBmp");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.level.levelTxt");
         addChild(_container);
         _container.addChild(_brightBmp);
         _container.addChild(_levelBg);
         _container.addChild(_chainBmp);
         _container.addChild(_levelTxt);
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__onClickHandler);
         addEventListener("rollOver",__onOverHandler);
         addEventListener("rollOut",__onOutHandler);
         NotificationManager.instance.addEventListener("CLICK_SHUTTLE_TITLE",__clickTitleHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__onClickHandler);
         removeEventListener("rollOver",__onOverHandler);
         removeEventListener("rollOut",__onOutHandler);
         NotificationManager.instance.removeEventListener("CLICK_SHUTTLE_TITLE",__clickTitleHandler);
      }
      
      public function set index(param1:int) : void
      {
         _index = param1;
         _levelBg.setFrame(param1);
         _levelTxt.setFrame(param1);
         var _loc2_:Array = PetHallowsManager.instance.model.hallowsInfoList;
         if(_index - 1 > _loc2_.length)
         {
            this.filters = null;
            _chainBmp.visible = true;
            _enable = false;
         }
         else
         {
            this.filters = null;
            _chainBmp.visible = false;
            _enable = true;
         }
         if(index != 1)
         {
            this.tipData = LanguageMgr.GetTranslation("outyard.OutyardLevelItem.lockTips",index - 1);
         }
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         if(_selected)
         {
            _container.y = -10;
            _brightBmp.visible = true;
         }
         else
         {
            _container.y = 0;
            _brightBmp.visible = false;
         }
      }
      
      private function __clickTitleHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = int(param1.data);
         if(_loc2_ == _index)
         {
            selected = true;
         }
         else
         {
            selected = false;
         }
      }
      
      private function __onClickHandler(param1:MouseEvent) : void
      {
         if(!_enable)
         {
            return;
         }
         if(_selected)
         {
            return;
         }
         SoundManager.instance.play("022");
         FrameControllerManager.instance.outyardControler.refreshBtnClick(_index);
      }
      
      private function __onOverHandler(param1:MouseEvent) : void
      {
         if(!_enable)
         {
            return;
         }
         if(_selected)
         {
            return;
         }
         _container.y = -10;
         _brightBmp.visible = true;
      }
      
      private function __onOutHandler(param1:MouseEvent) : void
      {
         if(!_enable)
         {
            return;
         }
         if(_selected)
         {
            return;
         }
         _container.y = 0;
         _brightBmp.visible = false;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_container);
         _container = null;
         ObjectUtils.disposeObject(_brightBmp);
         _brightBmp = null;
         ObjectUtils.disposeObject(_levelBg);
         _levelBg = null;
         ObjectUtils.disposeObject(_chainBmp);
         _chainBmp = null;
         ObjectUtils.disposeObject(_levelTxt);
         _levelTxt = null;
         super.dispose();
      }
   }
}

