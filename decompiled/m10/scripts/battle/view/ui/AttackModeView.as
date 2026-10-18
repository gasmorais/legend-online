package battle.view.ui
{
   import battle.BattleManager;
   import battle.events.BattleEvent;
   import battle.net.BattleSocketOuterManager;
   import battle.view.ui.attackmode.AttackModeButton;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import org.aswing.KeyboardManager;
   import yishi.datas.BattleModel;
   import yishi.events.RoleEvent;
   import yishi.manager.NotificationManager;
   
   public class AttackModeView extends Sprite implements Disposeable
   {
      
      private static const CD_TIME:int = 7;
      
      private var _attackBtn:AttackModeButton;
      
      private var _defenseBtn:AttackModeButton;
      
      private var _currentBtn:AttackModeButton;
      
      private var _coolDownTxt:FilterFrameText;
      
      private var _coldDownPic:DisplayObject;
      
      public function AttackModeView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _attackBtn = ComponentFactory.Instance.creatComponentByStylename("battle.AttackBtn");
         var _loc1_:String = LanguageMgr.GetTranslation("public.attack1");
         _attackBtn.modeName = _loc1_;
         _defenseBtn = ComponentFactory.Instance.creatComponentByStylename("battle.DefenseBtn");
         var _loc2_:String = LanguageMgr.GetTranslation("battle.view.ui.AttackModeView.defenseBtnModeName");
         _defenseBtn.modeName = _loc2_;
         _coolDownTxt = ComponentFactory.Instance.creatComponentByStylename("battle.CoolDownTimeTxt");
         _coldDownPic = ComponentFactory.Instance.creatComponentByStylename("battle.ColdDownButton");
         _attackBtn.setKeyValue("Z");
         _attackBtn.tipData = [LanguageMgr.GetTranslation("battle.view.ui.AttackModeView.attackBtn.tipData01") + LanguageMgr.GetTranslation("public.parentheses2","Z"),LanguageMgr.GetTranslation("battle.view.ui.AttackModeView.attackBtn.tipData02")];
         _defenseBtn.setKeyValue("X");
         _defenseBtn.tipData = [LanguageMgr.GetTranslation("battle.view.ui.AttackModeView.defenseBtn.tipData01") + LanguageMgr.GetTranslation("public.parentheses2","X"),LanguageMgr.GetTranslation("battle.view.ui.AttackModeView.defenseBtn.tipData02")];
         addChild(_attackBtn);
         addChild(_defenseBtn);
         addChild(_coolDownTxt);
         addChild(_coldDownPic);
         _coldDownPic.visible = false;
         _coolDownTxt.visible = false;
         if(!visible || !battleModel.selfHero.isLiving)
         {
            _attackBtn.enable = _defenseBtn.enable = false;
         }
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeObject(_attackBtn);
         _attackBtn = null;
         ObjectUtils.disposeObject(_defenseBtn);
         _defenseBtn = null;
         ObjectUtils.disposeObject(_coolDownTxt);
         _coolDownTxt = null;
         ObjectUtils.disposeObject(_coldDownPic);
         _coldDownPic = null;
      }
      
      private function addEvent() : void
      {
         _attackBtn.addEventListener("click",__onAttackModelChange);
         _defenseBtn.addEventListener("click",__onAttackModelChange);
         battleModel.addEventListener("actionCountChange",onActionCountChange);
         KeyboardManager.getInstance().addEventListener("keyDown",onKeyDown);
         BattleManager.getInstance().battleModel.selfHero.addEventListener("die",onHeroDieEvent);
      }
      
      private function onHeroDieEvent(param1:RoleEvent) : void
      {
         param1.target.removeEventListener("die",onHeroDieEvent);
         _attackBtn.enable = _defenseBtn.enable = false;
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
         if(!_attackBtn.enable)
         {
            return;
         }
         if(param1.charCode == 122)
         {
            setMode(2);
         }
         else if(param1.charCode == 120)
         {
            setMode(1);
         }
      }
      
      private function removeEvent() : void
      {
         _attackBtn.removeEventListener("click",__onAttackModelChange);
         _defenseBtn.removeEventListener("click",__onAttackModelChange);
         battleModel.removeEventListener("actionCountChange",onActionCountChange);
         KeyboardManager.getInstance().removeEventListener("keyDown",onKeyDown);
         BattleManager.getInstance().battleModel.selfHero.removeEventListener("die",onHeroDieEvent);
      }
      
      private function __onAttackModelChange(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(_currentBtn == param1.currentTarget)
         {
            return;
         }
         _currentBtn = param1.currentTarget as AttackModeButton;
         switch(param1.currentTarget)
         {
            case _attackBtn:
               _loc2_ = 2;
               break;
            case _defenseBtn:
               _loc2_ = 1;
         }
         setMode(_loc2_);
      }
      
      private function setMode(param1:int) : void
      {
         if(!visible || !battleModel.selfHero.isLiving)
         {
            return;
         }
         if(battleModel.isAutoFight)
         {
            return;
         }
         battleModel.setAttackModelById(battleModel.selfHero.livingId,param1);
         var _loc2_:String = battleModel.battleId;
         battleModel.actionCount = 0;
         battleModel.attackModeStart = true;
         updateCdValue(0);
         BattleSocketOuterManager.sendFightMode(_loc2_,param1);
         _defenseBtn.enable = false;
         _attackBtn.enable = false;
         if(param1 == 2)
         {
            _attackBtn.selected = true;
            _defenseBtn.visible = false;
         }
         else
         {
            _defenseBtn.selected = true;
            _attackBtn.visible = false;
         }
         NotificationManager.instance.sendNotification("battleModeChange",param1);
      }
      
      private function onActionCountChange(param1:BattleEvent) : void
      {
         updateCdValue(battleModel.actionCount);
      }
      
      private function updateCdValue(param1:int) : void
      {
         var _loc2_:int = 0;
         if(param1 > 1 && param1 < 7)
         {
            _defenseBtn.visible = _attackBtn.visible = false;
            _coldDownPic.visible = true;
            _coolDownTxt.visible = true;
            _coolDownTxt.text = LanguageMgr.GetTranslation("battle.view.ui.AttackModeView.coolDownTxt.text") + (7 - param1);
         }
         else if(param1 < 2)
         {
            _loc2_ = 7 - 5 - param1;
            _attackBtn.setTurnValue(_loc2_);
            _defenseBtn.setTurnValue(_loc2_);
         }
         if(param1 == 7)
         {
            coolDownComplete();
         }
      }
      
      private function coolDownComplete() : void
      {
         _defenseBtn.enable = _defenseBtn.visible = true;
         _attackBtn.enable = _attackBtn.visible = true;
         _defenseBtn.selected = false;
         _attackBtn.selected = false;
         _coldDownPic.visible = false;
         _coolDownTxt.visible = false;
         _currentBtn = null;
         battleModel.attackModeStart = false;
         battleModel.setAttackModelById(battleModel.selfHero.livingId,0);
      }
      
      private function get battleModel() : BattleModel
      {
         return BattleManager.getInstance().battleModel;
      }
      
      public function getLeftPoint() : Point
      {
         return new Point(_attackBtn.x,_attackBtn.y);
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

