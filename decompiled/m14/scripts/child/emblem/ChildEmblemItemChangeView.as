package child.emblem
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.children.PosMsg;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildModel;
   import mvc.module.children.ChildSender;
   import utils.LogicUtils;
   import yishi.filter.UIFilter;
   import yishi.utils.MsgMan;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildEmblemItemChangeView extends Component
   {
      
      private var _data:Object;
      
      private var _up:IconButton;
      
      private var _centerBtn:IconButton;
      
      private var _centerResiBall:Image;
      
      private var _resiBtns:Array;
      
      private var _circle:Image;
      
      private var _filter:UIFilter;
      
      private var _ball:Image;
      
      public function ChildEmblemItemChangeView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:IconButton = null;
         _filter = new UIFilter();
         _circle = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemTabView.circle");
         _up = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemItemChangeView.upBtn");
         addChild(_circle);
         addChild(_up);
         _resiBtns = [];
         _centerBtn = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemTabView.BallBtn");
         _centerBtn.x = -22;
         _centerBtn.y = -22;
         addChild(_centerBtn);
         _loc1_ = 2;
         while(_loc1_ <= 7)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemItemChangeView.resi" + _loc1_ + "Btn");
            _loc2_.addEventListener("click",resiBtnClickHandle);
            _loc2_.isFollowMouse = false;
            _loc2_.tipStyle = "yishi.view.tips.OneLineTip";
            _loc2_.tipDirctions = "2,1";
            _loc2_.tipData = LanguageMgr.GetTranslation("planesRewardTip.resistance.typeText" + _loc1_);
            _resiBtns.push(_loc2_);
            addChild(_loc2_);
            _loc1_++;
         }
      }
      
      protected function resiBtnClickHandle(param1:MouseEvent) : void
      {
         var _loc2_:Array = null;
         var _loc4_:PosMsg = null;
         var _loc3_:Array = null;
         var _loc5_:IconButton = param1.target as IconButton;
         if(_data.resiType == 0)
         {
            _loc2_ = [];
            _loc4_ = new PosMsg();
            _loc4_.property = _resiBtns.indexOf(_loc5_) + 2;
            _loc4_.order = _data.order;
            _loc2_.push(_loc4_);
            _loc3_ = [];
            if(_loc2_.length <= 0)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("child.emblem.ChildEmblemChangeView.noSelected"));
               return;
            }
            if(_data.alreadySelect.indexOf(_loc4_.property) != -1)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("child.emblem.ChildEmblemChangeView.hasSelectAlert"));
               return;
            }
            ChildSender.emblemSelect(model.selectedChild.childId,_data.pos,_loc2_);
         }
         else if(_data.alreadySelect.indexOf(_resiBtns.indexOf(_loc5_) + 2) > -1)
         {
            ChildSender.emblemExchange(model.selectedChild.childId,_data.pos,_data.order,_data.alreadySelect.indexOf(_resiBtns.indexOf(_loc5_) + 2));
         }
         else
         {
            ChildSender.emblemChange(model.selectedChild.childId,_data.pos,_data.order,_resiBtns.indexOf(_loc5_) + 2);
         }
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_up);
         _up = null;
         ObjectUtils.disposeObject(_centerBtn);
         _centerBtn = null;
         ObjectUtils.disposeObject(_centerResiBall);
         _centerResiBall = null;
         LogicUtils.disposeDisplayCollection(_resiBtns);
         _resiBtns = null;
         ObjectUtils.disposeObject(_circle);
         _circle = null;
         ObjectUtils.disposeObject(_ball);
         _ball = null;
         _data = null;
         _filter = null;
      }
      
      public function set data(param1:Object) : void
      {
         _data = param1;
         refreshView();
      }
      
      public function refreshView() : void
      {
         var _loc2_:int = 0;
         _centerResiBall && _centerResiBall.parent && _centerResiBall.parent.removeChild(_centerResiBall);
         if(_data.resiType == 0)
         {
            _up.enable = false;
         }
         else
         {
            _centerResiBall = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemTabView.resi" + _data.resiType + "2");
            _centerResiBall.mouseEnabled = false;
            _centerResiBall.mouseChildren = false;
            _centerResiBall.x = -23;
            _centerResiBall.y = -21;
            addChild(_centerResiBall);
            _up.enable = true;
         }
         var _loc1_:Array = _data.alreadySelect as Array;
         _loc2_ = 0;
         while(_loc2_ < _resiBtns.length)
         {
            if(_data.resiType == _loc2_ + 2)
            {
               _resiBtns[_loc2_].enable = false;
            }
            else
            {
               _resiBtns[_loc2_].enable = true;
            }
            _loc2_++;
         }
      }
      
      private function __ballBtnHandler(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         MsgMan.notifyObserver("ChildEvent.EMBLEM_BALL_CLICK",this);
      }
      
      private function upBtnClickHandle(param1:MouseEvent) : void
      {
         this.visible = false;
         this.parent && (this.parent as ChildEmblemTabView).maskClickHandle(null);
         var _loc2_:Object = {
            "pos":_data.pos,
            "index":_data.order
         };
         ChildManager.instance.openEmblemUpView(_loc2_);
      }
      
      private function initEvent() : void
      {
         _centerBtn.addEventListener("click",centerBtnClickHandle);
         _up.addEventListener("click",upBtnClickHandle);
      }
      
      private function removeEvent() : void
      {
         _centerBtn.removeEventListener("click",centerBtnClickHandle);
         _up.removeEventListener("click",upBtnClickHandle);
      }
      
      protected function centerBtnClickHandle(param1:MouseEvent) : void
      {
         this.visible = false;
         this.parent && (this.parent as ChildEmblemTabView).maskClickHandle(null);
      }
      
      public function set pos(param1:int) : void
      {
         if(param1 < 0 || param1 > 14)
         {
            return;
         }
         refreshView();
      }
      
      private function __ballClickHandler(param1:String, param2:Object) : void
      {
      }
      
      private function get model() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uintView();
         super.dispose();
      }
   }
}

