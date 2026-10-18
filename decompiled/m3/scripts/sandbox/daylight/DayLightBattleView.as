package sandbox.daylight
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import mvc.controler.DayLightController;
   import sandbox.daylight.data.DayLightUnitInfo;
   import sandbox.net.DayLightOuterManager;
   import utils.LogicUtils;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.FrameControllerManager;
   
   public class DayLightBattleView extends Sprite implements Disposeable, IEnterFrame
   {
      
      public static const POS_X_MIN:int = 0;
      
      public static const POS_X_MAX:int = 504;
      
      public static const POS_X_SPEED:int = 36;
      
      public static const POS_X_DIFF:int = 36;
      
      public static const POS_Y_DIFF:int = 48;
      
      private var _sceneView:Sprite;
      
      private var _uiView:Sprite;
      
      private var _attackBtn1:BaseButton;
      
      private var _attackBtn2:BaseButton;
      
      private var _attackBtn3:BaseButton;
      
      private var _attackBtn4:BaseButton;
      
      private var _avatarDic:Dictionary = new Dictionary(true);
      
      private var _avatarList:Vector.<DayLightAvatarView> = new Vector.<DayLightAvatarView>();
      
      private var _avatarIdList:Array = [];
      
      private var _lastUpdateTime:Number = 0;
      
      private var _team:int;
      
      private var _controller:DayLightController = FrameControllerManager.instance.dayLightControler;
      
      private var _model:DayLightModel = _controller.model;
      
      public function DayLightBattleView(param1:int)
      {
         _team = param1;
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _sceneView = new Sprite();
         _uiView = new Sprite();
         _attackBtn1 = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightBattleView.attackBtn1");
         _attackBtn2 = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightBattleView.attackBtn2");
         _attackBtn3 = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightBattleView.attackBtn3");
         _attackBtn4 = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightBattleView.attackBtn4");
         _uiView.addChild(_attackBtn1);
         _uiView.addChild(_attackBtn2);
         _uiView.addChild(_attackBtn3);
         _uiView.addChild(_attackBtn4);
         addChild(_sceneView);
         addChild(_uiView);
         _lastUpdateTime = getTimer();
      }
      
      private function uninitView() : void
      {
         if(_attackBtn1)
         {
            ObjectUtils.disposeObject(_attackBtn1);
         }
         _attackBtn1 = null;
         if(_attackBtn2)
         {
            ObjectUtils.disposeObject(_attackBtn2);
         }
         _attackBtn2 = null;
         if(_attackBtn3)
         {
            ObjectUtils.disposeObject(_attackBtn3);
         }
         _attackBtn3 = null;
         if(_attackBtn4)
         {
            ObjectUtils.disposeObject(_attackBtn4);
         }
         _attackBtn4 = null;
         if(_sceneView)
         {
            ObjectUtils.disposeObject(_sceneView);
         }
         _sceneView = null;
         if(_uiView)
         {
            ObjectUtils.disposeObject(_uiView);
         }
         _sceneView = null;
         LogicUtils.disposeDisplayCollection(_avatarList);
         _avatarList = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function addEvent() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
         _attackBtn1.addEventListener("click",__attackBtnClickHandler);
         _attackBtn2.addEventListener("click",__attackBtnClickHandler);
         _attackBtn3.addEventListener("click",__attackBtnClickHandler);
         _attackBtn4.addEventListener("click",__attackBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         _attackBtn1.removeEventListener("click",__attackBtnClickHandler);
         _attackBtn2.removeEventListener("click",__attackBtnClickHandler);
         _attackBtn3.removeEventListener("click",__attackBtnClickHandler);
         _attackBtn4.removeEventListener("click",__attackBtnClickHandler);
      }
      
      private function __attackBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:BaseButton = param1.target as BaseButton;
         var _loc3_:int = 0;
         switch(_loc2_)
         {
            case _attackBtn1:
               _loc3_ = 0;
               break;
            case _attackBtn2:
               _loc3_ = 1;
               break;
            case _attackBtn3:
               _loc3_ = 2;
               break;
            case _attackBtn4:
               _loc3_ = 3;
         }
         DayLightOuterManager.attack(_loc3_);
      }
      
      public function addTestAvatar(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : void
      {
         var _loc7_:DayLightUnitInfo = null;
         _loc7_ = new DayLightUnitInfo();
         _loc7_.id = param1;
         _loc7_.x = param2;
         _loc7_.y = param3;
         _loc7_.type = param4;
         _loc7_.count = param5;
         _loc7_.speed = param6;
         addUnit(_loc7_);
      }
      
      public function addUnit(param1:DayLightUnitInfo) : void
      {
         var _loc2_:DayLightAvatarView = null;
         if(_avatarDic.hasOwnProperty(param1.id))
         {
            _loc2_ = _avatarDic[param1.id];
            _loc2_.data = param1;
            _loc2_.updateUnitInfo();
         }
         else
         {
            _loc2_ = new DayLightAvatarView(_team);
            _loc2_.data = param1;
            _loc2_.initUnitInfo();
            _loc2_.updateUnitPosition();
            _sceneView.addChild(_loc2_);
            _avatarDic[param1.id] = _loc2_;
            _avatarList.push(_loc2_);
            _avatarIdList.push(param1.id);
         }
      }
      
      public function removeUnitById(param1:int) : void
      {
         var _loc2_:DayLightAvatarView = null;
         var _loc3_:int = 0;
         if(_avatarDic.hasOwnProperty(param1))
         {
            _loc2_ = _avatarDic[param1];
            _loc3_ = _avatarList.indexOf(_loc2_);
            if(_loc3_ != -1)
            {
               _avatarList.splice(_loc3_,1);
            }
            _loc3_ = _avatarIdList.indexOf(param1);
            if(_loc3_ != -1)
            {
               _avatarIdList.splice(_loc3_,1);
            }
            delete _avatarDic[param1];
            ObjectUtils.disposeObject(_loc2_);
            _loc2_ = null;
         }
      }
      
      public function get avatarIdList() : Array
      {
         return _avatarIdList;
      }
      
      public function setUIVisible(param1:Boolean) : void
      {
         _uiView.visible = param1;
      }
      
      public function enterFrame() : void
      {
         var _loc2_:Number = getTimer();
         var _loc1_:Number = _loc2_ - _lastUpdateTime;
         _lastUpdateTime = _loc2_;
         if(_avatarList && _avatarList.length)
         {
            for each(var _loc3_:DayLightAvatarView in _avatarList)
            {
               _loc3_.update(_loc1_);
            }
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}

