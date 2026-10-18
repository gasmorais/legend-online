package map.campaign.view.ui.emedream
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import managers.MonopolySocketOutManager;
   import yishi.datas.templates.SkillTempInfo;
   
   public class EmeDreamSkillSelectView extends Component
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _hBox:HBox;
      
      private var _callBack:Function;
      
      private var _cancelBtn:IconButton;
      
      private var _teamItemView:EmeDreamTeamItemView;
      
      public function EmeDreamSkillSelectView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("warlordsroom.WarlordsSkillSelectView.bg");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("warlordsroom.WarlordsSkillSelectView.hBox");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("warlordsroom.WarlordsSkillSelectView.cancelBtn");
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
         ObjectUtils.disposeObject(_cancelBtn);
         _cancelBtn = null;
         ObjectUtils.disposeObject(_teamItemView);
         _teamItemView = null;
         ObjectUtils.disposeAllChildren(this);
         _callBack = null;
      }
      
      private function addEvent() : void
      {
         this.addEventListener("click",__mouseClickHandler);
         _cancelBtn.addEventListener("click",__cancelBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("click",__mouseClickHandler);
         _cancelBtn.removeEventListener("click",__cancelBtnClickHandler);
      }
      
      private function __mouseClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:EmeDreamSkillView = null;
         if(param1.target is EmeDreamSkillView)
         {
            _loc2_ = param1.target as EmeDreamSkillView;
         }
         if(_loc2_ && _callBack != null)
         {
            _callBack(_loc2_.data);
         }
         dispose();
      }
      
      private function __cancelBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc5_:int = 0;
         var _loc4_:SkillTempInfo = null;
         var _loc3_:Array = _teamItemView.teamItemSkillList;
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            if(_loc3_[_loc5_] == _teamItemView.currentSelectedItem.data)
            {
               _loc3_[_loc5_] = null;
            }
            _loc5_++;
         }
         var _loc7_:Array = [];
         var _loc6_:int = 0;
         for each(_loc4_ in _loc3_)
         {
            _loc6_ = int(_teamItemView.data.changeSkillTemplates.indexOf(_loc4_));
            _loc7_.push(_loc6_);
            _loc4_ = null;
         }
         var _loc2_:String = _loc7_.join(",");
         if(_teamItemView.data.petConsortiaSkillsOfString != _loc2_)
         {
            _teamItemView.data.petConsortiaSkillsOfString = _loc2_;
            MonopolySocketOutManager.sendPetSkills(_teamItemView.data.petId,_loc2_);
         }
         _teamItemView.currentSelectedItem.data = null;
      }
      
      public function show(param1:Array, param2:Function, param3:Boolean, param4:EmeDreamTeamItemView) : void
      {
         var _loc5_:EmeDreamSkillView = null;
         var _loc6_:SkillTempInfo = null;
         var _loc7_:int = 0;
         _callBack = param2;
         _loc7_ = 0;
         while(_loc7_ < param1.length)
         {
            _loc6_ = param1[_loc7_] as SkillTempInfo;
            _loc5_ = new EmeDreamSkillView(_loc7_);
            _loc5_.tipStyle = "yishi.view.tips.goods.SkillTips";
            _loc5_.tipDirctions = "4,1,6,5,2,7,0,3";
            _loc5_.isFollowMouse = false;
            _loc5_.setIconSize(50,50);
            _loc5_.mouseChildren = false;
            _loc5_.data = _loc6_;
            _hBox.addChild(_loc5_);
            _loc7_++;
         }
         if(param3)
         {
            _hBox.addChild(_cancelBtn);
            _teamItemView = param4;
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

