package remainsexplore
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.remainsexplore.RemainsExploreModel;
   import yishi.datas.ConfigInfoManager;
   import yishi.filter.UIFilter;
   import yishi.manager.RemainsExploreManager;
   import yishi.utils.NoviceBtnGlowEffect;
   
   public class RemainsExploreBoxItem extends Component
   {
      
      public static const DEFAULT:int = 0;
      
      public static const OPEN:int = 1;
      
      public static const CLOSE:int = 2;
      
      private var _back:ScaleFrameImage;
      
      private var _activeText:FilterFrameText;
      
      private var _index:int;
      
      private var _disEffect:NoviceBtnGlowEffect;
      
      private var _activeConfigArr:Array;
      
      private var _type:int = 1;
      
      private var _isWeek:Boolean;
      
      private var _sendIndex:int;
      
      public function RemainsExploreBoxItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         tipStyle = "yishi.view.tips.OneLineTip";
         tipDirctions = "7";
         tipGapV = 40;
         isFollowMouse = false;
         _activeText = ComponentFactory.Instance.creatComponentByStylename("ActiveBoxItem.activeText");
         addChild(_activeText);
      }
      
      private function initEvent() : void
      {
         addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__clickHandler);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         RemainsExploreManager.instance.sendBox(_type,_index);
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
         var _loc2_:Array = [];
         if(_type == 1)
         {
            _loc2_ = ConfigInfoManager.instance.getRemainsDayBoxValues();
         }
         else
         {
            _loc2_ = ConfigInfoManager.instance.getRemainsWeekBoxValues();
         }
         var _loc3_:int = int(_loc2_[_index - 1]);
         _activeText.text = LanguageMgr.GetTranslation("dayGuide.ActiveBoxText.text",_loc3_);
      }
      
      public function set index(param1:int) : void
      {
         _index = param1;
         _back = ComponentFactory.Instance.creatComponentByStylename("dayGuide.ActiveBoxImg");
         _disEffect = new NoviceBtnGlowEffect(_back,9);
         _back.setFrame(param1);
         addChildAt(_back,0);
      }
      
      public function set state(param1:int) : void
      {
         removeEvent();
         buttonMode = false;
         _disEffect.stop();
         this.filters = [];
         if(param1 == 1)
         {
            buttonMode = true;
            _disEffect.play();
            initEvent();
         }
         else if(param1 == 2)
         {
            this.filters = [UIFilter.getBlackFilter()];
         }
      }
      
      private function get model() : RemainsExploreModel
      {
         return RemainsExploreManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_activeText);
         _activeText = null;
         ObjectUtils.disposeObject(_disEffect);
         _disEffect = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

