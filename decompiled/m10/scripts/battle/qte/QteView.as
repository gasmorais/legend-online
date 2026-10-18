package battle.qte
{
   import battle.BattleManager;
   import battle.net.BattleSocketOuterManager;
   import battle.view.roles.RoleViewBase;
   import battle.view.ui.SkillUseItemCell;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.Timer;
   import flash.utils.clearInterval;
   import flash.utils.setTimeout;
   import simplegame.qte.QTEComponent;
   import yishi.utils.IconFactory;
   
   public class QteView extends Sprite implements Disposeable
   {
      
      private static const QTE_NUM:int = 3;
      
      private static const QTE_EFFECT_BEGIN_TIME:int = 800;
      
      private static const QTE_EFFECT_END_TIME:int = 300;
      
      private var _timer:Timer;
      
      private var _timeView:QteTimeView;
      
      private var _time:int;
      
      private var _arr:Array;
      
      private var _isRight:Boolean;
      
      private var _skillUseView:SkillUseItemCell;
      
      private var _timeId:int;
      
      private var _timeId2:int;
      
      private var _qteNum:int;
      
      private var _qteCom:QTEComponent;
      
      public function QteView(param1:Array)
      {
         super();
         _arr = param1;
         time = int(param1[1]);
         _qteNum = _time / 1500;
         initView();
      }
      
      public function get time() : int
      {
         return _time;
      }
      
      public function set time(param1:int) : void
      {
         _time = param1;
         start();
         if(_timeId2 > 0)
         {
            clearInterval(_timeId2);
         }
         _timeId2 = 0;
         _timeId2 = setTimeout(showTimeView,800);
      }
      
      private function showTimeView() : void
      {
         _timeView.visible = true;
         _timeView.time = (_time - 800 - 300 - 100) / 1000;
      }
      
      public function start() : void
      {
         _timer = new Timer(time - 300 - 100);
         _timer.addEventListener("timer",__time);
         _timer.start();
      }
      
      private function initView() : void
      {
         _qteCom = new QTEComponent(_qteNum,qteComplete);
         _timeView = new QteTimeView();
         _timeView.y = -52;
         _timeView.visible = false;
         addChild(_timeView);
         mouseChildren = mouseEnabled = false;
         if(_arr && _arr.length > 0 && _arr[0])
         {
            _skillUseView = new SkillUseItemCell();
            if(_arr)
            {
               _skillUseView.data = IconFactory.getTecIconByIcon(_arr[0].Icons);
            }
            addChild(_skillUseView);
            _skillUseView.flash();
         }
         addChild(_qteCom);
         _timeView.x = _qteCom.getCenterPosX() - 30;
      }
      
      private function qteComplete() : void
      {
         _isRight = true;
         setEffect(true);
      }
      
      private function removeEvent() : void
      {
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__time);
         }
      }
      
      private function setEffect(param1:Boolean) : void
      {
         _qteCom.setEffect(param1);
         if(_skillUseView)
         {
            _skillUseView.tweenEffect(param1);
         }
         if(_timeId > 0)
         {
            clearInterval(_timeId);
         }
         _timeId = 0;
         _timeId = setTimeout(sent,400);
      }
      
      private function sent() : void
      {
         removeEvent();
         if(_isRight)
         {
            setUseSkillState();
            BattleSocketOuterManager.sendQTE(BattleManager.getInstance().battleModel.battleId);
         }
         dispose();
      }
      
      private function setUseSkillState() : void
      {
         var _loc2_:RoleViewBase = null;
         var _loc1_:Number = NaN;
         var _loc3_:Point = null;
         var _loc4_:Point = null;
         if(_qteCom)
         {
            _loc2_ = RoleViewBase(BattleManager.getInstance().battleMap.rolesDict[BattleManager.getInstance().battleModel.selfHero.livingId]);
            _loc1_ = Number(_qteCom.width);
            _loc3_ = this.parent.localToGlobal(new Point(this.x + _loc1_ * 0.5,this.y));
            _loc4_ = _loc2_.effectContainer.localToGlobal(new Point(0,-65));
            _loc2_.showQteSuccessEffect(_loc3_,_loc4_);
         }
      }
      
      override public function get width() : Number
      {
         if(_qteCom)
         {
            return _qteCom.width;
         }
         return super.width;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_timeId > 0)
         {
            clearInterval(_timeId);
         }
         _timeId = 0;
         if(_timeId2 > 0)
         {
            clearInterval(_timeId2);
         }
         _timeId2 = 0;
         ObjectUtils.disposeObject(_skillUseView);
         _skillUseView = null;
         ObjectUtils.disposeObject(_qteCom);
         _qteCom = null;
         ObjectUtils.disposeObject(_timeView);
         _timeView = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _arr = null;
         _timer = null;
      }
      
      protected function __time(param1:Event) : void
      {
         setEffect(false);
      }
   }
}

