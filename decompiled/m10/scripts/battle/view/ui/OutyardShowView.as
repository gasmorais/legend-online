package battle.view.ui
{
   import battle.BattleManager;
   import battle.view.BattleView;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.hugehead.StackHeadBattleDefenceMsg;
   import com.road.yishi.proto.hugehead.StackHeadSeniorGeneralMsg;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import mainBar.effects.MainToolBtnGlowEffect;
   import manager.LanguageMgr;
   import yishi.events.NotificationEvent;
   import yishi.filter.UIFilter;
   import yishi.manager.NotificationManager;
   import yishi.manager.OutyardManager;
   
   public class OutyardShowView extends Component
   {
      
      private var _generalBmp1:Bitmap;
      
      private var _generalBmp2:Bitmap;
      
      private var _generalBmp3:Bitmap;
      
      private var _generalBmp4:Bitmap;
      
      private var _defenceBg:Bitmap;
      
      private var _progressMc:MovieClip;
      
      private var _leftArmyTxt:FilterFrameText;
      
      private var _guildArmyTxt:FilterFrameText;
      
      private var _filters:UIFilter;
      
      private var _colorManager1:MainToolBtnGlowEffect;
      
      private var _colorManager2:MainToolBtnGlowEffect;
      
      private var _colorManager3:MainToolBtnGlowEffect;
      
      private var _colorManager4:MainToolBtnGlowEffect;
      
      public function OutyardShowView()
      {
         super();
         initView();
         addEvent();
         layout();
      }
      
      private function initView() : void
      {
         _generalBmp1 = ComponentFactory.Instance.creatBitmap("asset.battle.generalBmp1");
         _generalBmp2 = ComponentFactory.Instance.creatBitmap("asset.battle.generalBmp2");
         _generalBmp3 = ComponentFactory.Instance.creatBitmap("asset.battle.generalBmp3");
         _generalBmp4 = ComponentFactory.Instance.creatBitmap("asset.battle.generalBmp4");
         _defenceBg = ComponentFactory.Instance.creatBitmap("asset.battle.defenceBg");
         _progressMc = ComponentFactory.Instance.creatCustomObject("battle.generalProgressMc");
         _leftArmyTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardShowView.leftArmyTxt");
         _guildArmyTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardShowView.guildArmyTxt");
         addChild(_generalBmp1);
         addChild(_generalBmp2);
         addChild(_generalBmp3);
         addChild(_generalBmp4);
         addChild(_defenceBg);
         addChild(_progressMc);
         addChild(_leftArmyTxt);
         addChild(_guildArmyTxt);
         _filters = new UIFilter();
         _colorManager1 = new MainToolBtnGlowEffect(_generalBmp1);
         _colorManager2 = new MainToolBtnGlowEffect(_generalBmp2);
         _colorManager3 = new MainToolBtnGlowEffect(_generalBmp3);
         _colorManager4 = new MainToolBtnGlowEffect(_generalBmp4);
      }
      
      private function addEvent() : void
      {
         addEventListener("enterFrame",__enterFrame);
         StageReferance.stage.addEventListener("resize",__stageResize);
         NotificationManager.instance.addEventListener("OUTYARD_BATTLE_DEFENCE",__battleDefenceHandler);
         __battleDefenceHandler(null);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("enterFrame",__enterFrame);
         StageReferance.stage.removeEventListener("resize",__stageResize);
         NotificationManager.instance.removeEventListener("OUTYARD_BATTLE_DEFENCE",__battleDefenceHandler);
      }
      
      private function __enterFrame(param1:Event) : void
      {
         var _loc2_:Number = Number(BattleManager.getInstance().battleModel.armyInfoRight.getLeftHp());
         if(_loc2_ <= 0)
         {
            BattleManager.getInstance().battleModel.isOver = true;
            NotificationManager.instance.sendNotification("FORCE_SKILL_ENABLE",false);
         }
      }
      
      private function __battleDefenceHandler(param1:NotificationEvent) : void
      {
         var _loc2_:StackHeadSeniorGeneralMsg = null;
         var _loc5_:Bitmap = null;
         var _loc3_:int = 0;
         var _loc4_:StackHeadBattleDefenceMsg = OutyardManager.instance.crystalModel.battleDefenceMsg;
         if(!_loc4_)
         {
            return;
         }
         var _loc6_:int = (_loc4_.defenceArmyTotal - _loc4_.defenceArmyAlive) / _loc4_.defenceArmyTotal * 100;
         _progressMc.gotoAndStop(_loc6_);
         _leftArmyTxt.text = LanguageMgr.GetTranslation("outyard.OutyardShowView.leftArmyTxt.text",_loc4_.defenceArmyAlive);
         _guildArmyTxt.text = LanguageMgr.GetTranslation("outyard.OutyardShowView.guildArmyTxt.text",100 - _loc4_.defenceProperty);
         _loc3_ = 0;
         while(_loc3_ < _loc4_.defenceSeniorGeneral.length)
         {
            _loc2_ = _loc4_.defenceSeniorGeneral[_loc3_] as StackHeadSeniorGeneralMsg;
            _loc5_ = this["_generalBmp" + _loc2_.index];
            _filters.setNormalFilter(_loc5_);
            if(_loc2_.alive)
            {
               if(_loc2_.inBattle)
               {
                  this["_colorManager" + _loc2_.index].play1();
               }
            }
            else
            {
               _filters.setGrayFilter(_loc5_);
            }
            _loc3_++;
         }
      }
      
      private function __stageResize(param1:Event) : void
      {
         layout();
      }
      
      private function layout() : void
      {
         var _loc1_:BattleView = BattleManager.getInstance().mainViewContainer.view;
         var _loc2_:Number = _loc1_.sceneWidth / 1500;
         this.x = _loc1_.sceneWidth - this.width - 300;
         this.y = 30;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_generalBmp1);
         _generalBmp1 = null;
         ObjectUtils.disposeObject(_generalBmp2);
         _generalBmp2 = null;
         ObjectUtils.disposeObject(_generalBmp3);
         _generalBmp3 = null;
         ObjectUtils.disposeObject(_generalBmp4);
         _generalBmp4 = null;
         ObjectUtils.disposeObject(_defenceBg);
         _defenceBg = null;
         ObjectUtils.disposeViolentMc(_progressMc);
         _progressMc = null;
         ObjectUtils.disposeObject(_leftArmyTxt);
         _leftArmyTxt = null;
         ObjectUtils.disposeObject(_guildArmyTxt);
         _guildArmyTxt = null;
         ObjectUtils.disposeObject(_filters);
         _filters = null;
         ObjectUtils.disposeObject(_colorManager1);
         _colorManager1 = null;
         ObjectUtils.disposeObject(_colorManager2);
         _colorManager2 = null;
         ObjectUtils.disposeObject(_colorManager3);
         _colorManager3 = null;
         ObjectUtils.disposeObject(_colorManager4);
         _colorManager4 = null;
         super.dispose();
      }
   }
}

