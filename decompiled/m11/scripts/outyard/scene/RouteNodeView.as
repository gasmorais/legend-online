package outyard.scene
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.hugehead.HugeHeadNodeBattleAreaMsg;
   import com.road.yishi.proto.hugehead.HugeHeadNodeBattleFieldMsg;
   import com.road.yishi.proto.hugehead.HugeHeadNodeBattleUserMsg;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.OutyardManager;
   
   public class RouteNodeView extends Component
   {
      
      private var _routeOccupy:ScaleFrameImage;
      
      private var _leftHead:ScaleFrameImage;
      
      private var _rightHead:ScaleFrameImage;
      
      private var _attackBtn:BaseButton;
      
      private var _defenceBtn:BaseButton;
      
      private var _nodeNumBg1:ScaleBitmapImage;
      
      private var _nodeNumBg2:ScaleBitmapImage;
      
      private var _leftNumTxt1:FilterFrameText;
      
      private var _leftNumTxt2:FilterFrameText;
      
      private var _defenceMc:MovieClip;
      
      private var _personCon:Component;
      
      private var _info:HugeHeadNodeBattleAreaMsg;
      
      private var _battleFieldMsg:HugeHeadNodeBattleFieldMsg;
      
      private var _battleSelfMsg:HugeHeadNodeBattleUserMsg;
      
      public function RouteNodeView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _battleFieldMsg = OutyardManager.instance.model.battleNodeMsg;
         _battleSelfMsg = OutyardManager.instance.model.battleSelfMsg;
         _routeOccupy = ComponentFactory.Instance.creatComponentByStylename("outyard.routeOccupy");
         _leftHead = ComponentFactory.Instance.creatComponentByStylename("outyard.routeOccupyHead");
         _rightHead = ComponentFactory.Instance.creatComponentByStylename("outyard.routeOccupyHead");
         _attackBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.RouteNodeView.attackBtn");
         _defenceBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.RouteNodeView.defenceBtn");
         _nodeNumBg1 = ComponentFactory.Instance.creatComponentByStylename("outyard.nodeNumBg1");
         _nodeNumBg2 = ComponentFactory.Instance.creatComponentByStylename("outyard.nodeNumBg2");
         _leftNumTxt1 = ComponentFactory.Instance.creatComponentByStylename("outyard.RouteNodeView.leftNumTxt");
         _leftNumTxt2 = ComponentFactory.Instance.creatComponentByStylename("outyard.RouteNodeView.leftRighrTxt");
         _defenceMc = ComponentFactory.Instance.creatCustomObject("asset.outyard.defenceMc");
         _personCon = new Component();
         addChild(_routeOccupy);
         addChild(_personCon);
         addChild(_leftHead);
         _leftHead.x = -101;
         _leftHead.y = -128;
         addChild(_rightHead);
         _rightHead.x = 31;
         _rightHead.y = -128;
         addChild(_attackBtn);
         addChild(_defenceBtn);
         addChild(_nodeNumBg1);
         addChild(_nodeNumBg2);
         addChild(_leftNumTxt1);
         addChild(_leftNumTxt2);
         addChild(_defenceMc);
         _leftHead.setFrame(_battleFieldMsg.attackForce);
         _rightHead.setFrame(_battleFieldMsg.defenceForce);
         _leftNumTxt1.setFrame(_battleFieldMsg.attackForce);
         _leftNumTxt2.setFrame(_battleFieldMsg.defenceForce);
         _attackBtn.visible = false;
         _defenceBtn.visible = false;
         _defenceMc.visible = false;
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("ROUTE_BATTLE_FIELD",__battleFieldHandler);
         NotificationManager.instance.addEventListener("ROUTE_SELF_USER",__selfUserHandler);
         _attackBtn.addEventListener("click",__attackClickHandler);
         _defenceBtn.addEventListener("click",__defenceClickHandler);
         _routeOccupy.addEventListener("click",__routeBgHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("ROUTE_BATTLE_FIELD",__battleFieldHandler);
         NotificationManager.instance.removeEventListener("ROUTE_SELF_USER",__selfUserHandler);
         if(_attackBtn)
         {
            _attackBtn.removeEventListener("click",__attackClickHandler);
         }
         if(_defenceBtn)
         {
            _defenceBtn.removeEventListener("click",__defenceClickHandler);
         }
         if(_routeOccupy)
         {
            _routeOccupy.removeEventListener("click",__routeBgHandler);
         }
      }
      
      private function __battleFieldHandler(param1:NotificationEvent) : void
      {
         info = _info;
      }
      
      private function __selfUserHandler(param1:NotificationEvent) : void
      {
         info = _info;
      }
      
      private function __attackClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         NotificationManager.instance.dispatchEvent(new NotificationEvent("ROUTE_NODE_ATTACK"));
      }
      
      private function __defenceClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         OutyardManager.instance.OperateRoute(6);
      }
      
      private function __routeBgHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         NotificationManager.instance.dispatchEvent(new NotificationEvent("ROUTE_NEXT_CLICK",this));
      }
      
      public function set info(param1:HugeHeadNodeBattleAreaMsg) : void
      {
         var _loc2_:int = 0;
         _info = param1;
         _leftNumTxt1.text = LanguageMgr.GetTranslation("outyard.scene.RouteNodeView.attackCount",_info.attackCount);
         _leftNumTxt2.text = LanguageMgr.GetTranslation("outyard.scene.RouteNodeView.attackCount",_info.defenceCount);
         _leftHead.visible = _leftNumTxt1.visible = _nodeNumBg1.visible = _info.attackCount > 0;
         _rightHead.visible = _leftNumTxt2.visible = _nodeNumBg2.visible = _info.defenceCount > 0;
         if(_info.pos == 10 || _info.pos == 11)
         {
            _personCon.y = 0;
            _info.pos == 10 ? _routeOccupy.setFrame(6) : _routeOccupy.setFrame(7);
            _leftNumTxt1.visible = false;
            _leftNumTxt2.visible = false;
            _leftHead.visible = false;
            _rightHead.visible = false;
            _nodeNumBg1.visible = false;
            _nodeNumBg2.visible = false;
            _attackBtn.visible = false;
            _defenceBtn.visible = false;
         }
         else
         {
            _personCon.y = 0;
            _info.belongForce == 0 ? _routeOccupy.setFrame(5) : _routeOccupy.setFrame(_info.belongForce);
            _attackBtn.visible = false;
            _defenceBtn.visible = false;
            _defenceMc.visible = false;
            if(_battleSelfMsg.pos == _info.pos)
            {
               _loc2_ = int(_battleSelfMsg.side == 1 ? _battleFieldMsg.attackForce : int(_battleFieldMsg.defenceForce));
               if(_info.belongForce == 0)
               {
                  _attackBtn.visible = true;
               }
               else if(_info.belongForce == _loc2_)
               {
                  _defenceBtn.visible = !_battleSelfMsg.inGuard;
                  _defenceMc.visible = _battleSelfMsg.inGuard;
               }
               else if(_info.belongForce != _loc2_)
               {
                  _attackBtn.visible = true;
               }
            }
         }
      }
      
      public function clearState() : void
      {
         _attackBtn.visible = false;
         _defenceBtn.visible = false;
         _defenceMc.visible = false;
         while(_personCon.numChildren)
         {
            _personCon.removeChildAt(0);
         }
      }
      
      public function get personCon() : Component
      {
         return _personCon;
      }
      
      public function get info() : HugeHeadNodeBattleAreaMsg
      {
         return _info;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_routeOccupy);
         _routeOccupy = null;
         ObjectUtils.disposeObject(_leftHead);
         _leftHead = null;
         ObjectUtils.disposeObject(_rightHead);
         _rightHead = null;
         ObjectUtils.disposeObject(_attackBtn);
         _attackBtn = null;
         ObjectUtils.disposeObject(_defenceBtn);
         _defenceBtn = null;
         ObjectUtils.disposeObject(_nodeNumBg1);
         _nodeNumBg1 = null;
         ObjectUtils.disposeObject(_nodeNumBg2);
         _nodeNumBg2 = null;
         ObjectUtils.disposeObject(_leftNumTxt1);
         _leftNumTxt1 = null;
         ObjectUtils.disposeObject(_leftNumTxt2);
         _leftNumTxt2 = null;
         ObjectUtils.disposeViolentMc(_defenceMc);
         _defenceMc = null;
         ObjectUtils.disposeObject(_personCon);
         _personCon = null;
         _info = null;
         _battleFieldMsg = null;
         _battleSelfMsg = null;
         super.dispose();
      }
   }
}

