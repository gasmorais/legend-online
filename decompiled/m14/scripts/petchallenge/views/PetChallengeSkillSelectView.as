package petchallenge.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import yishi.datas.templates.SkillTempInfo;
   
   public class PetChallengeSkillSelectView extends Component
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _hBox:HBox;
      
      private var _callBack:Function;
      
      public function PetChallengeSkillSelectView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("PetChallengeSkillSelectView.bg");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("PetChallengeSkillSelectView.hBox");
         addChild(_bg);
         addChild(_hBox);
         _bg.mouseChildren = _bg.mouseEnabled = false;
         _hBox.mouseEnabled = false;
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
      }
      
      public function show(param1:Array, param2:Function) : void
      {
         var _loc3_:PetChallengeSkillView = null;
         _callBack = param2;
         for each(var _loc4_:SkillTempInfo in param1)
         {
            _loc3_ = ComponentFactory.Instance.creatCustomObject("petchallenge.PetChallengeSkillView",[-1]);
            _loc3_.setIconSize(50,50);
            _loc3_.mouseChildren = false;
            _loc3_.data = _loc4_;
            _hBox.addChild(_loc3_);
         }
         _bg.width = _hBox.x * 2 + _hBox.width;
         addEvent();
         LayerManager.Instance.addToLayer(this,7);
      }
      
      private function addEvent() : void
      {
         this.addEventListener("click",__mouseClickHandler);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("click",__mouseClickHandler);
      }
      
      private function __mouseClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:PetChallengeSkillView = null;
         if(param1.target is PetChallengeSkillView)
         {
            _loc2_ = param1.target as PetChallengeSkillView;
         }
         if(_loc2_ && _callBack != null)
         {
            _callBack(_loc2_.data);
         }
         dispose();
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         removeEvent();
         uintView();
         super.dispose();
         _callBack = null;
      }
   }
}

