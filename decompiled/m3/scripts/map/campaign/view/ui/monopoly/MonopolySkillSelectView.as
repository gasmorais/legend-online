package map.campaign.view.ui.monopoly
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import yishi.datas.templates.SkillTempInfo;
   
   public class MonopolySkillSelectView extends Component
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _hBox:HBox;
      
      private var _callBack:Function;
      
      public function MonopolySkillSelectView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolySkillSelectView.bg");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolySkillSelectView.hBox");
         addChild(_bg);
         addChild(_hBox);
         _bg.mouseChildren = _bg.mouseEnabled = false;
         _hBox.mouseEnabled = false;
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         ObjectUtils.disposeAllChildren(this);
         _callBack = null;
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
         var _loc2_:MonopolySkillView = null;
         if(param1.target is MonopolySkillView)
         {
            _loc2_ = param1.target as MonopolySkillView;
         }
         if(_loc2_ && _callBack != null)
         {
            _callBack(_loc2_.data);
         }
         dispose();
      }
      
      public function show(param1:Array, param2:Function) : void
      {
         var _loc3_:MonopolySkillView = null;
         var _loc4_:SkillTempInfo = null;
         var _loc5_:int = 0;
         _callBack = param2;
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            _loc4_ = param1[_loc5_] as SkillTempInfo;
            _loc3_ = new MonopolySkillView(_loc5_);
            _loc3_.tipStyle = "yishi.view.tips.goods.SkillTips";
            _loc3_.tipDirctions = "4,1,6,5,2,7,0,3";
            _loc3_.isFollowMouse = false;
            _loc3_.setIconSize(50,50);
            _loc3_.mouseChildren = false;
            _loc3_.data = _loc4_;
            _hBox.addChild(_loc3_);
            _loc5_++;
         }
         _bg.width = _hBox.x * 2 + _hBox.width;
         addEvent();
         LayerManager.Instance.addToLayer(this,7);
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

